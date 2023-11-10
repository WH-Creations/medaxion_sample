//
//  Extensions+String.swift
//  medaxion_sample
//
//  Created by Casey West on 11/10/23.
//

import Foundation
import CommonCrypto

extension String {
    
    /**
     - Convert timestamp and both API keys to a 128-bit hash value for validation on Marvel API endpoint
     */
    var md5: String {
        
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
        
    }
    
}
