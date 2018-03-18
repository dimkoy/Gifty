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

@import Firebase;
@import FirebaseStorage;

@interface DataManager ()

@property (strong, nonatomic) FIRDatabaseReference *dataBase;

@end

@implementation DataManager

- (FIRDatabaseReference *)dataBase
{
    if (!_dataBase)
    {
        _dataBase = [[FIRDatabase database] reference];
    }
    return _dataBase;
}

#pragma mark - interface

- (void)loadFriendListForAccount:(NSString *)accountName
{
    [[[self.dataBase child:@"users"]
                     child:accountName]
  observeSingleEventOfType:FIRDataEventTypeValue
                 withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
    {
        // Get user value
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
    [[[self.dataBase child:@"users"]
                     child:name]
  observeSingleEventOfType:FIRDataEventTypeValue
                 withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
     {
         FriendData *friend = [FriendData friendDataWithName:name];
         friend.imageURL = snapshot.value[@"image"];
         
         
         NSDictionary *friendDictionaryList = [NSDictionary dictionaryWithDictionary:snapshot.value[@"gifts"]];
         NSMutableArray *gifts = [NSMutableArray arrayWithCapacity:friendDictionaryList.count];
         
         for (NSString *giftName in [friendDictionaryList allValues])
         {
             Gift *gift = [Gift giftWithName:giftName];
             
             [gifts addObject:gift];
         }
         
         friend.gifts = [NSArray arrayWithArray:gifts];
         
         [self.delegate dataManagerDidEndLoadFriendData:friend];
     }];
}

- (void)loadGiftDateForName:(NSString *)name
{
    [[[self.dataBase child:@"gifts"]
      child:name]
     observeSingleEventOfType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
     {
         Gift *gift = [Gift giftWithName:name];
         gift.imageURL = snapshot.value[@"image"];
         gift.value = [(NSString *)snapshot.value[@"value"] intValue];
         gift.currentValue = [(NSString *)snapshot.value[@"currentValue"] intValue];
         
         [self loadImageForURL:gift.imageURL];
         
         [self.delegate dataManagerDidEndLoadGift:gift];
     }];
}

- (void)loadImageForURL:(NSString *)imageURL
{
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *httpsReference = [storage referenceForURL:imageURL];
    
    [httpsReference dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
        if (error != nil) {
            // Uh-oh, an error occurred!
        }
        else
        {
            // Data for "images/island.jpg" is returned
            UIImage *image = [UIImage imageWithData:data];
            
            [self.delegate dataManagerDidEndLoadImage:image forURL:imageURL];
        }
    }];
    
    
}

@end
