//
//  UIImageView+Material.h
//  ImageFilterSample
//
//  Created by Tom Li on 5/7/14.
//  Copyright (c) 2014 Inspirify Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Material)

/**
 Fade in image using Material Design effect: http://www.google.com/design/spec/patterns/imagery-treatment.html#
 */
- (void)fadeInWithDuration:(NSTimeInterval)duration;

- (void)fadeOutWithDuration:(NSTimeInterval)duration;

@end
