//
//  Gift.h
//  GiftyApp
//
//  Created by Dmitriy on 04/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

@import UIKit;

#import <Foundation/Foundation.h>

@interface Gift : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) NSInteger currentValue;

+ (Gift *)defaultGift;

@end
