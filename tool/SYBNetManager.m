//
//  SYBNetManager.m
//  CashierChoke
//
//  Created by zjs on 2019/9/10.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "SYBNetManager.h"

#define SELFSHARE   [SYBNetManager shareInstance]

@interface SYBNetManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

static SYBNetManager * instanceManager = nil;

@implementation SYBNetManager

/** 重写 allocWithZone: 方法 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instanceManager == nil) {
            instanceManager = [super allocWithZone:zone];
        }
    });
    return instanceManager;
}
/** 重写 copyWithZone: 方法 */
- (id)copyWithZone:(NSZone *)zone {
    
    return instanceManager;
}
/** 单例模式创建  */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instanceManager) {
            instanceManager = [[self alloc] init];
        }
    });
    return instanceManager;
}

// Lazy Load sessionManager
- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 30.f;
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [_sessionManager.requestSerializer didChangeValueForKey: @"timeoutInterval"];
        
        NSSet * set = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        
        _sessionManager.requestSerializer  = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sessionManager;
}
/**
 *  @brief  GET 请求
 */
- (void)GETRequestWithURL:(NSString *)url param:(NSDictionary *)param isNeedSVP:(BOOL)isNeed completeHandler:(CompleteHandler)complete faildHandler:(FaildureHandler)faild {
    // 检查当前网络状态
//    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    DNLog(@"请求地址：%@%@",url,[self paramsStrWith:param]);
    DNLog(@"token--->：%@", [SYBUserInfo shareUserInfo].token);
    // 是否需要 MBP 菊花
    if (isNeed == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
        });
    }
    // 将登录名和token放进请求头
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLoginSuccess] == YES) {
        [self.sessionManager.requestSerializer setValue:[SYBUserInfo shareUserInfo].token
                                     forHTTPHeaderField:@"token"];
        NSString *myLoginName = [[SYBUserInfo shareUserInfo].loginName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        [self.sessionManager.requestSerializer setValue:myLoginName
                                     forHTTPHeaderField:@"myLoginName"];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLoginStaffSign] == YES) {
        [self.sessionManager.requestSerializer setValue:checkSafeString([SYBLocalDataTool getStaffMerhcantCode])
        forHTTPHeaderField:@"merchantCode"];
    }
    [self.sessionManager GET:url parameters:param headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 是否需要 MBP 菊花
        if (isNeed == YES) {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        // 成功，解析 respoObject
        NSDictionary *dict = [self dataReserveForDictionaryWithData:responseObject];
        if (dict) {
            // 判断后台返回的 code 是否为零
            if ([dict[@"code"] integerValue] == 200 || [dict[@"statusCode"] integerValue] == 200) {
                complete(dict);
            }
            else {
                if ([dict[@"code"] integerValue] == 401) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kTokenChangedNotification
                                                                        object:nil];
                } else if ([dict[@"code"] integerValue] == 402) {
                    [self userAccountNotExitMessage];
                } else {
                    faild(dict);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 是否需要 MBP 菊花
        if (isNeed == YES) {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        // 失败
        [self showErrorToastWithErrorCode:error.code];
        
    }];
}
/**
 *  @brief  POST 请求
 */
- (void)POSTRequestWithURL:(NSString *)url param:(id)param isNeedSVP:(BOOL)isNeed completeHandler:(CompleteHandler)complete faildHandler:(FaildureHandler)faild {
    // 检查当前网络状态
//    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    if ([param isKindOfClass:[NSDictionary class]]) {
        DNLog(@"请求地址：%@%@",url,[self paramsStrWith:param]);
    }
    // 是否需要 MBP 菊花
    if (isNeed == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
        });
    }
    DNLog(@"token----> %@", [SYBUserInfo shareUserInfo].token);
    // 将登录名和token放进请求头
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLoginSuccess] == YES) {
        [self.sessionManager.requestSerializer setValue:[SYBUserInfo shareUserInfo].token
                                     forHTTPHeaderField:@"token"];
        NSString *myLoginName = [[SYBUserInfo shareUserInfo].loginName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        [self.sessionManager.requestSerializer setValue:myLoginName
                                     forHTTPHeaderField:@"myLoginName"];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLoginStaffSign] == YES) {
        [self.sessionManager.requestSerializer setValue:checkSafeString([SYBLocalDataTool getStaffMerhcantCode])
        forHTTPHeaderField:@"merchantCode"];
    }
    // POST 请求
    [self.sessionManager POST:url parameters:param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 是否需要 MBP 菊花
        if (isNeed == YES) {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        // 成功，解析 respoObject
        NSDictionary * dict = [self dataReserveForDictionaryWithData:responseObject];
        if (dict) {
            // 判断后台返回的 code 是否为零
            if ([dict[@"code"] integerValue] == 200) {
                complete(dict);
            }
            else {
                if ([dict[@"code"] integerValue] == 401) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kTokenChangedNotification
                                                                        object:nil];
                } else if ([dict[@"code"] integerValue] == 402) {
                    [self userAccountNotExitMessage];
                } else {
                    faild(dict);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 是否需要 SVP 菊花
        if (isNeed == YES) {
            [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        }
        // 失败
        [self showErrorToastWithErrorCode:error.code];
    }];
}
/*
//单张图片上传
- (void)POSTImageWithURL:(NSString *)url param:(UIImage *)paramImage completeHandler:(CompleteHandler)complete faildHandler:(FaildureHandler)faild {
    // 检查当前网络状态
//    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    DNLog(@"请求地址：%@",url);
    // 显示 MBP 菊花
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
    });
    self.sessionManager.requestSerializer.timeoutInterval = 15.f;
    
    [self.sessionManager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString * dateStr = [self GETCurrentDate];
        NSString * fileName = [NSString stringWithFormat:@"%@.png",dateStr];
        
        NSData * imageData = UIImageJPEGRepresentation(paramImage, 0.1);
        double scaleNum = (double)300*1024/imageData.length;
        imageData = scaleNum < 1 ? UIImageJPEGRepresentation(paramImage, scaleNum):UIImageJPEGRepresentation(paramImage, 0.1);
        
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpg/png/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        // 成功，解析 respoObject
        NSDictionary * dict = [self dataReserveForDictionaryWithData:responseObject];
        if (dict) {
            // 判断后台返回的 code 是否为零
            if ([dict[@"code"] integerValue] == 200) {
                complete(dict);
            }
            else {
                faild(dict);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        // 失败
        [self showErrorToastWithErrorCode:error.code];
        
    }];
}

//多张图片上传
- (void)POSTImageWithURL:(NSString *)url params:(NSArray *)paramArr completeHandler:(CompleteHandler)complete faildHandler:(FaildureHandler)faild
{
    // 检查当前网络状态
//    [self netWorkMonitoring];
    // 拼接 URL
    url = [HOST stringByAppendingString:url];
    DNLog(@"请求地址：%@",url);
    // 显示 MBP 菊花
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD showHUDAddedTo:MAINWINDOW animated:YES];
    });
    [self.sessionManager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 遍历数组
        for (int i = 0; i < paramArr.count; i ++) {
            // 将数组中的 URL 转成 data
            NSData  * data = [NSData dataWithContentsOfURL:paramArr[i]];
            UIImage * image = [UIImage imageWithData:data];
            
            NSString * dateStr  = [self GETCurrentDate];
            NSString * fileName = [NSString stringWithFormat:@"%@.png",dateStr];
            
            NSData * imageData = UIImageJPEGRepresentation(image, 1);
            double   scaleNum  = (double)300*1024/imageData.length;
            imageData = scaleNum < 1 ? UIImageJPEGRepresentation(image, scaleNum):UIImageJPEGRepresentation(image, 0.1);
            
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        // 成功，解析 respoObject
        NSDictionary * dict = [self dataReserveForDictionaryWithData:responseObject];
        if (dict) {
            // 判断后台返回的 code 是否为零
            if ([dict[@"code"] integerValue] == 200) {
                complete(dict);
            }
            else {
                faild(dict);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:MAINWINDOW animated:YES];
        // 失败
        [self showErrorToastWithErrorCode:error.code];
        
    }];
}
*/
/**
 *  @brief  data 转 字典
 */
- (NSDictionary *)dataReserveForDictionaryWithData:(id)data {
    
    if ([data isKindOfClass:[NSData class]]) {
        
        return [NSJSONSerialization JSONObjectWithData:data
                                               options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves
                                                 error:nil];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        
        return data;
    } else {
        
        return nil;
    }
}

/**
 *  @brief  字典转json字符串方法
 *  @param dict 字典
 *  @return 字符串
 */
- (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError * error;
    // 字典转 data
    NSData  * jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error];
    NSString *jsonString;
    if (!jsonData) {
        DNLog(@"字典转json字符串错误：%@",error);
    }
    else {
        jsonString = [[NSString alloc]initWithData:jsonData
                                          encoding:NSUTF8StringEncoding];
        // 替换掉 url 地址中的 \/
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" "
                            withString:@""
                               options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n"
                            withString:@""
                               options:NSLiteralSearch range:range2];
    
    return mutStr;
}

