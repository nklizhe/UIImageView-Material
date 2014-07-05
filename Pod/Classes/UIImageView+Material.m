//
//  UIImageView+Material.m
//  ImageFilterSample
//
//  Created by Tom Li on 5/7/14.
//  Copyright (c) 2014 Inspirify Limited. All rights reserved.
//

#import "UIImageView+Material.h"
#import <GPUImage/GPUImage.h>
#import <objc/runtime.h>
#import "UIImage+Material.h"

#define kNumFrames      8

@implementation UIImageView (Material)

- (float)_gammaForTime:(float)t
{
    if (t < 0.75) {
        float b = 0.2;
        float d = 0.75;
        float c = 0.8;
        t = t/d;
        return c * t * t * t + b;
    }
    else {
        return 1.0;
    }
}

- (float)_saturationForTime:(float)t
{
    float b = 0.2;
    float d = 1.0;
    float c = 0.8;
    t = t/d;
    return c * t * t * t + b;
}

- (NSArray *)_animationFrames
{
    NSArray *frames = (NSArray *)objc_getAssociatedObject(self, "_animationFrames");
    UIImage *origImage = (UIImage *)objc_getAssociatedObject(self, "_origImage");
    if (origImage != self.image) {
        origImage = self.image;
        
        objc_setAssociatedObject(self, "_origImage", self.image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        frames = nil;
    }
    
    if (!frames) {
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (int i=0; i<kNumFrames; i++) {
            float t = (float)i / (float)kNumFrames;
            float gamma = [self _gammaForTime:t];
            float saturation = [self _saturationForTime:t];
            
            UIImage *outputImage = [origImage imageWithSaturation:saturation andGamma:gamma];
            [tmp addObject:(id)[outputImage CGImage]];
        }
        [tmp addObject:(id)[origImage CGImage]];
        objc_setAssociatedObject(self, "_animationFrames", tmp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        frames = tmp;
    }
    return frames;
}

- (void)fadeInWithDuration:(NSTimeInterval)duration
{
    NSMutableArray *keyTimes = [[NSMutableArray alloc] init];
    NSMutableArray *opacityValues = [[NSMutableArray alloc] init];
    
    for (int i=0; i<=kNumFrames; i++) {
        NSTimeInterval t = (float)(i) / (float)kNumFrames;
        float opacity = (t > 0.5) ? 1.0 : t * 2.0;
        [keyTimes addObject:@(t)];
        [opacityValues addObject:@(opacity)];
    }

    // Opacity
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    [anim setKeyTimes:keyTimes];
    [anim setValues:opacityValues];
    
    // Saturate
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    
    NSMutableArray *values = [[NSMutableArray alloc] initWithArray:[self _animationFrames]];
    [anim2 setKeyTimes:keyTimes];
    [anim2 setValues:values];
    
    // Animation group
    self.layer.opacity = 0.f;
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:anim, anim2, nil];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [self.layer removeAllAnimations];
    [self.layer addAnimation:group forKey:@"animateFadeIn"];
}

- (void)fadeOutWithDuration:(NSTimeInterval)duration
{
    // Opacity
    NSMutableArray *keyTimes = [[NSMutableArray alloc] init];
    NSMutableArray *opacityValues = [[NSMutableArray alloc] init];
    
    for (int i=0; i<=kNumFrames; i++) {
        NSTimeInterval t = (float)(i) / (float)kNumFrames;
        float opacity = (t < 0.5) ? 1.0 : (1 - t) * 2.0;
        [keyTimes addObject:@(t)];
        [opacityValues addObject:@(opacity)];
    }
    
    // Opacity
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    [anim setKeyTimes:keyTimes];
    [anim setValues:opacityValues];

    // Saturate
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    // reverse array
    NSArray *frames = [self _animationFrames];
    for (int i=kNumFrames; i>=0; i--) {
        UIImage *img = [frames objectAtIndex:i];
        [values addObject:img];
    }
    [anim2 setKeyTimes:keyTimes];
    [anim2 setValues:values];
    
    // Animation group
    self.layer.opacity = 1.f;
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:anim, anim2, nil];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [self.layer removeAllAnimations];
    [self.layer addAnimation:group forKey:@"animateFadeOut"];
}
@end
