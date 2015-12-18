// MXBalloonsViewController.m
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

#import "MXBalloonsViewController.h"
#import "MXParallaxBackground.h"

@interface MXBalloonsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation MXBalloonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPages];
    
    // Sets backgrounds
    MXParallaxBackground *clouds1 = [MXParallaxBackground new];
    clouds1.view = [NSBundle.mainBundle loadNibNamed:@"Clouds1" owner:self options:nil].firstObject;
    clouds1.intensity = 0.25;
    [self.scrollView addBackground:clouds1];
    
    MXParallaxBackground *clouds2 = [MXParallaxBackground new];
    clouds2.view = [NSBundle.mainBundle loadNibNamed:@"Clouds2" owner:self options:nil].firstObject;
    clouds2.intensity = 0.5;
    clouds2.reverse = YES;
    [self.scrollView addBackground:clouds2];
    
    [self.scrollView bringBackgroundToFront:clouds2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadPages {
    NSMutableDictionary *views = [NSMutableDictionary new];
    NSMutableString *hFormat = [NSMutableString stringWithString:@"H:|"];
    
    for (NSInteger i = 0; i < 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"Balloon%li", (i + 1)];
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.scrollView addSubview:imageView];
        
        [views setObject:imageView forKey:imageName];
        NSString *vFormat = [NSString stringWithFormat:@"V:|[%@]|", imageName];
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:views]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1
                                                               constant:0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:1
                                                               constant:0]];
        
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
//                                                              attribute:NSLayoutAttributeHeight
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.view
//                                                              attribute:NSLayoutAttributeHeight
//                                                             multiplier:0.5
//                                                               constant:0]];
        
        [hFormat appendFormat:@"[%@]", imageName];
    }
    
    [hFormat appendString:@"|"];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views]];
}

@end
