//
//  mainScreenCell.h
//  GiftyApp
//
//  Created by Dmitriy on 04/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendData.h"

@class FriendData;

@interface MainScreenCell : UITableViewCell

/**
 To set cell's data use fillCellWithData method
 */
@property (nonatomic, strong, readonly) FriendData *data;

- (void)fillCellWithData:(FriendData *)friendEntity;

- (void)showGiftsAnimated:(BOOL)animated;
- (void)hideGifts;

@end
