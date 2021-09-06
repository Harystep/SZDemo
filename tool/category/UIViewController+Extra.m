//
//  UIViewController+Extra.m
//  YunLanCashier
//
//  Created by zjs on 2019/8/5.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "UIViewController+Extra.h"
#import "SYBMineInfoModel.h"
#import <objc/runtime.h>
#import "SYBFunctionGuideController.h"

@interface SYBNavigationView ()

@property (nonatomic, strong) UILabel     *naviTitle;
@property (nonatomic, strong) UIButton    *leftItemBtn;
@property (nonatomic, strong) UIButton    *rightItemBtn;
@property (nonatomic, strong) UIButton    *otherItemBtn;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation SYBNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark -- setup subviews
- (void)setupSubviews {
    
    self.backgroundImageView = [[UIImageView alloc] init];
    
    self.naviTitle = [[UILabel alloc] init];
    self.naviTitle.font = AUTO_SYSTEM_FONT_SIZE(17);
    self.naviTitle.textAlignment = NSTextAlignmentCenter;
    
    self.leftItemBtn = [[UIButton alloc] init];
    self.leftItemBtn.tintColor = UIColor.blackColor;
    self.leftItemBtn.titleLabel.font = AUTO_SYSTEM_FONT_SIZE(14);
    UIImage *leftImg = [[UIImage imageNamed:@"SYB_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.leftItemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.leftItemBtn setImage:leftImg forState:UIControlStateNormal];
    [self.leftItemBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.leftItemBtn addTarget:self
                         action:@selector(leftItemAction)
               forControlEvents:UIControlEventTouchUpInside];
//    [self.leftItemBtn dn_layoutButtonEdgeInset:DNEdgeInsetStyleLeft space:5];
    
    self.rightItemBtn = [[UIButton alloc] init];
    self.rightItemBtn.tintColor = UIColor.blackColor;
    self.rightItemBtn.titleLabel.font = AUTO_SYSTEM_FONT_SIZE(14);
    self.rightItemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.rightItemBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.rightItemBtn addTarget:self
                          action:@selector(rightItemAction)
                forControlEvents:UIControlEventTouchUpInside];

    self.otherItemBtn = [[UIButton alloc] init];
    self.otherItemBtn.tintColor = UIColor.blackColor;
    self.otherItemBtn.titleLabel.font = AUTO_SYSTEM_FONT_SIZE(14);
    self.otherItemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.otherItemBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.otherItemBtn addTarget:self
                          action:@selector(otherItemAction)
                forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- setup subviews layout
- (void)setupConstraints {
    
//    NSString *version = [UIDevice currentDevice].systemVersion;
    CGFloat  status_h = UIApplication.sharedApplication.statusBarFrame.size.height;
    
    [self addSubview:self.backgroundImageView];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self);
    }];
    
    [self addSubview:self.naviTitle];
    [self.naviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(status_h);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_offset(SCREEN_W * 0.5);
    }];
    
    [self addSubview:self.leftItemBtn];
    [self.leftItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(status_h);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.leading.mas_equalTo(self.mas_leading).inset(AUTO_MARGIN(8));
        make.width.mas_offset(SCREEN_W * 0.12);
    }];
    
    [self addSubview:self.rightItemBtn];
    [self.rightItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(status_h);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.trailing.mas_equalTo(self.mas_trailing).inset(AUTO_MARGIN(12));
        make.width.mas_offset(SCREEN_W * 0.2);
    }];
}

#pragma mark -- filePrivate Methods
- (void)leftItemAction {
    
    if (self.leftBarItemBlock) {
        self.leftBarItemBlock();
    }
}

- (void)rightItemAction {
    
    if (self.rightBarItemBlock) {
        self.rightBarItemBlock();
    }
}

- (void)otherItemAction {
    if (self.otherBarItemBlock) {
        self.otherBarItemBlock();
    }
}

- (void)setOtherImageName:(NSString *)otherImageName {
    _otherImageName = otherImageName;
    UIImage *image = [[UIImage imageNamed:otherImageName]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.otherItemBtn setImage:image forState:UIControlStateNormal];
}

