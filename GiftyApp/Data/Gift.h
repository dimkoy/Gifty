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


/**
 Now name used as an id of gift, in future implementation will add a unique id for the gift
 */
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) NSInteger currentValue;


/**
 Gift initializer

 @param name Name of the gift
 @return gift with the name and empty properties
 */
+ (Gift *)giftWithName:(NSString *)name;


/**
 Hardcoded gift that used for the aplication test

 @return gift with default properties
 */
+ (Gift *)defaultGift;

@end
