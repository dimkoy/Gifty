//
//  Gift.m
//  GiftyApp
//
//  Created by Dmitriy on 04/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import "Gift.h"

@implementation Gift

+ (Gift *)defaultGift
{
    Gift *gift = [[Gift alloc] init];
    gift.name = @"gamepad";
    gift.image = [UIImage imageNamed:@"gift_Image_gamepad"];
    gift.value = 1600;
    gift.currentValue = 500;
    
    return gift;
}


@end
