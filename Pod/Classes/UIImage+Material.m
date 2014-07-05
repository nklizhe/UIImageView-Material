//
//  UIImage+Material.m
//  ImageFilterSample
//
//  Created by Tom Li on 5/7/14.
//  Copyright (c) 2014 Inspirify Limited. All rights reserved.
//

#import "UIImage+Material.h"
#import <GPUImage/GPUImage.h>

@implementation UIImage (Material)

- (UIImage *)imageWithSaturation:(float)saturation andGamma:(float)gamma
{
    GPUImagePicture *source = [[GPUImagePicture alloc] initWithImage:self];
    GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
    gammaFilter.gamma = gamma;
    [gammaFilter useNextFrameForImageCapture];
    
    GPUImageSaturationFilter *saturationFilter = [[GPUImageSaturationFilter alloc] init];
    saturationFilter.saturation = saturation;
    [saturationFilter useNextFrameForImageCapture];
    [gammaFilter addTarget:saturationFilter];
    
    [source addTarget:gammaFilter];
    [source useNextFrameForImageCapture];
    [source processImage];
    
    return [saturationFilter imageFromCurrentFramebuffer];
}

@end
