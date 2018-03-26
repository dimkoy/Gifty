//
//  FriendDataLoadingOperation.m
//  GiftyApp
//
//  Created by Dmitriy on 24/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import "FriendDataLoadingOperation.h"
#import "FriendData.h"
#import "Gift.h"
#import "DataManagerDelegate.h"

@import Firebase;
@import FirebaseStorage;

@interface FriendDataLoadingOperation ()

@property (strong, nonatomic) FIRDatabaseReference *dataBase;

@end

@implementation FriendDataLoadingOperation

@synthesize executing = _executing, finished = _finished;

- (BOOL)isAsynchronous
{
    return true;
}

- (BOOL)isExecuting
{
    return _executing;
}

- (BOOL)isFinished
{
    return _finished;
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    _finished = finished;
    [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
}

- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = executing;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

- (void)start
{
    if ([self isCancelled])
    {
        self.finished = true;
        
        return;
    }
    
    self.executing = true;
    
    switch (self.type) {
            case FriendDataLoadingOperationTypeFriendData:
            {
                [[[self.dataBase child:@"users"]
                  child:self.loadingItemName]
                 observeSingleEventOfType:FIRDataEventTypeValue
                 withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
                 {
                     FriendData *friend = [FriendData friendDataWithName:self.loadingItemName];
                     friend.imageURL = snapshot.value[@"image"];
                     
                     NSDictionary *friendDictionaryList = [NSDictionary dictionaryWithDictionary:snapshot.value[@"gifts"]];
                     NSMutableArray *gifts = [NSMutableArray arrayWithCapacity:friendDictionaryList.count];
                     
                     for (NSString *giftName in [friendDictionaryList allValues])
                     {
                         Gift *gift = [Gift giftWithName:giftName];
                         
                         [gifts addObject:gift];
                     }
                     
                     friend.gifts = [NSArray arrayWithArray:gifts];
                     
                     [self finishOperation];
                     
                     [self.delegate dataManagerDidEndLoadFriendData:friend];
                 }];
            }
            break;
            
            case FriendDataLoadingOperationTypeGiftData:
            {
                [[[self.dataBase child:@"gifts"]
                                 child:self.loadingItemName]
              observeSingleEventOfType:FIRDataEventTypeValue
                             withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
                 {
                     Gift *gift = [Gift giftWithName:self.loadingItemName];
                     gift.imageURL = snapshot.value[@"image"];
                     gift.value = [(NSString *)snapshot.value[@"value"] intValue];
                     gift.currentValue = [(NSString *)snapshot.value[@"currentValue"] intValue];
                     
                     [self.delegate dataManagerDidEndLoadGift:gift];
                 }];
            }
            break;
            
            case FriendDataLoadingOperationTypeImage:
            {
                FIRStorage *storage = [FIRStorage storage];
                
                FIRStorageReference *httpsReference = [storage referenceForURL:self.loadingItemName];
                
                [httpsReference dataWithMaxSize:1 * 1024 * 1024
                                     completion:^(NSData *data, NSError *error)
                 {
                     if (error != nil)
                     {
                         
                     }
                     else
                     {
                         UIImage *image = [UIImage imageWithData:data];
                         
                         [self.delegate dataManagerDidEndLoadImage:image forURL:self.loadingItemName];
                     }
                 }];
            }
            break;
            
        default:
            break;
    }
}

- (void)finishOperation
{
    self.executing = false;
    self.finished = true;
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

@end
