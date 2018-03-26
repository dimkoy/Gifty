//
//  DataManager.m
//  GiftyApp
//
//  Created by Dmitriy on 17/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import "DataManager.h"
#import "DataManagerDelegate.h"
#import "FriendData.h"
#import "Gift.h"

#import "FriendDataLoadingOperation.h"

@import UIKit;
@import Firebase;
@import FirebaseStorage;

@interface DataManager ()

@property (strong, nonatomic) FIRDatabaseReference *dataBase;

@property (nonatomic, strong) NSOperationQueue *friendDataQueue;
@property (nonatomic, strong) NSOperationQueue *giftDataQueue;
@property (nonatomic, strong) NSOperationQueue *imageQueue;

@end

@implementation DataManager

#pragma mark - Init

+ (instancetype)sharedInstance
{
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        sharedInstance = [[DataManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Internal

- (FIRDatabaseReference *)dataBase
{
    if (!_dataBase)
    {
        _dataBase = [[FIRDatabase database] reference];
    }
    return _dataBase;
}

- (NSOperationQueue *)initializeQueueIfNeeded:(NSOperationQueue *)queue
{
    if (queue == nil)
    {
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 100;
    }
    
    return queue;
}

#pragma mark - interface

- (void)loadFriendListForAccount:(NSString *)accountName
{
    [[[self.dataBase child:@"users"]
                     child:accountName]
  observeSingleEventOfType:FIRDataEventTypeValue
                 withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
    {
        NSDictionary *friendDictionaryList = [NSDictionary dictionaryWithDictionary:snapshot.value[@"friendList"]];
        
        NSMutableArray *friendList = [NSMutableArray arrayWithCapacity:friendDictionaryList.count];
        
        for (NSString *name in [friendDictionaryList allValues])
        {
            FriendData *friend = [FriendData friendDataWithName:name];
            
            [friendList addObject:friend];
        }
        
        [self.delegate dataManagerDidEndLoadFriendList:[NSArray arrayWithArray:friendList]];
    }
     withCancelBlock:^(NSError * _Nonnull error)
    {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)loadFriendDataForName:(NSString *)name
{
    self.friendDataQueue = [self initializeQueueIfNeeded:self.friendDataQueue];
    
    FriendDataLoadingOperation *operation = [[FriendDataLoadingOperation alloc] init];
    operation.type = FriendDataLoadingOperationTypeFriendData;
    operation.loadingItemName = name;
    operation.delegate = self.delegate;
     
    [self.friendDataQueue addOperation:operation];
}

- (void)loadGiftDataForName:(NSString *)name
{
    self.giftDataQueue = [self initializeQueueIfNeeded:self.giftDataQueue];
    
    FriendDataLoadingOperation *operation = [[FriendDataLoadingOperation alloc] init];
    operation.type = FriendDataLoadingOperationTypeGiftData;
    operation.loadingItemName = name;
    operation.delegate = self.delegate;
    
    [self.giftDataQueue addOperation:operation];
}

- (void)loadImageForURL:(NSString *)imageURL
{
    self.imageQueue = [self initializeQueueIfNeeded:self.imageQueue];
    
    for (FriendDataLoadingOperation *operation in self.imageQueue.operations)
    {
        if ([operation.loadingItemName isEqual:imageURL])
        {
            return;
        }
    }
    
    FriendDataLoadingOperation *operation = [[FriendDataLoadingOperation alloc] init];
    operation.type = FriendDataLoadingOperationTypeImage;
    operation.loadingItemName = imageURL;
    operation.delegate = self.delegate;
    
    [self.imageQueue addOperation:operation];
}

@end
