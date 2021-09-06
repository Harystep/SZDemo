//
//  SYBHomeManager.m
//  CashierChoke
//
//  Created by zjs on 2019/9/21.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "SYBHomeManager.h"
#import "SYBNetManager.h"

@implementation SYBHomeManager

+ (void)queryMerchantPageDataCompleteHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]       = [SYBUserInfo shareUserInfo].ID;
//    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMerchantPageDataAPI param:param isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryMerchantNoticeCompleteHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"storeId"] = [SYBUserInfo shareUserInfo].storeId;
    param[@"userType"] = [SYBUserInfo shareUserInfo].userType;
    [[SYBNetManager shareInstance] POSTRequestWithURL:kScrollNoticeAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
//        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryBanner:(NSInteger)type completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = [NSString stringWithFormat:@"0%ld", (long)type];
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kBannerAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryBalance:(NSInteger)pageNo startDate:(NSString *)startDate endDate:(NSString *)endDate status:(NSString *)status completeHandler:(void (^)(id responseObj))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"startTime"]    = startDate;
    param[@"endTime"] = endDate;
    param[@"status"]  = status;
    param[@"page"]    = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"]    = @"20";
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kHomeBalanceAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryLeshuaBalance:(NSInteger)pageNo dateStr:(NSString *)dateStr status:(NSString *)status completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"merchantId"] = [SYBUserInfo shareUserInfo].merchantId;
//    param[@"date"]    = dateStr;
//    param[@"state"]   = status;
    param[@"pageNo"]  = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"]    = @"20";
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kLeshuaBalanceAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMembership:(NSInteger)pageNo storeId:(NSString *)storeId keyWords:(NSString *)keyWords completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"] = @"20";
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"storeId"]      = storeId;
    param[@"nickName"]     = keyWords;
    param[@"phone"]        = keyWords;
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMembershipAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)setMembershipCard:(NSString *)storeName limitNum:(NSString *)limitNum phone:(NSString *)phone completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"storeName"] = storeName;
    param[@"cardNum"]   = limitNum;
    param[@"servicePhone"] = phone;
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kSetMembershipCardAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)addMembership:(NSString *)phone code:(NSString *)code nickName:(NSString *)nickName birthday:(NSString *)birthday storeId:(NSString *)storeId completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"phone"] = phone;
    param[@"checkCode"] = code;
    param[@"nickName"] = nickName;
    param[@"birthdayDt"] = birthday;
    param[@"storeId"] = storeId;
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kAddMembershipAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMembershipDataCompleteHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]       = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMembershipDataAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMembershipDetail:(NSString *)membershipId completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = membershipId;
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMembershipDetailAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryMembershipConsume:(NSInteger)pageNo memberCode:(NSString *)memberCode completeHandler:(void (^)(id responseObj))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"] = @"20";
    param[@"memberCode"] = memberCode;
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kMembershipConsumeListAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

/// @brief 检测当前的会员是否存在
+ (void)checkMemberExist:(NSDictionary *)param completeHandler:(void (^)(id responseObj))completerHandler {
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kCheckMemberExistAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

/// @brief 检测当前的会员是否完成注册
+ (void)selectMemberRegister:(NSString *)phone storeId:(NSString *)storeId completeHandler:(void (^)(id responseObj))completerHandler failedHandler:(void (^)(id responseObj))failedHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"]     = phone;
    param[@"storeId"]   = storeId;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kSelectMemberRegisterAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        failedHandler(data);
    }];
}

+ (void)changeMerchantRate:(NSString *)rate storeId:(NSString *)userId completeHandler:(void (^)(id responseObj))completerHandler failedHandler:(void (^)(id responseObj))failedHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]     = userId;
    param[@"rate"]   = rate;
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kChangeMarchentRateAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        failedHandler(data);
    }];
}

