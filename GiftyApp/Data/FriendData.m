//
//  FriendData.m
//  GiftyApp
//
//  Created by Dmitriy on 04/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import "FriendData.h"
#import "Gift.h"

@implementation FriendData

+ (NSArray *)defaultFriends
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 10; index++)
    {
        FriendData *friend = [[FriendData alloc] init];
        
        switch (index) {
            case 0:
                friend.name = @"Best friend";
                break;
                
            case 1:
                friend.name = @"Not best friend";
                break;
                
            case 2:
                friend.name = @"Odinary friend";
                break;
                
            case 3:
                friend.name = @"Old friend";
                break;
                
            case 4:
                friend.name = @"Dude from work";
                break;
                
            case 5:
                friend.name = @"Friend 1";
                break;
                
            case 6:
                friend.name = @"Friend 2";
                break;
                
            case 7:
                friend.name = @"Friend 3";
                break;
                
            case 8:
                friend.name = @"Friend 4";
                break;
                
            case 9:
                friend.name = @"Friend 5";
                break;
                
            default:
                friend.name = @"default name";
                break;
        }
        
        Gift *gift1 = [Gift defaultGift];
        Gift *gift2 = [Gift defaultGift];
        friend.gifts = @[gift1, gift2];
        
        [array addObject:friend];
    }
    
    return [NSArray arrayWithArray:array];
}

@end
