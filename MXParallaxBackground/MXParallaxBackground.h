// MXParallaxBackground.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The MXParallaxBackground class represents a parallax background for UIScrollView.
 */
@interface MXParallaxBackground : NSObject

/**
 The parent scroll-view.
 */
@property (nonatomic,readonly,nullable) UIScrollView *parentview;

/**
 The background view.
 */
@property (nonatomic,strong,nullable) UIView *view;

/**
 The parallax effect intensity. [0-1], 0.5 by default.
 */
@property (nonatomic) CGFloat intensity;

/**
 Reverse the parallax effect.
 */
@property (nonatomic,getter=isReverse) BOOL reverse;

/**
 Remove the background from the super view.
 */
- (void)removeFromSuperview;

@end

/**
 A UIScrollView category with a MXParallaxBackground stack.
 */
@interface UIScrollView (MXParallaxBackground)

/**
 The background array.
 */
@property(nonatomic,readonly, copy) NSArray<__kindof MXParallaxBackground *> *backgrounds;

/**
 Adds a background on top of others backgrounds.
 
 @param background The background to add.
 */
- (void)addBackground:(MXParallaxBackground *)background;

/**
 Inserts a background at a specific index.
 
 @param background The background to insert.
 @param index      The index of the background in the view stack.
 */
- (void)insertBackground:(MXParallaxBackground *)background atIndex:(NSInteger)index;

/**
 Inserts a background below a sibling background.
 
 @param background        The background to insert.
 @param siblingBackground The sibling background.
 */
- (void)insertBackground:(MXParallaxBackground *)background belowBackground:(MXParallaxBackground *)siblingBackground;

/**
 Inserts a background above a sibling  background.
 
 @param background        The background to insert.
 @param siblingBackground The sibling background.
 */
- (void)insertBackground:(MXParallaxBackground *)background aboveBackground:(MXParallaxBackground *)siblingBackground;

/**
 Inserts a background below a sibling view.
 
 @param background     The background to insert.
 @param siblingSubview The sibling background view.
 */
- (void)insertBackground:(MXParallaxBackground *)background belowSubview:(UIView *)siblingSubview;

/**
 Inserts a background above a sibling view.
 
 @param background     The background to insert.
 @param siblingSubview The sibling background view.
 */
- (void)insertBackground:(MXParallaxBackground *)background aboveSubview:(UIView *)siblingSubview;

/**
 Brings the background to the front of the subview stack.
 
 @param background The background to bring back.
 */
- (void)bringBackgroundToFront:(MXParallaxBackground *)background;

/**
 Sends the background to the back of the subview stack.
 
 @param background The background to send back.
 */
- (void)sendBackgroundToBack:(MXParallaxBackground *)background;

@end

NS_ASSUME_NONNULL_END
