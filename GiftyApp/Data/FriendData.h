//
//  FriendData.h
//  GiftyApp
//
//  Created by Dmitriy on 04/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

@import UIKit;

#import <Foundation/Foundation.h>

@interface FriendData : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *friendImage;
@property (nonatomic, strong) NSArray *gifts;

+ (NSArray *)defaultFriends;

@end