+ (void)queryMerchantType:(NSInteger)pageNo keyWords:(NSString *)keyWords completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"current"] = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"] = @"30";
    param[@"keyWord"] = keyWords;
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kMerchantTypeAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMerchantStore:(NSInteger)pageNo merchantCode:(NSString *)merchantCode keyWords:(NSString *)keyWords completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"] = @"30";
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = merchantCode;
    param[@"storeName"] = keyWords;
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMerchantStoreAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)publicRechargeSend:(NSArray *)activeArr completeHandler:(void (^)(id _Nonnull))completerHandler {
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMembershipRechargeSendAPI param:activeArr isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)publicActiveSend:(NSString *)name money:(NSString *)money storeCode:(NSString *)storeCode storeName:(NSString *)storeName completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"merchantName"] = [SYBUserInfo shareUserInfo].merchantName;
    param[@"name"]      = name;
    param[@"giveMoney"] = money;
    param[@"storeId"]   = storeCode;
    param[@"storeName"] = storeName;
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMembershipActiveSendAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)publicConsumeBack:(NSArray *)activeArr completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMembershipConsumBackAPI param:activeArr isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)publicRecomendSend:(NSString *)name money:(NSString *)money rewords:(NSString *)rewords storeId:(NSString *)storeId completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"name"]         = name;
    param[@"firstMixRechargeMoney"] = money;
    param[@"recommendMoney"] = rewords;
    param[@"storeId"]   = storeId;
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMembershipRecomendSendAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryStaff:(NSInteger)pageNo keywords:(NSString *)keywords storeId:(NSString *)storeId completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"page"]      = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"]      = @"20";
    param[@"userType"]  = @"staff";
    param[@"userName"]  = keywords;
    param[@"loginName"] = keywords;
    param[@"storeId"]   = storeId;
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kQueryStaffAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)insertStaff:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kInsertStaffAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)modifyStaff:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kModifyStaffAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)insertStore:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kInsertStoreAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)modifyStore:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kModifyStoreAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)modifyStoreStatus:(NSString *)status storeId:(NSString *)storeId completeHandler:(void (^)(id responseObj))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"storeId"] = storeId;
    param[@"status"]  = status;
    param[@"userId"]  = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kModifyStoreStatusAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryFans:(NSInteger)pageNo completeHandler:(void (^)(id _Nonnull))completerHandler startTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"]   = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"]   = @"20";
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"startTime"] = startTime;
    param[@"endTime"] = endTime;
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kQueryFansAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryFansConsume:(NSInteger)pageNo completeHandler:(void (^)(id _Nonnull))completerHandler startTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"]   = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"]   = @"20";
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"startTime"]  = startTime;
    param[@"endTime"]  = endTime;
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kQueryFansConsumeAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryFansRewordsDataCompleteHandler:(void (^)(id _Nonnull))completerHandler startTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]       = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kQueryFansRewardsAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryMerchantOrder:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMerchantOrderListAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMerchantOrderDetail:(NSString *)orderNum completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kMerchantOrderDetailAPI, orderNum];
    [[SYBNetManager shareInstance] GETRequestWithURL:url param:@{} isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMembershipOrder:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kMembershipOrderListAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMembershipOrderDetail:(NSString *)orderId completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kMembershipOrderDetailAPI, orderId];
    [[SYBNetManager shareInstance] GETRequestWithURL:url param:@{} isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryReconciliationData:(NSString *)startDate endDate:(NSString *)endDate storeId:(NSString *)storeId staffId:(NSString *)staffId status:(NSString *)status completeHandler:(void (^)(id _Nonnull))completerHandler {
        
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]       = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"startTime"]    = startDate;
    param[@"endTime"]      = endDate;
    param[@"storeId"]      = storeId;
    param[@"staffCode"]    = staffId;
    param[@"status"]       = status;
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kReconciliationDataAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryReconciliationBill:(NSInteger)pageNo startDate:(NSString *)startDate endDate:(NSString *)endDate storeId:(NSString *)storeId staffId:(NSString *)staffId completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]       = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"startTime"]    = startDate;
    param[@"endTime"]      = endDate;
    param[@"storeId"]      = storeId;
    param[@"staffCode"]    = staffId;
    param[@"page"]         = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"]         = @"20";
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kReconciliationBillDataAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)deleteActivity:(NSString *)type ID:(NSString *)ID  completeHandler:(void (^)(id _Nonnull responseObj))completerHandler {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"]       = type;
    param[@"ID"] = ID;
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    [[SYBNetManager shareInstance] POSTRequestWithURL:kDeleteActivityAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        completerHandler(responseObj);
    } faildHandler:^(id  _Nonnull data) {
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
    
}


+ (void)scanCodePayment:(NSString *)storeId money:(NSString *)money paymentCode:(NSString *)paymentCode memberCode:(NSString *)memberCode desc:(NSString *)desc isCash:(NSString *)isCash completeHandler:(void (^)(id _Nonnull))completerHandler faildHandler:(void (^)(id responseObj))faildHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]       = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"aisleSwitch"]  = [SYBUserInfo shareUserInfo].aisleSwitch;
    param[@"merchantId"]  = [SYBUserInfo shareUserInfo].aisleSwitch.intValue == 2 ? [SYBUserInfo shareUserInfo].merchantId:@"";
    param[@"storeId"]      = storeId;
    param[@"consumeFee"]   = money;
    param[@"authCode"]     = paymentCode;
    param[@"memberCode"]   = memberCode;
    param[@"remark"]       = desc;
    param[@"isCash"]       = isCash;
    param[@"staffName"]    = [SYBUserInfo shareUserInfo].userName;
    DNLog(@"param--->%@", param);
    [[SYBNetManager shareInstance] POSTRequestWithURL:kScanCodePaymentAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        faildHandler(data);
    }];
}


