//
//  UIViewController+Extra.h
//  YunLanCashier
//
//  Created by zjs on 2019/8/5.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYBNavigationView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, copy) NSString *leftImageName;

@property (nonatomic, copy) NSString *rightTitle;
@property (nonatomic, copy) NSString *rightImageName;
@property (nonatomic, copy) NSString *otherImageName;

@property (nonatomic, copy) NSString *backgroundImage;

@property (nonatomic, copy) void(^titleTouchBlock)(void);
@property (nonatomic, copy) void(^leftBarItemBlock)(void);
@property (nonatomic, copy) void(^rightBarItemBlock)(void);
@property (nonatomic, copy) void(^otherBarItemBlock)(void);

@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, assign, getter=isHideLeftItem) BOOL hideLeftItem;
@property (nonatomic, assign, getter=isHideLeftItem) BOOL hideRightItem;
@property (nonatomic, assign, getter=isHideLeftItem) BOOL otherRightItem;

@end

@class SYBMineInfoModel;
@interface UIViewController (Extra)

@property (nonatomic, strong) SYBNavigationView *navigationBar;

- (void)noAuthMerchantAlert:(SYBMineInfoModel *)model title:(NSString *)title alertBlock:(void(^)(void))alertBlock;
- (void)alerthMerchantInfoView:(SYBMineInfoModel *)model alertBlock:(void(^)(void))alertBlock;

- (UIButton *)createButtonOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect;
- (UIButton *)createButtonOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;

- (UILabel *)createLabelOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect;
- (UILabel *)createLabelOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;

- (UIView *)createViewOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect;
- (UIView *)createViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;

- (UIImageView *)createImageViewOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect;
- (UIImageView *)createImageViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;

- (UIScrollView *)createScrollViewOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect;
- (UIScrollView *)createScrollViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;

- (UITableView *)createTableViewOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect;
- (UITableView *)createTableViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect;
- (UITableView *)createTableViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect withStyle:(UITableViewStyle)style;

- (UITextField *)createTextFieldOnTargetView:(UIView *)targetView withFrame:(CGRect)rect withPlaceholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
