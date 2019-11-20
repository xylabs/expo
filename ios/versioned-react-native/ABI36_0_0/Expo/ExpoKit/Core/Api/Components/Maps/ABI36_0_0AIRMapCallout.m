//
// Created by Leland Richardson on 12/27/15.
// Copyright (c) 2015 Facebook. All rights reserved.
//

#import "ABI36_0_0AIRMapCallout.h"


@implementation ABI36_0_0AIRMapCallout

- (BOOL) isPointInside:(CGPoint)pointInCallout {
    if (!self.alphaHitTest)
        return TRUE;
    CGFloat alpha = [self alphaOfPoint:pointInCallout];
    return alpha >= 0.01;
}

- (CGFloat) alphaOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return pixel[3]/255.0;
}


@end
