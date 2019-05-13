//
//  ViewController.swift
//  OpenCVDemo
//
//  Created by Ankit on 22/03/19.
//  Copyright © 2019 Ankit Kargathra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    let img = UIImage.init(named: "image1.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let imageView = UIImageView.init(frame: self.view.bounds)
//        imageView.contentMode = .scaleAspectFit
//        self.view.addSubview(imageView)
//        let openVCWrapper = OpenCVWrapper()
//        imageView.image = openVCWrapper.isThisWorking(UIImage.init(named: "image1.jpg")!)
        imageView.image = img!
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self.imageView)
            let imgX = point.x / self.imageView.frame.size.width
            let imgy = point.y / self.imageView.frame.size.height
            let imagePoint = CGPoint.init(x: CGFloat.init(img!.cgImage!.width) * imgX, y:  CGFloat.init(img!.cgImage!.height) * imgy)
            let openVCWrapper = OpenCVWrapper()
            imageView.image = openVCWrapper.isThisWorking(img!, point: imagePoint)
        }
    }
}