- (void)setOtherRightItem:(BOOL)otherRightItem {
    _otherRightItem = otherRightItem;
    if (otherRightItem) {
        CGFloat  status_h = UIApplication.sharedApplication.statusBarFrame.size.height;
        [self.rightItemBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).inset(status_h);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.trailing.mas_equalTo(self.mas_trailing).inset(AUTO_MARGIN(15));
            make.width.mas_offset(AUTO_MARGIN(25));
        }];
        [self addSubview:self.otherItemBtn];
        [self.otherItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).inset(status_h);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.trailing.mas_equalTo(self.rightItemBtn.mas_leading).inset(AUTO_MARGIN(8));
            make.width.mas_offset(AUTO_MARGIN(25));
        }];
    }
    
}

#pragma mark -- setter
- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.naviTitle.text = title;
}

- (void)setLeftTitle:(NSString *)leftTitle {
    
    _leftTitle = leftTitle;
    [self.leftItemBtn setTitle:leftTitle forState:UIControlStateNormal];
}

- (void)setLeftImageName:(NSString *)leftImageName {
    
    _leftImageName = leftImageName;
    UIImage *image = [[UIImage imageNamed:leftImageName]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.leftItemBtn setImage:image forState:UIControlStateNormal];
}

- (void)setRightTitle:(NSString *)rightTitle {
    
    _rightTitle = rightTitle;
    [self.rightItemBtn setTitle:rightTitle forState:UIControlStateNormal];
}

- (void)setRightImageName:(NSString *)rightImageName {
    
    _rightImageName = rightImageName;
    UIImage *image  = [[UIImage imageNamed:rightImageName]
                       imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.rightItemBtn setImage:image forState:UIControlStateNormal];
}

- (void)setBackgroundImage:(NSString *)backgroundImage {
    
    _backgroundImage = backgroundImage;
    self.backgroundImageView.image = [UIImage imageNamed:backgroundImage];
}

- (void)setHideLeftItem:(BOOL)hideLeftItem {

    _hideLeftItem = hideLeftItem;
    self.leftItemBtn.hidden = hideLeftItem;
}

- (void)setHideRightItem:(BOOL)hideRightItem {

    _hideRightItem = hideRightItem;
    self.rightItemBtn.hidden = hideRightItem;
}

- (void)setTintColor:(UIColor *)tintColor {
    
    _tintColor = tintColor;
    self.naviTitle.textColor    = tintColor;
    self.leftItemBtn.tintColor  = tintColor;
    self.rightItemBtn.tintColor = tintColor;
    self.otherItemBtn.tintColor = tintColor;
    [self.leftItemBtn  setTitleColor:tintColor forState:UIControlStateNormal];
    [self.rightItemBtn setTitleColor:tintColor forState:UIControlStateNormal];
}
@end

@implementation UIViewController (Extra)

- (UIView *)createViewOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect {
    UIView *view = [[UIView alloc] init];
    view.frame = rect;
    [targetVc.view addSubview:view];
    return view;
}

- (UIView *)createViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UIView *view = [[UIView alloc] init];
    view.frame = rect;
    [targetView addSubview:view];
    return view;
}

- (UILabel *)createLabelOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect {
    UILabel *label = [[UILabel alloc] init];
    label.frame = rect;
    [targetVc.view addSubview:label];
    return label;
}
- (UILabel *)createLabelOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UILabel *label = [[UILabel alloc] init];
    label.frame = rect;
    [targetView addSubview:label];
    return label;
}

- (UIImageView *)createImageViewOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect {
    UIImageView *imageIv = [[UIImageView alloc] init];
    imageIv.frame = rect;
    [targetVc.view addSubview:imageIv];
    return imageIv;
}
- (UIImageView *)createImageViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UIImageView *imageIv = [[UIImageView alloc] init];
    imageIv.frame = rect;
    [targetView addSubview:imageIv];
    return imageIv;
}

- (UIButton *)createButtonOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect {
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = rect;
    [targetVc.view addSubview:btn];
    return btn;
}

- (UIButton *)createButtonOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = rect;
    [targetView addSubview:btn];
    return btn;
}

