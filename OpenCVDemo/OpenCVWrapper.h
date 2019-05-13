//
//  OpenCVWrapper.h
//  OpenCVDemo
//
//  Created by Rohan on 22/03/19.
//  Copyright © 2019 Ankit Kargathra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject
- (UIImage *)isThisWorking:(UIImage *)img point:(CGPoint)point;
//- (cv::Mat)cvMatFromUIImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
