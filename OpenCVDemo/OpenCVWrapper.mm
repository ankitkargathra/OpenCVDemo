//
//  OpenCVWrapper.m
//  OpenCVDemo
//
//  Created by Rohan on 22/03/19.
//  Copyright © 2019 Ankit Kargathra. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#include <iostream>
#include <opencv2/highgui/highgui.hpp> // import no include errors
#include <opencv2/imgproc/imgproc.hpp> // import no include errors
#include <opencv2/core/core.hpp>       // import no include errors
#include <opencv2/core/types_c.h>
#include <opencv2/imgcodecs/imgcodecs_c.h>
#include <stdio.h>
#include <stdlib.h>

@implementation OpenCVWrapper
//- (UIImage *)isThisWorking:(UIImage *)img {
//    std::cout << "This is working";
//    return [self UIImageFromCVMat:[self cvMatFromUIImage:img]];
//}

- (UIImage *)isThisWorking:(UIImage *)img point:(CGPoint)point {
    std::cout << "This is working";
    
    cv::Mat tmpoMat4Channel = [self cvMatFromUIImage:img];
    cv::Point seed(point.x,point.y);
    
    cv::Mat mask = cv::Mat::zeros(tmpoMat4Channel.rows + 2, tmpoMat4Channel.cols + 2, CV_8U);

    cv::cvtColor(tmpoMat4Channel, tmpoMat4Channel, cv::COLOR_BGR2RGB);

    cv::Mat tmpoMat4ChannelEmpty = [self cvMatFromUIImage:img];

    try {
        if (seed.x > 0 && seed.y > 0) {
            cv::floodFill(tmpoMat4Channel, mask, seed, cv::Scalar(150, 155, 20) ,0, cv::Scalar(2,2,2), cv::Scalar(3,3,3), 8);
        }
    } catch (cv::Exception ex) { }
    

    cv::cvtColor(tmpoMat4Channel, tmpoMat4Channel, cv::COLOR_BGR2RGB);
    
    return [self UIImageFromCVMat:tmpoMat4Channel];
}

- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        true,                                      //should interpolate
                                        kCGRenderingIntentPerceptual                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}
@end