+ (void)scanMemberCodePayment:(NSString *)storeId money:(NSString *)money paymentCode:(NSString *)paymentCode memberCode:(NSString *)memberCode desc:(NSString *)desc isCash:(NSString *)isCash completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]       = [SYBUserInfo shareUserInfo].ID;
    param[@"staffName"]    = [SYBUserInfo shareUserInfo].userName;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"storeId"]      = storeId;
    param[@"consumeFee"]   = money;
    param[@"authCode"]     = memberCode;
    param[@"memberCode"]   = paymentCode;
    param[@"remark"]       = desc;
    param[@"isCash"]       = isCash;
    
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kScanMemberPayAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryWechatPayResult:(NSDictionary *)params completeHandler:(nonnull void (^)(id _Nonnull, BOOL))completerHandler {
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kQueryWechatResultAPI param:params isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj, YES);
        
    } faildHandler:^(id  _Nonnull data) {
        
        completerHandler(data, NO);
    }];
}


+ (void)queryAlipayResult:(NSDictionary *)params completeHandler:(nonnull void (^)(id _Nonnull, BOOL))completerHandler {
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kQueryAlipayResultAPI param:params isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj, YES);
        
    } faildHandler:^(id  _Nonnull data) {
        
        completerHandler(data, NO);
    }];
}

+ (void)revokeTradeOperate:(NSString *)orderNum completeHandler:(void (^)(id _Nonnull))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"orderNumber"] = orderNum;    
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kCloseLeshuaOrderAPI param:param isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        
        completeHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryTradeOrderResult:(NSString *)orderNum completeHandler:(void (^)(id responseObj))completeHandler {
    NSString *url = [NSString stringWithFormat:@"%@%@", kQueryTradeOrderInfoAPI, orderNum];
    [[SYBNetManager shareInstance] GETRequestWithURL:url param:@{} isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        completeHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryLsPayResult:(NSDictionary *)params completeHandler:(void (^)(id responseObj, BOOL isSuccess))completerHandler {
            
    [[SYBNetManager shareInstance] POSTRequestWithURL:kQueryLsPayResultAPI param:params isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj, YES);
        
    } faildHandler:^(id  _Nonnull data) {
        
        completerHandler(data, NO);
    }];
}

