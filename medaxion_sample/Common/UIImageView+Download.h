//
//  UIImageView+Download.h
//  medaxion_sample
//
//  Created by Casey West on 11/10/23.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Download)

- (void)downloadFromServerObjC:(NSString *)link completion:(void (^)(NSError *error))completion;

@end

