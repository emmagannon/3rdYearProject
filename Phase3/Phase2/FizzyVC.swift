//
//  FizzyVC.swift
//  LetterWritingCheker
//
//  Created by Emma Gannon on 10/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit

class FizzyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var width: CGFloat
        var height: CGFloat
        
        let imageData = NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("IntroFinal", withExtension: "gif")!)
        let imageGif = UIImage.gifWithData(imageData!)
        let imageView = UIImageView(image: imageGif)
        width = CGRectGetWidth(self.view.bounds)
        height = CGRectGetHeight(self.view.bounds)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
