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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *friendsList;

@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) FriendData *activeFriend;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activeFriend = nil;
    self.friendsArray = [FriendData defaultFriends];
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
        [cell showGiftsAnimated:true];
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
- (IBAction)pushNotification:(UIBarButtonItem *)sender
{
    // This use just for show how push notification will work in complete application
    
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
