//
//  SYBHomeManager.h
//  CashierChoke
//
//  Created by zjs on 2019/9/21.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYBHomeManager : NSObject


/// @brief 查询商家统计数据
/// @param completerHandler 完成回调
+ (void)queryMerchantPageDataCompleteHandler:(void (^)(id responseObj))completerHandler;


/// @brief 查询首页滚动广告
/// @param completerHandler 完成回调
+ (void)queryMerchantNoticeCompleteHandler:(void (^)(id responseObj))completerHandler;


/// @brief 查询轮播图
/// @param type     0 首页  1 推广页
/// @param completerHandler 完成回调
+ (void)queryBanner:(NSInteger)type completeHandler:(void (^)(id responseObj))completerHandler;

/// 取消订单
/// @param orderNum 订单号
/// @param completeHandler 成功回调
+ (void)revokeTradeOperate:(NSString *)orderNum completeHandler:(void (^)(id responseObj))completeHandler;

/// @brief 查询余额数据
/// @param pageNo 当前页码
/// @param startDate 开始时间
/// @param endDate 结束时间
/// @param status  状态
/// @param completerHandler 完成回调
+ (void)queryBalance:(NSInteger)pageNo startDate:(NSString *)startDate endDate:(NSString *)endDate status:(NSString *)status completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 查询乐刷打款接口
/// @param pageNo 当前页码
/// @param dateStr 日期
/// @param status 状态
/// @param completerHandler 完成回调
+ (void)queryLeshuaBalance:(NSInteger)pageNo dateStr:(NSString *)dateStr status:(NSString *)status completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 查询会员接口
/// @param pageNo 当前页码
/// @param keyWords 搜索关键字
/// @param completerHandler 完成回调
+ (void)queryMembership:(NSInteger)pageNo storeId:(NSString *)storeId keyWords:(NSString *)keyWords completeHandler:(void (^)(id responseObj))completerHandler;



/// @brief 设置会员卡
/// @param storeName 店铺名称
/// @param limitNum 限制库存数量
/// @param phone 客服电话
/// @param completerHandler 完成回调
+ (void)setMembershipCard:(NSString *)storeName limitNum:(NSString *)limitNum phone:(NSString *)phone completeHandler:(void (^)(id responseObj))completerHandler;

/// @brief 会员开卡
/// @param phone 手机号
/// @param code 验证码
/// @param nickName 会员名
/// @param birthday 生日
/// @param storeId 门店 id
/// @param completerHandler 完成回调
+ (void)addMembership:(NSString *)phone code:(NSString *)code nickName:(NSString *)nickName birthday:(NSString *)birthday storeId:(NSString *)storeId completeHandler:(void (^)(id responseObj))completerHandler;

/// 查询当前商家会员消费数据
/// @param completerHandler 完成回调
+ (void)queryMembershipDataCompleteHandler:(void (^)(id responseObj))completerHandler;


/// @brief 查询会员详情
/// @param membershipId 会员id
/// @param completerHandler 完成回调
+ (void)queryMembershipDetail:(NSString *)membershipId completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 获取某个会员的消费列表
/// @param pageNo 当前页码
/// @param memberCode 会员code
/// @param completerHandler 完成回调
+ (void)queryMembershipConsume:(NSInteger)pageNo memberCode:(NSString *)memberCode completeHandler:(void (^)(id responseObj))completerHandler;


/// 修改商户费率
/// @param userId 商户id
/// @param rate 更改费率
/// @param completerHandler 成功回调
/// @param failedHandler 失败回调
+ (void)changeMerchantRate:(NSString *)rate storeId:(NSString *)userId completeHandler:(void (^)(id responseObj))completerHandler failedHandler:(void (^)(id responseObj))failedHandler;

/// @brief 检测当前的会员是否存在
/// @param param 参数字典
/// @param completerHandler 完成回调
+ (void)checkMemberExist:(NSDictionary *)param completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 检测当前的会员是否完成注册
/// @param phone 手机号
/// @param storeId 门店id
/// @param completerHandler 完成回调
+ (void)selectMemberRegister:(NSString *)phone storeId:(NSString *)storeId completeHandler:(void (^)(id responseObj))completerHandler failedHandler:(void (^)(id responseObj))failedHandler;


