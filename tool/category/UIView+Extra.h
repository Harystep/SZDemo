//
//  UIView+Extra.h
//  DNProject
//
//  Created by zjs on 2019/1/16.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DNGradualColorDirection) {
    
    DNGradualColorDirectionTop = 0,
    DNGradualColorDirectionLeading,
    DNGradualColorDirectionBottom,
    DNGradualColorDirectionTrailing
};

@interface UIView (Extra)

/** Shortcut for frame.origin.x */
@property (nonatomic) CGFloat dn_x;

/** Shortcut for frame.origin.y */
@property (nonatomic) CGFloat dn_y;

/** Shortcut for frame.origin.x */
@property (nonatomic) CGFloat dn_right;

/** Shortcut for frame.origin.x + frame.size.width */
@property (nonatomic) CGFloat dn_bottom;

/** Shortcut for frame.size.width */
@property (nonatomic) CGFloat dn_width;

/** Shortcut for frame.size.height */
@property (nonatomic) CGFloat dn_height;

/** Shortcut for center.x */
@property (nonatomic) CGFloat dn_centerX;

/** Shortcut for center.y */
@property (nonatomic) CGFloat dn_centerY;

/** Shortcut for frame.origin */
@property (nonatomic) CGPoint dn_origin;

/** Shortcut for frame.size */
@property (nonatomic) CGSize  dn_size;

@property (nonatomic, assign) DNGradualColorDirection direction;

// 获取父视图控制器
- (UIViewController *)superViewController;

// 创建屏幕快照
- (UIImage *)dn_createSnapshotImage;

// 创建屏幕快照 PDF
- (nullable NSData *)dn_createSnapshotPDF;

// 设置视图渐变色
- (void)dn_gradualChangeColor:(DNGradualColorDirection)direction colors:(NSArray<UIColor *>*)colors;

- (void)dn_setShadowColor:(UIColor *)color offset:(CGSize)offset cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity;

//设置圆角
- (void)setViewCornerRadius:(CGFloat)cornerRadius;

- (void)setFontBold:(NSString *)boldStr withFont:(CGFloat)font;

- (void)setFontBold:(CGFloat)font;

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