+ (void)applyReturnMoney:(NSString *)orderNum completeHandler:(void (^)(id _Nonnull))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"orderNumber"] = orderNum;
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kApplyReturnMoneyAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completeHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)confirmReturnMoney:(NSString *)orderNum noticeCode:(NSString *)noticeCode completeHandler:(void (^)(id _Nonnull))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"orderNumber"] = orderNum;
    param[@"noticeCode"]  = noticeCode;
        
    [[SYBNetManager shareInstance] GETRequestWithURL:kComfirmReturnMoneyAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {

        completeHandler(responseObj);

    } faildHandler:^(id  _Nonnull data) {

        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)cashWithdrawal:(NSString *)number type:(NSString *)type  completeHandler:(void (^)(id _Nonnull))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"]  = [SYBUserInfo shareUserInfo].ID;
    param[@"cashAmt"] = number;
    param[@"type"] = type;
        
    [[SYBNetManager shareInstance] POSTRequestWithURL:kCashWithdrawalAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {

        completeHandler(responseObj);

    } faildHandler:^(id  _Nonnull data) {

        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryCashWithdrawalRecord:(NSInteger)pageNo cashType:(NSInteger)cashType completeHandler:(void (^)(id _Nonnull))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [SYBUserInfo shareUserInfo].ID;
    param[@"merchantCode"] = [SYBUserInfo shareUserInfo].merchantCode;
    param[@"type"] = [NSString stringWithFormat:@"%ld", (long)cashType];
    param[@"page"] = [NSString stringWithFormat:@"%ld", (long)pageNo];
    param[@"size"] = @"20";
        
    [[SYBNetManager shareInstance] GETRequestWithURL:kCashWithdrawalAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {

        completeHandler(responseObj);

    } faildHandler:^(id  _Nonnull data) {

        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)closeLushauOrder:(NSString *)orderNum completeHandler:(void(^)(id responseObj, BOOL isSuccess))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"merchantId"] = [SYBUserInfo shareUserInfo].merchantId;
    param[@"orderNumber"] = orderNum;
        
    [[SYBNetManager shareInstance] GETRequestWithURL:kCashWithdrawalAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {

        completeHandler(responseObj, YES);

    } faildHandler:^(id  _Nonnull data) {

        completeHandler(data, NO);
    }];
}

+ (void)deleteStaff:(NSString *)staffId completeHandler:(void(^)(id responseObj))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = staffId;
        
    [[SYBNetManager shareInstance] GETRequestWithURL:kDeleteStaffAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {

        completeHandler(responseObj);

    } faildHandler:^(id  _Nonnull data) {

        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

// kMembershipActiveAPI
+ (void)qeuryStoreActivity:(NSString *)storeId completeHandler:(void(^)(id responseObj))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"storeId"]          = storeId;
    param[@"merchantCode"]     = [SYBUserInfo shareUserInfo].merchantCode;
        
    [[SYBNetManager shareInstance] GETRequestWithURL:kMembershipActiveAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {

        completeHandler(responseObj);

    } faildHandler:^(id  _Nonnull data) {

        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


+ (void)queryMoreActiveCompleteHandler:(void(^)(id responseObj))completeHandler {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"merchantCode"]     = [SYBUserInfo shareUserInfo].merchantCode;
        
    [[SYBNetManager shareInstance] GETRequestWithURL:kQueryActivityListAPI param:param isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {

        completeHandler(responseObj);

    } faildHandler:^(id  _Nonnull data) {

        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)agentAddSalesmanOperate:(NSDictionary *)parmas completeHandle:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kAddSalesmanAPI param:parmas isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)agentUpdateSalesmanOperate:(NSDictionary *)parmas completeHandle:(void (^)(id _Nonnull))completerHandler {
    [[SYBNetManager shareInstance] POSTRequestWithURL:kUpdateSalesmanAPI param:parmas isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)agentDeleteSalesmanOperate:(NSDictionary *)parmas completeHandle:(void (^)(id _Nonnull))completerHandler {
    NSString *salemanUrl = [kDeleteSalesmanAPI stringByAppendingString:[NSString stringWithFormat:@"/%@", parmas[@"userId"]]];
                            
    [[SYBNetManager shareInstance] GETRequestWithURL:salemanUrl param:@{} isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)agentSalesmanListInfo:(NSDictionary *)parmas completeHandle:(void (^)(id _Nonnull))completerHandler {
    NSString *salemanUrl = [kAgentSalesmanInfoAPI stringByAppendingString:[NSString stringWithFormat:@"?size=%@&current=%@&pId=%@", parmas[@"size"], parmas[@"page"], parmas[@"userId"]]];
    [[SYBNetManager shareInstance] GETRequestWithURL:salemanUrl param:@{} isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryPlugInOrderInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kMerchantPlugInOrderListAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
    
}

+ (void)queryMerchantDayBillListInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    [[SYBNetManager shareInstance] GETRequestWithURL:kQueryMerchantDayBillListAPI param:params isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMerchantDayMemberBillListInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    [[SYBNetManager shareInstance] GETRequestWithURL:kQueryMerchantDayMemberBillListAPI param:params isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMerchantTodayMemberBillOrder:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kMerchantTodayMemberOrderAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)addMerchantStaff:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] POSTRequestWithURL:kAddMerchantStaffInfoAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryMerchantStaffInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    NSString *url = [NSString stringWithFormat:@"%@/%@", kAddMerchantStaffInfoAPI, params[@"userId"]];
    [[SYBNetManager shareInstance] GETRequestWithURL:url param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)deleteMerchantStaff:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kDeleteMerchantStaffInfoAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryWechatPaymentFriendInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    
    [[SYBNetManager shareInstance] GETRequestWithURL:kQueryWechatPaymentInfoAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryWechatKeywordsInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    [[SYBNetManager shareInstance] GETRequestWithURL:kQueryWechatKeywordsInfoAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)deleteWechatKeywordsInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    NSString *url = [NSString stringWithFormat:@"%@/%@", kDeleteWechatKeywordsInfoAPI, params[@"id"]];
    [[SYBNetManager shareInstance] GETRequestWithURL:url param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)addWechatKeywordsInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    [[SYBNetManager shareInstance] POSTRequestWithURL:kAddWechatKeywordsInfoAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)savePaymentFriendQrCodeInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    [[SYBNetManager shareInstance] POSTRequestWithURL:kSaveWechatQrCodeInfoAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)selectWechatKeywordsInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    [[SYBNetManager shareInstance] POSTRequestWithURL:kSetKeywordStatusInfoAPI param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)deleteWechatPaymentFriendInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    NSString *url = [NSString stringWithFormat:@"%@/%@", kDeletePaymentFriendInfoAPI, params[@"userId"]];
    [[SYBNetManager shareInstance] GETRequestWithURL:url param:params isNeedSVP:YES completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}

+ (void)queryOrderCouponInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler {
    NSString *url = [NSString stringWithFormat:@"%@/%@", kQueryOrderCouponInfoAPI, params[@"orderNumber"]];
    [[SYBNetManager shareInstance] GETRequestWithURL:url param:params isNeedSVP:NO completeHandler:^(id  _Nonnull responseObj) {
        
        completerHandler(responseObj);
        
    } faildHandler:^(id  _Nonnull data) {
        
        [MAINWINDOW makeToast:data[@"message"] duration:1.5 position:CSToastPositionCenter];
    }];
}


@end
