//
//  mainScreenCell.m
//  GiftyApp
//
//  Created by Dmitriy on 04/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import "MainScreenCell.h"
#import "Gift.h"

@interface MainScreenCell ()

@property (weak, nonatomic) IBOutlet UIImageView *friendImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *giftViewConstraint;
@property (weak, nonatomic) IBOutlet UILabel *giftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UISlider *progressGift;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UIButton *giftButton;
@property (weak, nonatomic) IBOutlet UILabel *alreadyValueLabel;

@property (nonatomic, strong) FriendData *data;

@end

@implementation MainScreenCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.giftView.hidden = true;
    self.giftViewConstraint.constant = 0;
    
    self.giftView.layer.cornerRadius = 6;
    self.giftView.layer.shadowColor = self.giftView.backgroundColor.CGColor;
    
    self.giftView.layer.shadowRadius = 10;
    self.giftView.layer.shadowOpacity = 1.0;
    self.giftView.layer.shadowOffset = CGSizeMake(1.0f, 6.0f);
    
    UIImage *image = [UIImage imageNamed:@"rectangle_dot"];
    
    [self.progressGift setThumbImage:image forState:UIControlStateNormal];
    [self.progressGift setMinimumTrackTintColor:UIColor.greenColor];
    [self.progressGift setMaximumTrackTintColor:UIColor.grayColor];
    self.progressGift.userInteractionEnabled = false;
    self.friendImageView.image = [UIImage imageNamed:@"friend_image"];
    self.friendImageView.layer.cornerRadius = CGRectGetHeight(self.friendImageView.frame) / 2;
    self.friendImageView.clipsToBounds = true;
}

#pragma mark - Interface

- (FriendData *)data
{
    return _data;
}

- (void)fillCellWithData:(FriendData *)friendEntity
{
    self.nameLabel.text = friendEntity.name;
    self.friendImageView.image = friendEntity.friendImage;
   
    Gift *gift = friendEntity.gifts.firstObject;
    self.giftNameLabel.text = gift.name;
    self.valueLabel.text = [NSString stringWithFormat:@"%@", @(gift.value)];
    self.giftImageView.image = gift.image;
    self.progressGift.maximumValue = gift.value;
    [self.progressGift setValue:gift.currentValue animated:true];
    
    self.alreadyValueLabel.text = [NSString stringWithFormat:@"%@ собранно", @(gift.currentValue)];
    
}

- (NSString *)friendName
{
    return self.nameLabel.text;
}

- (void)showGiftsAnimated:(BOOL)animated
{
    self.giftView.hidden = false;
    self.giftViewConstraint.constant = 360;
    
    if (animated)
    {
        [UIView animateWithDuration:0.3
                         animations:^{
            [self layoutIfNeeded];
        }];
    }
    else
    {
        [self layoutIfNeeded];
    }
}

- (void)hideGifts
{
    self.giftView.hidden = true;
    self.giftViewConstraint.constant = 0;
    
    [self layoutIfNeeded];
}

- (void)setGiftSectionHidden:(BOOL)hidden
{
    self.giftView.hidden = hidden;
    self.giftNameLabel.hidden = hidden;
    self.giftImageView.hidden = hidden;
    self.progressGift.hidden = hidden;
    self.costLabel.hidden = hidden;
    self.valueLabel.hidden = hidden;
    self.giftButton.hidden = hidden;
    self.alreadyValueLabel.hidden = hidden;
}

- (IBAction)giftButtonTapped:(UIButton *)sender
{
    
}



@end
