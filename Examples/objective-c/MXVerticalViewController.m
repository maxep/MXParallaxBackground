// MXVerticalViewController.m
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

#import "MXVerticalViewController.h"
#import "MXParallaxBackground.h"

@interface MXVerticalViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation MXVerticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPages];
    
    MXParallaxBackground *land = [MXParallaxBackground new];
    land.view = [NSBundle.mainBundle loadNibNamed:@"Land" owner:self options:nil].firstObject;
    land.intensity = 0.80;
    [self.scrollView addBackground:land];
    
    MXParallaxBackground *clouds1 = [MXParallaxBackground new];
    clouds1.view = [NSBundle.mainBundle loadNibNamed:@"Clouds1" owner:self options:nil].firstObject;
    clouds1.intensity = 0.5;
    [self.scrollView addBackground:clouds1];
    
    MXParallaxBackground *clouds2 = [MXParallaxBackground new];
    clouds2.view = [NSBundle.mainBundle loadNibNamed:@"Clouds2" owner:self options:nil].firstObject;
    clouds2.intensity = 0.25;
    clouds2.reverse = YES;
    
    [self.scrollView bringBackgroundToFront:land];
    [self.scrollView insertBackground:clouds2 belowBackground:land];
}

- (void)loadPages {
    NSMutableDictionary *views = [NSMutableDictionary new];
    NSMutableString *hFormat = [NSMutableString stringWithString:@"V:|"];
    
    for (NSInteger i = 0; i < 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"Balloon%li", (i + 1)];
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.scrollView addSubview:imageView];
        
        views[imageName] = imageView;
        NSString *vFormat = [NSString stringWithFormat:@"H:|[%@]|", imageName];
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:views]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                    attribute:NSLayoutAttributeCenterX
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.scrollView
                                                                    attribute:NSLayoutAttributeCenterX
                                                                   multiplier:1
                                                                     constant:0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:0]];
        [hFormat appendFormat:@"[%@]", imageName];
    }
    
    [hFormat appendString:@"|"];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views]];
}

@end
