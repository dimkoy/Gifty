//
//  GiftMainView.m
//  GiftyApp
//
//  Created by Dmitriy on 04/03/2018.
//  Copyright © 2018 Dmitriy. All rights reserved.
//

#import "GiftMainView.h"

@implementation GiftMainView

//+ (UIView *)loadViewFromXIBWithOwner:(UIView *)ownerView frame:(CGRect)frame
//{
//    UINib *nib = [[TaxiIBResourcesProvider sharedInstance].router nibWithName:NSStringFromClass([self class])];
//    UIView *loadedView = ([[nib instantiateWithOwner:self options:nil] firstObject]);
//
//    // if the CGRectZero is provided, use the view frame from xib
//    if (CGRectIsEmpty(frame))
//    {
//        // make owner has the same sizes as loaded view
//        ownerView.frame = CGRectMake(0, 0,
//                                     CGRectGetWidth(loadedView.bounds),
//                                     CGRectGetHeight(loadedView.bounds));
//    }
//
//    // synchronize sizes for owner and loaded view
//    loadedView.frame = ownerView.bounds;
//    loadedView.translatesAutoresizingMaskIntoConstraints = false;
//
//    [self addSubview:loadedView];
//
//    [self addLeadingConstraintToItem:loadedView withValue:0.0];
//    [self addTrailingConstraintToItem:loadedView withValue:0.0];
//    [self addTopConstraintToItem:loadedView withValue:0.0];
//    [self addBottomConstraintToItem:loadedView withValue:0.0];
//
//    [ownerView setNeedsLayout];
//
//    return loadedView;
//}

#pragma mark - Public (Init)

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
//        self.loadedView = [self.class loadViewFromXIBWithOwner:self frame:frame];
        
        // remove the background as the loaded view takes full control of the background
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
//        self.loadedView = [self.class loadViewFromXIBWithOwner:self frame:self.frame];
        
        // remove the background as the loaded view takes full control of the background
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (NSLayoutConstraint *)addHeightConstraintWithValue:(CGFloat)value
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:value];
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)addWidthConstraintWithValue:(CGFloat)value
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:value];
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)addTopConstraintToItem:(UIView *)item
                                     withValue:(CGFloat)value
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:item
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:value];
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)addBottomConstraintToItem:(UIView *)item
                                        withValue:(CGFloat)value
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:item
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:value];
    [self addConstraint:constraint];
    
    return constraint;
}

@end
