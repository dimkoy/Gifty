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

/**
 Now name used as an id of gift, in future implementation will add a unique user id
 */
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *friendImage;
@property (nonatomic, strong) NSArray *gifts;

/**
 FriendData initializer
 
 @param name Name of the friend
 @return friend with the name and empty properties
 */
+ (FriendData *)friendDataWithName:(NSString *)name;

/**
 Hardcoded array with friends. Used to testing

 @return Array with default friends information and gifts
 */
+ (NSArray *)defaultFriends;

@end
