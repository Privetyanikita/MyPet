//
//  UIImage+Ext.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 12.03.25.
//

import UIKit
import ImageIO

extension UIImage {
    static func animatedImage(withGIFData data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        let frameCount = CGImageSourceGetCount(source)
        var frames: [UIImage] = []
        var gifDuration = 0.0
        
        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            
            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil),
               let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
               let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) {
                gifDuration += frameDuration.doubleValue
            }
            
            let frameImage = UIImage(cgImage: cgImage)
            frames.append(frameImage)
        }
        
        let animatedImage = UIImage.animatedImage(with: frames, duration: gifDuration)
        return animatedImage
    }
}
