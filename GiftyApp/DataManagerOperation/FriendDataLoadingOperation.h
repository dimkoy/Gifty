//
//  FriendDataLoadingOperation.h
//  GiftyApp
//
//  Created by Dmitriy on 24/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataManagerDelegate;

typedef NS_ENUM(NSInteger, FriendDataLoadingOperationType)
{
    FriendDataLoadingOperationTypeFriendData,
    FriendDataLoadingOperationTypeGiftData,
    FriendDataLoadingOperationTypeImage
};

@interface FriendDataLoadingOperation : NSOperation

@property (nonatomic, strong) NSString *loadingItemName;
@property (nonatomic, assign) FriendDataLoadingOperationType type;

@property (nonatomic, weak) id<DataManagerDelegate> delegate;

@end
