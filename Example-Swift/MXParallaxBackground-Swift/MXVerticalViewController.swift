// MXVerticalViewController.swift
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

class MXVerticalViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPages()
        
        // Sets backgrounds
        let land = MXParallaxBackground()
        land.view = NSBundle.mainBundle().loadNibNamed("Land", owner: self, options: nil)[0] as? UIView
        land.intensity = 0.80
        self.scrollView.addBackground(land)
        
        let clouds1 = MXParallaxBackground()
        clouds1.view = NSBundle.mainBundle().loadNibNamed("Clouds1", owner: self, options: nil)[0] as? UIView
        clouds1.intensity = 0.5
        self.scrollView.addBackground(clouds1)
        
        let clouds2 = MXParallaxBackground()
        clouds2.view = NSBundle.mainBundle().loadNibNamed("Clouds2", owner: self, options: nil)[0] as? UIView
        clouds2.intensity = 0.25
        clouds2.reverse = true
        
        self.scrollView.bringBackgroundToFront(land)
        self.scrollView.insertBackground(clouds2, belowBackground: land)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadPages() {
        var views = Dictionary<String,UIView>()
        var format  = "V:|"
        
        for i in 1...3 {
            let imageName = "Balloon\(i)"
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName);
            imageView.contentMode = UIViewContentMode.Center
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.scrollView.addSubview(imageView)
            
            views[imageName] = imageView
            self.scrollView.addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat(
                    "H:|[\(imageName)]|",
                    options: NSLayoutFormatOptions.DirectionLeadingToTrailing,
                    metrics: nil,
                    views: views
                )
            )
            
            self.scrollView.addConstraint(
                NSLayoutConstraint(
                    item: imageView,
                    attribute: NSLayoutAttribute.CenterX,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem:
                    self.scrollView,
                    attribute: NSLayoutAttribute.CenterX,
                    multiplier: 1,
                    constant: 0
                )
            )
            
            self.view .addConstraint(
                NSLayoutConstraint(
                    item: imageView,
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: self.view,
                    attribute: NSLayoutAttribute.Height,
                    multiplier: 1,
                    constant: 0
                )
            )
            
            format += "[\(imageName)]"
        }
        
        format += "|"
        self.scrollView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                format,
                options: NSLayoutFormatOptions.DirectionLeadingToTrailing,
                metrics: nil,
                views: views
            )
        )
    }
}

