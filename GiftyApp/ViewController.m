//
//  ViewController.m
//  GiftyApp
//
//  Created by Dmitriy on 02/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import "ViewController.h"
#import "FriendData.h"
#import "Gift.h"
#import "MainScreenCell.h"
#import "DataManager.h"
#import "DataManagerDelegate.h"

@interface ViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DataManagerDelegate
>

@property (nonatomic, weak) IBOutlet UITableView *friendsList;

@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) FriendData *activeFriend;

@property (nonatomic, strong) DataManager *dataManager;

@property (nonatomic, assign) BOOL usersImage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activeFriend = nil;
    self.friendsArray = [FriendData defaultFriends];
    
    self.dataManager = [DataManager sharedInstance];
    self.dataManager.delegate = self;
    [self.dataManager loadFriendListForAccount:@"Best friend"];
}

#pragma mark - TableView

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    MainScreenCell *cell = [self.friendsList dequeueReusableCellWithIdentifier:@"MainScreenCell"];
    
    if (!cell)
    {
        [self.friendsList registerNib:[UINib nibWithNibName:@"MainScreenCell" bundle:nil] forCellReuseIdentifier:@"MainScreenCell"];
        cell = [self.friendsList dequeueReusableCellWithIdentifier:@"MainScreenCell"];
    }
    
    FriendData *friend = self.friendsArray[indexPath.row];
    
    [cell fillCellWithData:friend];
    
    if (friend == self.activeFriend)
    {
        [cell showGiftsAnimated:false];
    }
    else
    {
        [cell hideGifts];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.activeFriend == self.friendsArray[indexPath.row])
    {
        return;
    }
    
    self.activeFriend = self.friendsArray[indexPath.row];
    
    [UIView transitionWithView:self.friendsList
                      duration:0.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^
    {
                        
                        [self.friendsList reloadData];
                        [self.friendsList layoutIfNeeded];
                        
    }
                    completion:^(BOOL finished)
    {
                        [self.friendsList scrollToRowAtIndexPath:indexPath
                                                atScrollPosition:UITableViewScrollPositionTop
                                                        animated:true];
    }];
}

#pragma mark - DataManagerDelegate

- (void)dataManagerDidEndLoadFriendList:(NSArray *)friendList
{
    self.friendsArray = friendList;
                         
    [self.friendsList reloadData];
    
    for (FriendData *friend in self.friendsArray)
    {
        [self.dataManager loadFriendDataForName:friend.name];
    }
}

- (void)dataManagerDidEndLoadFriendData:(FriendData *)friendData
{
    for (FriendData *data in self.friendsArray)
    {
        if ([data.name isEqualToString:friendData.name])
        {
            data.imageURL = friendData.imageURL;
            data.gifts = friendData.gifts;
            
            for (Gift *gift in data.gifts)
            {
                [self.dataManager loadGiftDataForName:gift.name];
            }
            
            [self.dataManager loadImageForURL:data.imageURL];
            
            return;
        }
    }
}

- (void)dataManagerDidEndLoadGift:(Gift *)gift
{    
    for (FriendData *friend in self.friendsArray)
    {
        for (Gift *friendGift in friend.gifts)
        {
            if ([friendGift.name isEqualToString:gift.name])
            {
                friendGift.value = gift.value;
                friendGift.currentValue = gift.currentValue;
                friendGift.imageURL = gift.imageURL;
                                       
                [self.dataManager loadImageForURL:gift.imageURL];
                
                if ([friend.name isEqualToString:self.activeFriend.name])
                {
                    [self.friendsList reloadData];
                }
            }
        }
    }
}

- (void)dataManagerDidEndLoadImage:(UIImage *)image forURL:(NSString *)url
{
    self.usersImage = false;
    
    for (FriendData *data in self.friendsArray)
    {
        if ([data.imageURL isEqualToString:url])
        {
            data.friendImage = image;
            
            self.usersImage = true;
        }
    }
    
    if (self.usersImage)
    {
        [self.friendsList reloadData];
        
        return;
    }
    
    // Now users have equal gifts, so is the reason why we doesn't return after first founded gift. Solution of this bag - add to the gifts an uniqe id
    
    for (FriendData *friend in self.friendsArray)
    {
        for (Gift *friendGift in friend.gifts)
        {
            if ([friendGift.imageURL isEqualToString:url])
            {
                friendGift.image = image;
                
                if ([friend.name isEqualToString:self.activeFriend.name])
                {
                    [self.friendsList reloadData];
                }
            }
        }
    }
}

#pragma mark - Additional methods

- (IBAction)pushNotification:(UIBarButtonItem *)sender
{
    // This use just for show how push notification will work in complete application. Push is just an image for 5th iphone screen size
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(5, -106, 310, 106)];
                      
                      view.image = [UIImage imageNamed:@"Notification"];
                      
                      UITapGestureRecognizer *gestur = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGiftScreen)];
                      
                      [view addGestureRecognizer:gestur];
                      
                      [[UIApplication sharedApplication].windows.firstObject addSubview:view];
                      
                      CGRect newFrame = CGRectMake(5, 10, 310, 106);
                      
                      [UIView animateWithDuration:0.3
                                            delay:0.0
                           usingSpringWithDamping:0.7
                            initialSpringVelocity:0.8
                                          options:UIViewAnimationOptionCurveEaseIn
                                       animations:^
                       {
                           view.frame = newFrame;
                       }
                                       completion:nil];
                  });
 }

- (void)showGiftScreen
{
    
}
@end
