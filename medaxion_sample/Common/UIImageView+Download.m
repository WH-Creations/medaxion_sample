//
//  UIImageView+Download.m
//  medaxion_sample
//
//  Created by Casey West on 11/10/23.
//

#import "UIImageView+Download.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

//This is a mirror(ish) of the UIImageView extension for handling cached images and loading from the network. The main difference here is due to the lack of task cancellation support. It is more of a headache in objective-c, we could create an associated object with a key and use that to track/cancel the download via a secondary function (in theory)

// Global image cache
static NSCache *imageCache;

@implementation UIImageView (Download)

+ (void)initialize {
    imageCache = [[NSCache alloc] init];
}

- (void)downloadFromServerObjC:(NSString *)link completion:(void (^)(NSError *error))completion {
    NSURL *url = [NSURL URLWithString:link];
    if (!url) {
        if (completion) {
            NSError *error = [NSError errorWithDomain:@"Invalid URL" code:-1 userInfo:nil];
            completion(error);
        }
        return;
    }

    UIImage *cachedImage = [imageCache objectForKey:link];
    if (cachedImage) {
        self.image = cachedImage;
        if (completion) completion(nil);
        return;
    }

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) completion(error);
            });
            return;
        }

        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                [imageCache setObject:image forKey:link];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                    if (completion) completion(nil);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        NSError *error = [NSError errorWithDomain:@"Image data error" code:-1 userInfo:nil];
                        completion(error);
                    }
                });
            }
        }
    }];

    [task resume];
}

@end
