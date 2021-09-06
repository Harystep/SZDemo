//
//  UIView+Extra.m
//  DNProject
//
//  Created by zjs on 2019/1/16.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "UIView+Extra.h"
#import <objc/runtime.h>

@implementation UIView (Extra)

- (CGFloat)dn_x {
    
    return self.frame.origin.x;
}
- (void)setDn_x:(CGFloat)dn_x {
    
    CGRect frame   = self.frame;
    frame.origin.x = dn_x;
    self.frame = frame;
}

- (CGFloat)dn_y {
    
    return self.frame.origin.y;
}

- (void)setDn_y:(CGFloat)dn_y {
    
    CGRect frame   = self.frame;
    frame.origin.y = dn_y;
    self.frame = frame;
}

- (CGFloat)dn_right {
    
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setDn_right:(CGFloat)dn_right {
    
    CGRect frame   = self.frame;
    frame.origin.x = dn_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)dn_bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setDn_bottom:(CGFloat)dn_bottom {
    
    CGRect frame   = self.frame;
    frame.origin.y = dn_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)dn_width {
    
    return self.frame.size.width;
}
- (void)setDn_width:(CGFloat)dn_width {
    
    CGRect frame     = self.frame;
    frame.size.width = dn_width;
    self.frame = frame;
}

- (CGFloat)dn_height {
    
    return self.frame.size.height;
}
- (void)setDn_height:(CGFloat)dn_height {
    
    CGRect frame      = self.frame;
    frame.size.height = dn_height;
    self.frame = frame;
}


- (CGFloat)dn_centerX {
    
    return self.center.x;
}
- (void)setDn_centerX:(CGFloat)dn_centerX {
    
    self.center = CGPointMake(dn_centerX, self.center.y);
}

- (CGFloat)dn_centerY {
    
    return self.center.y;
}
- (void)setDn_centerY:(CGFloat)dn_centerY {
    
    self.center = CGPointMake(self.center.x, dn_centerY);
}

- (CGPoint)dn_origin {
    
    return self.frame.origin;
}
- (void)setDn_origin:(CGPoint)dn_origin {
    
    CGRect frame = self.frame;
    frame.origin = dn_origin;
    self.frame   = frame;
}

- (CGSize)dn_size {
    
    return self.frame.size;
}
- (void)setDn_size:(CGSize)dn_size {
    
    CGRect frame = self.frame;
    frame.size   = dn_size;
    self.frame   = frame;
}

- (void)setDirection:(DNGradualColorDirection)direction {
    
    NSNumber *num = [NSNumber numberWithInteger:direction];
    objc_setAssociatedObject(self, @selector(direction), num, OBJC_ASSOCIATION_ASSIGN);
}
- (DNGradualColorDirection)direction {
    NSNumber *num = objc_getAssociatedObject(self, @selector(direction));
    return num.integerValue;
}


- (UIViewController *)superViewController {
    
    for (UIView * next = self.superview; next; next = next.superview) {
        
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

// 创建屏幕快照
- (UIImage *)dn_createSnapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snap;
}

- (NSData *)dn_createSnapshotPDF {
    
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    
    if (!context) return nil;
    
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    
    return data;
}

// 设置视图渐变色
- (void)dn_gradualChangeColor:(DNGradualColorDirection)direction
                       colors:(NSArray<UIColor *>*)colors {
    
    NSMutableArray *array = [NSMutableArray array];
    for (UIColor *color in colors) {
        [array addObject:(id)color.CGColor];
    }
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(通过开始和结束位置来控制渐变的方向)
    if        (direction == 0) {
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint   = CGPointMake(0, 0.5);

    } else if (direction == 1) {
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint   = CGPointMake(0, 0.5);

    } else if (direction == 1) {
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint   = CGPointMake(0, 0.5);

    } else {
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint   = CGPointMake(0, 0.5);
    }
    gradient.colors = array;
    gradient.frame  = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    
    [self.layer insertSublayer:gradient atIndex:0];
}

// 设置阴影
- (void)dn_setShadowColor:(UIColor *)color offset:(CGSize)offset cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity {
    
    self.layer.cornerRadius       = cornerRadius;
    self.layer.shadowColor        = color.CGColor;
    self.layer.shadowOpacity      = opacity;
    self.layer.shadowRadius       = 1;
    self.layer.shadowOffset       = offset;
//    self.layer.shouldRasterize    = YES;
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)dn_setShadowColor:(UIColor *)color radius:(CGFloat)radius {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(radius, radius)];
    //设置阴影路径
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.shadowPath    = bezierPath.CGPath;
    maskLayer.shadowColor   = color.CGColor;
    
    [self.layer insertSublayer:maskLayer atIndex:0];
}

- (void)setViewCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setFontBold:(NSString *)boldStr withFont:(CGFloat)font {
    UILabel *fontL = (UILabel *)self;
    fontL.font = [UIFont fontWithName:boldStr size:font];
}

- (void)setFontBold:(CGFloat)font {
    UILabel *fontL = (UILabel *)self;
    fontL.font = [UIFont fontWithName:@"Helvetica-Bold" size:font];
}

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

@end