- (UIScrollView *)createScrollViewOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect {
    UIScrollView *scView = [[UIScrollView alloc] init];
    scView.frame = rect;
    [targetVc.view addSubview:scView];
    return scView;
}

- (UIScrollView *)createScrollViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UIScrollView *scView = [[UIScrollView alloc] init];
    scView.frame = rect;
    [targetView addSubview:scView];
    return scView;
}

- (UITableView *)createTableViewOnTargetVC:(UIViewController *)targetVc withFrame:(CGRect)rect {
    UITableView *tbView = [[UITableView alloc] init];
    tbView.frame = rect;
//    tbView.delegate = targetVc;
//    tbView.dataSource = targetVc;
    [targetVc.view addSubview:tbView];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tbView;
}
- (UITableView *)createTableViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect {
    UITableView *tbView = [[UITableView alloc] init];
    tbView.frame = rect;
    [targetView addSubview:tbView];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tbView;
}

- (UITableView *)createTableViewOnTargetView:(UIView *)targetView withFrame:(CGRect)rect withStyle:(UITableViewStyle)style{
    UITableView *tbView = [[UITableView alloc] initWithFrame:rect style:style];
    [targetView addSubview:tbView];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tbView;
}

- (UITextField *)createTextFieldOnTargetView:(UIView *)targetView withFrame:(CGRect)rect withPlaceholder:(NSString *)placeholder {
    UITextField *textF = [[UITextField alloc] init];
    textF.frame = rect;
    [targetView addSubview:textF];
    textF.placeholder = placeholder;
    return textF;
}


- (void)noAuthMerchantAlert:(SYBMineInfoModel *)model title:(NSString *)title alertBlock:(void(^)(void))alertBlock {
    if (title.length == 0) {
        [self alerthMerchantInfoView:model alertBlock:^{
            alertBlock();
        }];
    } else {
        if ([[SYBUserInfo shareUserInfo].userType isEqualToString:@"promoter"]) {
            if ((model.merchantAuditStatus != 3) && (model.merchantAuditStatus != 4)) {
                SYBFunctionGuideController *guide = [[SYBFunctionGuideController alloc] init];
                guide.titleStr = title;
                [self.navigationController pushViewController:guide animated:YES];
            } else {
                
                alertBlock();
            }
        } else {
            alertBlock();
        }
    }
}

- (void)alerthMerchantInfoView:(SYBMineInfoModel *)model alertBlock:(void(^)(void))alertBlock {
    if ([[SYBUserInfo shareUserInfo].userType isEqualToString:@"promoter"]) {
        if ((model.merchantAuditStatus != 3) && (model.merchantAuditStatus != 4)) {
            NSString *content = @"";
            if (model.bankStatus == 3) {
                content = @"该功能仅限商家使用，可在\n我的 -> 完成商家认证后使用";
            } else {
                content = @"该功能仅限商家使用，可在\n我的 -> 认证绑卡\n完成商家认证后使用";
            }
            SYBAlertView *alert = [[SYBAlertView alloc] init];
            alert.title   = @"温馨提示";
            alert.message = content;
            alert.confirmTitle = @"确定";
            alert.hideCancelBtn = YES;
            [alert showAlertView];
            alert.confirmBlock = ^{
                alertBlock();
            };
        } else {
            alertBlock();
        }
    } else {
        alertBlock();
    }
}

- (SYBNavigationView *)navigationBar {

    SYBNavigationView *navi = objc_getAssociatedObject(self, @selector(navigationBar));
    if (!navi) {
        navi = [[SYBNavigationView alloc] init];
        
        [self.view addSubview:navi];
        navi.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:navi
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1
                                                                  constant:0],
                                    [NSLayoutConstraint constraintWithItem:navi
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1
                                                                  constant:0],
                                    [NSLayoutConstraint constraintWithItem:navi
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1
                                                                  constant:0],
                                    [NSLayoutConstraint constraintWithItem:navi
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeHeight
                                                                multiplier:1
                                                                  constant:44 + UIApplication.sharedApplication.statusBarFrame.size.height]]];
        objc_setAssociatedObject(self, @selector(navigationBar), navi, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navi;
}

- (void)setNavigationBar:(SYBNavigationView *)navigationBar {
    
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