/**
 *  @brief  拼接参数
 *  @param  paramsDict 参数字典
 */
- (NSString * )paramsStrWith:(NSDictionary *)paramsDict
{
    NSString *str = paramsDict.count == 0 ? @"":@"?";
    for (NSString *key in paramsDict) {
        str = [str stringByAppendingString:key];
        str = [str stringByAppendingString:@"="];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",[paramsDict objectForKey:key]]];
        str = [str stringByAppendingString:@"&"];
    }
    if (str.length > 1) {
        str = [str substringToIndex:str.length - 1];
    }
    return str;
}

/**
 *  @brief  获取当前时间
 *  @return 字符串
 */
- (NSString *)GETCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formormat = [[NSDateFormatter alloc]init];
    [formormat setDateFormat:@"HH-mm-ss-sss"];
    
    return [formormat stringFromDate:date];
}

// 检测当前的网络状态
- (void)netWorkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case -1:
                DNLog(@"未识别网络");
                break;
            case 0:
                DNLog(@"未连接网络");
                break;
            case 1:
                DNLog(@"3G/4G网络");
                break;
            case 2:
                DNLog(@"WIFI网络");
                break;
        }
//        NSString * statusStr = [NSString stringWithFormat:@"%ld",(long)status];
//        // 保存设置状态
//        [[NSUserDefaults standardUserDefaults] setObject:statusStr forKey:@"NetStatus"];
//        [[NSUserDefaults standardUserDefaults] synchronize];// 及时存储
    }];
}

/**
 *  @brief  根据返回的code 弹出对应的提示框
 *
 *  @param  errorCode 错误代码
 */
- (void)showErrorToastWithErrorCode:(NSInteger)errorCode {
   
    switch (errorCode) {
        case -1001:
            [SELFSHARE showErrorMessage:@"请求超时,请检查网络是否异常"];
            break;
        case -1009:
            [SELFSHARE showErrorMessage:@"连接网络失败,请检查网络是否异常"];
            break;
        default:
            [SELFSHARE showErrorMessage:@"未能连接到服务器,请检查服务是否异常"];
            break;
    }
}

- (void)userAccountNotExitMessage {
    [SELFSHARE showErrorMessage:@"账号不存在"];
}

/** 弹窗 */
- (void)showErrorMessage:(NSString *)message {
    [MAINWINDOW makeToast:message duration:1.5 position:CSToastPositionCenter];
}

@end
