// MXParallaxBackground.m
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

#import <objc/runtime.h>
#import "MXParallaxBackground.h"

CGFloat MXInterval(CGFloat value, CGFloat min, CGFloat max) {
    if (value < min)
        return min;
    else if (value > max)
        return max;
    return value;
}

@interface UIScrollView ()
@property (nonatomic,strong,readonly) NSMutableArray *stack;
@end

@interface MXBackgroundView : UIScrollView
@property (nonatomic,weak) MXParallaxBackground *parent;
@end

@implementation MXBackgroundView

static void * const kMXParallaxBackgroundKVOContext = (void*)&kMXParallaxBackgroundKVOContext;

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.superview removeObserver:self.parent
                        forKeyPath:NSStringFromSelector(@selector(contentOffset))
                           context:kMXParallaxBackgroundKVOContext];
}

- (void)didMoveToSuperview {
    [self.superview addObserver:self.parent
                     forKeyPath:NSStringFromSelector(@selector(contentOffset))
                        options:NSKeyValueObservingOptionNew
                        context:kMXParallaxBackgroundKVOContext];
}

@end

@interface MXParallaxBackground ()
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,strong) MXBackgroundView *backgroundView;
@end

@implementation MXParallaxBackground

- (instancetype)init {
    if (self = [super init]) {
        self.intensity = .5;
    }
    return self;
}

- (void)removeFromSuperview {
    [self.backgroundView removeFromSuperview];
    [self.scrollView.stack removeObject:self];
    self.scrollView = nil;
}

- (void)layoutBackground {
    
    CGRect frame = self.scrollView.frame;
    //Vector between scroll view's frame size and content size
    CGVector v1 = CGVectorMake(self.scrollView.contentSize.width - frame.size.width, self.scrollView.contentSize.height - frame.size.height);
    //Size of the view
    CGSize size = CGSizeMake(v1.dx * self.intensity + frame.size.width, v1.dy * self.intensity + frame.size.height);
    
    //Layout background view always on screen
    frame.origin = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
    self.backgroundView.frame = frame;
    self.backgroundView.contentSize = size;
    
    //Layout view
    frame.origin = CGPointZero;
    frame.size = size;
    self.view.frame = frame;
    
    //Vector between background view's frame size and content size
    CGVector v2 = CGVectorMake((size.width - self.scrollView.frame.size.width), (size.height - self.scrollView.frame.size.height));
    
    //Compute background's content offset
    CGFloat x = v2.dx * self.scrollView.contentOffset.x / (v1.dx?: 1);
    CGFloat y = v2.dy * self.scrollView.contentOffset.y / (v1.dy?: 1);
    
    //Reverse content offset
    if (self.isReverse) {
        x = v2.dx - x;
        y = v2.dy - y;
    }
    
    //No bouncing
    x = MXInterval(x, 0, v2.dx);
    y = MXInterval(y, 0, v2.dy);
    
    self.backgroundView.contentOffset = CGPointMake(x, y);
}

#pragma mark Properties

- (MXBackgroundView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [MXBackgroundView new];
        _backgroundView.parent = self;
        _backgroundView.bounces = NO;
        _backgroundView.userInteractionEnabled = NO;
    }
    return _backgroundView;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    [self layoutBackground];
}

- (UIScrollView *)parentview {
    return self.scrollView;
}

- (void)setView:(UIView *)view {
    if (view != _view) {
        [_view removeFromSuperview];
        [self.backgroundView addSubview:view];
        _view = view;
        
        [self layoutBackground];
    }
}

- (void)setIntensity:(CGFloat)intensity {
    _intensity = MXInterval(intensity, 0, 1);
    [self layoutBackground];
}

- (void)setReverse:(BOOL)reverse {
    _reverse = reverse;
    [self layoutBackground];
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context == kMXParallaxBackgroundKVOContext) {
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(contentOffset))]) {
            [self layoutBackground];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end

@implementation UIScrollView (MXParallaxBackground)

- (NSMutableArray *)stack {
    NSMutableArray *stack = objc_getAssociatedObject(self, @selector(stack));
    if (!stack) {
        stack = [NSMutableArray new];
        objc_setAssociatedObject(self, @selector(stack), stack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return stack;
}

- (NSArray<MXParallaxBackground *> *)backgrounds {
    return self.stack.copy;
}

- (void)addBackgroundToStack:(MXParallaxBackground *)background {
    background.scrollView = self;
    
    if ([self.stack containsObject:background]) {
        [self.stack removeObject:background];
    }
    
    NSInteger index = MXInterval([self.subviews indexOfObject:background.backgroundView], 0, self.stack.count);
    [self.stack insertObject:background atIndex:index];
}

- (void)insertBackground:(MXParallaxBackground *)background atIndex:(NSInteger)index {
    [self insertSubview:background.backgroundView atIndex:index];
    [self addBackgroundToStack:background];
}

- (void)addBackground:(MXParallaxBackground *)background {
    [self insertBackground:background atIndex:self.stack.count];
}

- (void)insertBackground:(MXParallaxBackground *)background belowBackground:(MXParallaxBackground *)siblingBackground {
    [self insertSubview:background.backgroundView belowSubview:siblingBackground.backgroundView];
    [self addBackgroundToStack:background];
}

- (void)insertBackground:(MXParallaxBackground *)background aboveBackground:(MXParallaxBackground *)siblingBackground {
    [self insertSubview:background.backgroundView aboveSubview:siblingBackground.backgroundView];
    [self addBackgroundToStack:background];
}

- (void)insertBackground:(MXParallaxBackground *)background belowSubview:(UIView *)siblingSubview {
    [self insertSubview:background.backgroundView aboveSubview:siblingSubview];
    [self addBackgroundToStack:background];
}

- (void)insertBackground:(MXParallaxBackground *)background aboveSubview:(UIView *)siblingSubview {
    [self insertSubview:background.backgroundView aboveSubview:siblingSubview];
    [self addBackgroundToStack:background];
}

- (void)bringBackgroundToFront:(MXParallaxBackground *)background {
    [self bringSubviewToFront:background.backgroundView];
}

- (void)sendBackgroundToBack:(MXParallaxBackground *)background {
    [self sendSubviewToBack:background.backgroundView];
}

@end
