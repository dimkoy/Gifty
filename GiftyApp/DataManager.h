//
//  DataManager.h
//  GiftyApp
//
//  Created by Dmitriy on 17/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataManagerDelegate;

@interface DataManager : NSObject

- (void)loadFriendListForAccount:(NSString *)accountName;

- (void)loadFriendDataForName:(NSString *)name;

- (void)loadGiftDateForName:(NSString *)name;

- (void)loadImageForURL:(NSString *)imageURL;

@property (nonatomic, weak) id<DataManagerDelegate> delegate;

@end