/// 删除活动营销
/// @param type  0 充值 1消费反 2激活送
/// @param ID 删除的
/// @param completerHandler 完成

+ (void)deleteActivity:(NSString *)type ID:(NSString *)ID  completeHandler:(void (^)(id responseObj))completerHandler;

/// @brief 查询门店接口
/// @param pageNo 当前页码
/// @param keyWords 搜索关键字
/// @param completerHandler 完成回调
+ (void)queryMerchantStore:(NSInteger)pageNo merchantCode:(NSString *)merchantCode keyWords:(NSString *)keyWords completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 发布充值送活动接口
/// @param activeArr 活动数组
/// @param completerHandler 完成回调
+ (void)publicRechargeSend:(NSArray *)activeArr completeHandler:(void (^)(id _Nonnull))completerHandler;

/// @brief 发布激活送活动接口
/// @param name 活动名称
/// @param money 首冲金额
/// @param storeCode 门店code
/// @param completerHandler 完成回调
+ (void)publicActiveSend:(NSString *)name money:(NSString *)money storeCode:(NSString *)storeCode storeName:(NSString *)storeName completeHandler:(void (^)(id responseObj))completerHandler;

/// type 消费返类型 0 等级  1 等比例  2 百分比
/// @brief 发布充值送活动接口
/// @param activeArr 活动数组
/// @param completerHandler 完成回调
+ (void)publicConsumeBack:(NSArray *)activeArr completeHandler:(void (^)(id responseObj))completerHandler;



/// @brief 发布推荐送活动
/// @param name 活动名称
/// @param money 充值金额
/// @param rewords 奖励金额
/// @param storeId 门店id
/// @param completerHandler 完成回调
+ (void)publicRecomendSend:(NSString *)name money:(NSString *)money rewords:(NSString *)rewords storeId:(NSString *)storeId completeHandler:(void (^)(id responseObj))completerHandler;;


/// @brief 查询员工
/// @param pageNo 当前页码
/// @param keywords 搜索关键字
/// @param storeId 门店code
/// @param completerHandler 完成回调
+ (void)queryStaff:(NSInteger)pageNo keywords:(NSString *)keywords storeId:(NSString *)storeId completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 添加员工
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)insertStaff:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// @brief 修改员工
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)modifyStaff:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// @brief 添加门店
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)insertStore:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 修改门店
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)modifyStore:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 修改门店运营状态
/// @param status 店铺状态 (0:商家打烊, 1:营业中, 2:系统禁用)
/// @param storeId 门店id
/// @param completerHandler 完成回调
+ (void)modifyStoreStatus:(NSString *)status storeId:(NSString *)storeId completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 查询粉丝
/// @param pageNo 当前页码
/// @param completerHandler 完成回调
+ (void)queryFans:(NSInteger)pageNo completeHandler:(void (^)(id _Nonnull))completerHandler startTime:(NSString *)startTime endTime:(NSString *)endTime;


/// @brief 查询粉丝消费
/// @param pageNo 当前页码
/// @param completerHandler 完成回调
+  (void)queryFansConsume:(NSInteger)pageNo completeHandler:(void (^)(id _Nonnull))completerHandler startTime:(NSString *)startTime endTime:(NSString *)endTime;


/// @brief 查询粉丝奖励数据
/// @param completerHandler 完成回调
+ (void)queryFansRewordsDataCompleteHandler:(void (^)(id _Nonnull))completerHandler startTime:(NSString *)startTime endTime:(NSString *)endTime ;


/// @brief 查询商家账单列表
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)queryMerchantOrder:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 查询订单详情
/// @param orderNum 订单编号
/// @param completerHandler 完成回调
+ (void)queryMerchantOrderDetail:(NSString *)orderNum completeHandler:(void (^)(id responseObj))completerHandler;

/// @brief 查询会员账单列表
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)queryMembershipOrder:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 查询会员账单详情
/// @param orderId 账单 id
/// @param completerHandler 完成回调
+ (void)queryMembershipOrderDetail:(NSString *)orderId completeHandler:(void (^)(id responseObj))completerHandler;

