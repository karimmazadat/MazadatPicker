//
//  ImageViewExtension.swift
//  TestCamera
//
//  Created by Karim Saad on 06/11/2022.
//

import Foundation
import UIKit
extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
  func saveImage(name:String)->URL{
    var fileName = getDocumentsDirectory().appendingPathComponent(name)
    if let data = pngData() {
      try? data.write(to: fileName)
      print(fileName.path)
      
     
    }
    return fileName
  }
  
  func getDocumentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0]
  }
}
