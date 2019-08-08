// MXVerticalViewController.swift
//
// Copyright (c) 2019 Maxime Epain
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
        land.view = Bundle.main.loadNibNamed("Land", owner: self, options: nil)?[0] as? UIView
        land.intensity = 0.80
        self.scrollView.add(background: land)
        
        let clouds1 = MXParallaxBackground()
        clouds1.view = Bundle.main.loadNibNamed("Clouds1", owner: self, options: nil)?[0] as? UIView
        clouds1.intensity = 0.5
        self.scrollView.add(background: clouds1)
        
        let clouds2 = MXParallaxBackground()
        clouds2.view = Bundle.main.loadNibNamed("Clouds2", owner: self, options: nil)?[0] as? UIView
        clouds2.intensity = 0.25
        clouds2.isReverse = true
        
        scrollView.bringBackground(toFront: land)
        scrollView.insert(background: clouds2, below: land)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func loadPages() {
        var views = Dictionary<String,UIView>()
        var format  = "V:|"
        
        for i in 1...3 {
            let imageName = "Balloon\(i)"
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName);
            imageView.contentMode = .center
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(imageView)
            
            views[imageName] = imageView
            scrollView.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[\(imageName)]|",
                    options: .directionLeadingToTrailing,
                    metrics: nil,
                    views: views
                )
            )
            
            scrollView.addConstraint( NSLayoutConstraint(
                item: imageView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: scrollView,
                attribute: .centerX,
                multiplier: 1,
                constant: 0)
            )
            
            view.addConstraint( NSLayoutConstraint(
                item: imageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: view,
                attribute: .height,
                multiplier: 1,
                constant: 0)
            )
            
            format += "[\(imageName)]"
        }
        
        format += "|"
        scrollView.addConstraints( NSLayoutConstraint.constraints(
            withVisualFormat: format,
            options: .directionLeadingToTrailing,
            metrics: nil,
            views: views)
        )
    }
}
