//
//  SYBNetManager.h
//  CashierChoke
//
//  Created by zjs on 2019/9/10.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define MAINWINDOW  [UIApplication sharedApplication].keyWindow

typedef void(^CompleteHandler)(id responseObj);
typedef void(^FaildureHandler)(id data);

@interface SYBNetManager : NSObject


/** 单例创建*/
+ (instancetype)shareInstance;
/**
 *  @brief GET 请求
 *
 *  @param url      请求接口
 *  @param param    参数字典
 *  @param complete 完成回调
 *  @param faild    失败回调
 */
- (void)GETRequestWithURL:(NSString *)url
                    param:(NSDictionary *)param
                isNeedSVP:(BOOL)isNeed
          completeHandler:(CompleteHandler)complete
             faildHandler:(FaildureHandler)faild;

/**
 *  @brief POST 请求
 *
 *  @param url      请求接口
 *  @param param    参数字典
 *  @param complete 完成回调
 *  @param faild    失败回调
 */
- (void)POSTRequestWithURL:(NSString *)url
                     param:(id)param
                 isNeedSVP:(BOOL)isNeed
           completeHandler:(CompleteHandler)complete
              faildHandler:(FaildureHandler)faild;


/**
 *  @brief 单图上传
 *
 *  @param url        请求接口
 *  @param paramImage 参数字典
 *  @param complete   完成回调
 *  @param faild      失败回调
 */
//- (void)POSTImageWithURL:(NSString *)url
//                   param:(UIImage *)paramImage
//         completeHandler:(CompleteHandler)complete
//            faildHandler:(FaildureHandler)faild;

/**
 *  @brief 单图上传
 *
 *  @param url      请求接口
 *  @param paramArr 参数字典
 *  @param complete 完成回调
 *  @param faild    失败回调
 */
//- (void)POSTImageWithURL:(NSString *)url
//                  params:(NSArray *)paramArr
//         completeHandler:(CompleteHandler)complete
//            faildHandler:(FaildureHandler)faild;


@end

NS_ASSUME_NONNULL_END
