// MXHorizontalViewController.swift
//
// Copyright (c) 2015 Maxime Epain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import MXParallaxBackground

class MXHorizontalViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPages()
        
        // Sets backgrounds
        let clouds1 = MXParallaxBackground()
        clouds1.view = Bundle.main.loadNibNamed("Clouds1", owner: self, options: nil)?[0] as? UIView
        clouds1.intensity = 0.25
        self.scrollView.add(clouds1)
        
        let clouds2 = MXParallaxBackground()
        clouds2.view = Bundle.main.loadNibNamed("Clouds2", owner: self, options: nil)?[0] as? UIView
        clouds2.intensity = 0.5
        clouds2.isReverse = true
        self.scrollView.add(clouds2)
        
        self.scrollView.bringBackground(toFront: clouds2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func loadPages() {
        var views = Dictionary<String,UIView>()
        var format  = "H:|"
        
        for i in 1...3 {
            let imageName = "Balloon\(i)"
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName);
            imageView.contentMode = UIViewContentMode.center
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.scrollView.addSubview(imageView)
            
            views[imageName] = imageView
            self.scrollView.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[\(imageName)]|",
                    options: .directionLeadingToTrailing,
                    metrics: nil,
                    views: views
                )
            )
            
            self.scrollView.addConstraint(
                NSLayoutConstraint(
                    item: imageView,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem:
                    self.scrollView,
                    attribute: .centerY,
                    multiplier: 1,
                    constant: 0
                )
            )
            
            self.view .addConstraint(
                NSLayoutConstraint(
                    item: imageView,
                    attribute: .width,
                    relatedBy: .equal,
                    toItem: self.view,
                    attribute: .width,
                    multiplier: 1,
                    constant: 0
                )
            )
            
            format += "[\(imageName)]"
        }
        
        format += "|"
        self.scrollView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: format,
                options: .directionLeadingToTrailing,
                metrics: nil,
                views: views
            )
        )
    }
}

