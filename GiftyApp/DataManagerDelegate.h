//
//  DataManagerDelegate.h
//  GiftyApp
//
//  Created by Dmitriy on 17/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class FriendData;
@class Gift;

@protocol DataManagerDelegate <NSObject>

- (void)dataManagerDidEndLoadFriendList:(NSArray *)friendList;

- (void)dataManagerDidEndLoadFriendData:(FriendData *)friendData;

- (void)dataManagerDidEndLoadGift:(Gift *)gift;

- (void)dataManagerDidEndLoadImage:(UIImage *)image forURL:(NSString *)url;

@end