/// @brief 查询对账数据
/// @param startDate 起始时间
/// @param endDate 结束时间
/// @param completerHandler 完成回调
+ (void)queryReconciliationData:(NSString *)startDate endDate:(NSString *)endDate storeId:(NSString *)storeId staffId:(NSString *)staffId status:(NSString *)status completeHandler:(void (^)(id responseObj))completerHandler;



/// @brief 查询对账账单数据
/// @param pageNo 当前页码
/// @param startDate 开始时间
/// @param endDate 结束时间
/// @param storeId 门店id
/// @param staffId 员工id
/// @param completerHandler 完成回调
+ (void)queryReconciliationBill:(NSInteger)pageNo
                      startDate:(NSString *)startDate
                        endDate:(NSString *)endDate
                        storeId:(NSString *)storeId
                        staffId:(NSString *)staffId
                completeHandler:(void (^)(id responseObj))completerHandler;


/// @brief 扫码支付接口
/// @param storeId 门店id
/// @param money 收款金额
/// @param paymentCode 被扫支付码
/// @param memberCode 会员code
/// @param desc 备注信息
/// @param isCash 是否现金
/// @param completerHandler 完成回调
+ (void)scanCodePayment:(NSString *)storeId
                  money:(NSString *)money
            paymentCode:(NSString *)paymentCode
             memberCode:(NSString *)memberCode
                   desc:(NSString *)desc
                 isCash:(NSString *)isCash
        completeHandler:(void (^)(id responseObj))completerHandler
           faildHandler:(void (^)(id responseObj))faildHandler;


/// @brief 扫会员码支付接口
/// @param storeId 门店id
/// @param money 收款金额
/// @param paymentCode 被扫支付码
/// @param memberCode 会员code
/// @param desc 备注信息
/// @param isCash 是否现金
/// @param completerHandler 完成回调
+ (void)scanMemberCodePayment:(NSString *)storeId
                        money:(NSString *)money
                  paymentCode:(NSString *)paymentCode
                   memberCode:(NSString *)memberCode
                         desc:(NSString *)desc
                       isCash:(NSString *)isCash
              completeHandler:(void (^)(id responseObj))completerHandler;

/// @brief 查询微信支付结果
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)queryWechatPayResult:(NSDictionary *)params
             completeHandler:(void (^)(id responseObj, BOOL isSuccess))completerHandler;



/// @brief 查询支付宝支付结果
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)queryAlipayResult:(NSDictionary *)params
          completeHandler:(void (^)(id responseObj, BOOL isSuccess))completerHandler;



/// @brief 查询乐刷支付结果接口
/// @param params 参数字典
/// @param completerHandler 完成回调
+ (void)queryLsPayResult:(NSDictionary *)params
         completeHandler:(void (^)(id responseObj, BOOL isSuccess))completerHandler;



/// @brief 申请退款接口
/// @param orderNum 订单编号
/// @param completeHandler 完成回调
+ (void)applyReturnMoney:(NSString *)orderNum completeHandler:(void(^)(id responseObj))completeHandler;



/// @brief 退款接口
/// @param orderNum 订单编号
/// @param completeHandler 完成回调
+ (void)confirmReturnMoney:(NSString *)orderNum noticeCode:(NSString *)noticeCode completeHandler:(void(^)(id responseObj))completeHandler;


/// @brief 提现接口
/// @param number 提现数量
/// type 0 粉丝 1 推广 2 银行卡
/// @param completeHandler 完成回调
+ (void)cashWithdrawal:(NSString *)number type:(NSString *)type  completeHandler:(void (^)(id _Nonnull))completeHandler;



/// @brief 获取提现记录接口
/// @param pageNo 当前页码
/// @param cashType 提现类型（ 0 粉丝提现    1 推广提现）
/// @param completeHandler 完成回调
+ (void)queryCashWithdrawalRecord:(NSInteger)pageNo cashType:(NSInteger)cashType completeHandler:(void(^)(id responseObj))completeHandler;


// 手动关闭乐刷的订单
+ (void)closeLushauOrder:(NSString *)orderNum completeHandler:(void(^)(id responseObj, BOOL isSuccess))completeHandler;

+ (void)deleteStaff:(NSString *)staffId completeHandler:(void(^)(id responseObj))completeHandler;


// kMembershipActiveAPI
+ (void)qeuryStoreActivity:(NSString *)storeId completeHandler:(void(^)(id responseObj))completeHandler;


/// 获取更多活动
+ (void)queryMoreActiveCompleteHandler:(void(^)(id responseObj))completeHandler;

/// 服务商添加员工
/// @param parmas 参数
/// @param completerHandler 回调结果
+ (void)agentAddSalesmanOperate:(NSDictionary *)parmas completeHandle:(void (^)(id responseObj))completerHandler;

/// 服务商更新员工信息
/// @param parmas 参数
/// @param completerHandler 回调结果
+ (void)agentUpdateSalesmanOperate:(NSDictionary *)parmas completeHandle:(void (^)(id responseObj))completerHandler;

/// 服务商删除员工
/// @param parmas 参数
/// @param completerHandler 回调结果
+ (void)agentDeleteSalesmanOperate:(NSDictionary *)parmas completeHandle:(void (^)(id responseObj))completerHandler;

/// 获取服务商员工信息
/// @param parmas 参数
/// @param completerHandler 回调结果
+ (void)agentSalesmanListInfo:(NSDictionary *)parmas completeHandle:(void (^)(id responseObj))completerHandler;


/// 获取商户类目
/// @param pageNo 页码
/// @param keyWords 关键字
/// @param completerHandler 回调
+ (void)queryMerchantType:(NSInteger)pageNo keyWords:(NSString *)keyWords completeHandler:(void (^)(id responseObj))completerHandler;

/// 查询插件订单信息
/// @param params 参数
/// @param completerHandler 回调
+ (void)queryPlugInOrderInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 查询商户线上日交易数据
/// @param params 参数
/// @param completerHandler 回调
+ (void)queryMerchantDayBillListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 查询商户会员日交易数据
/// @param params 参数
/// @param completerHandler 回调
+ (void)queryMerchantDayMemberBillListInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler;
/// 查询商户会员今日交易数据
/// @param params 参数
/// @param completerHandler 回调
+ (void)queryMerchantTodayMemberBillOrder:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull))completerHandler;

/// 添加员工
/// @param params 参数
/// @param completerHandler 回调
+ (void)addMerchantStaff:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 查询商户员工信息
/// @param params 参数
/// @param completerHandler 回调
+ (void)queryMerchantStaffInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 删除员工股
/// @param params 参数
/// @param completerHandler 回调
+ (void)deleteMerchantStaff:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 查询交易订单结果
/// @param orderNum 参数
/// @param completeHandler 回调
+ (void)queryTradeOrderResult:(NSString *)orderNum completeHandler:(void (^)(id responseObj))completeHandler;

/// 查询微信支付即好友信息
/// @param params 参数
/// @param completerHandler 回调
+ (void)queryWechatPaymentFriendInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull responseObj))completerHandler;

/// 参数微信支付即好友-管理话术
/// @param params 参数
/// @param completerHandler 回调
+ (void)queryWechatKeywordsInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull responseObj))completerHandler;

/// 参数微信支付即好友-删除关键词
/// @param params 参数
/// @param completerHandler 回调
+ (void)deleteWechatKeywordsInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull responseObj))completerHandler;

/// 参数微信支付即好友-添加关键词
/// @param params 参数
/// @param completerHandler 回调
+ (void)addWechatKeywordsInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull responseObj))completerHandler;

/// 参数微信支付即好友-保存微信二维码
/// @param params 参数
/// @param completerHandler 回调
+ (void)savePaymentFriendQrCodeInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull responseObj))completerHandler;

/// 参数微信支付即好友-关闭微信即好友功能
/// @param params 参数
/// @param completerHandler 回调
+ (void)deleteWechatPaymentFriendInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull responseObj))completerHandler;

/// 参数微信支付即好友-选择关键词显示
/// @param params 参数
/// @param completerHandler 回调
+ (void)selectWechatKeywordsInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull responseObj))completerHandler;

/// 查询订单优惠信息
/// @param params 参数
/// @param completerHandler 回调
+ (void)queryOrderCouponInfo:(NSDictionary *)params completeHandler:(void (^)(id _Nonnull responseObj))completerHandler;

@end

NS_ASSUME_NONNULL_END
