//
//  TJAppPay.m
//  TJAppleStorePay
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 tj. All rights reserved.
//

#import "TJAppPay.h"

@interface TJAppPay ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@end

@implementation TJAppPay

+ (TJAppPay *)shardAppPay
{
    static TJAppPay *appPay = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appPay = [[TJAppPay alloc] init];
        
        //监听购买结果
        [[SKPaymentQueue defaultQueue] addTransactionObserver:appPay];
        NSLog(@"开始监听购买结果");
    });
    
    return appPay;
}

+ (void)buy:(OrderInfo *)orderInfo completeTransaction:(Transaction)transaction
{
    if (transaction) {
        [TJAppPay shardAppPay].transaction = transaction;
    }
    
    //获取商品id
    NSArray *productIds = [[NSArray alloc] initWithObjects:orderInfo.productId, nil];
    NSSet *set = [NSSet setWithArray:productIds];
    
    //定义请求商品信息
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = [TJAppPay shardAppPay];
    
    //开始请求
    [request start];
}

#pragma mark SKProductsRequestDelegate
//查询的回调方法
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"------收到产品反馈信息------");
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID：%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量：%d",(int)[myProduct count]);
    
    //商品信息
    for(SKProduct *product in myProduct){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
    }
    
    //发起购买操作
    SKPayment *payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark SKPaymentTransactionObserver
//当用户购买的操作有结果时，就会触发下面的回调函数，相应进行处理
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: //交易完成
                NSLog(@"transactionIdentifier = %@",transaction.transactionIdentifier);
                break;
            case SKPaymentTransactionStateFailed: //交易失败
                NSLog(@"交易失败");
                break;
            case SKPaymentTransactionStateRestored: //已经购买过该商品
                NSLog(@"已经购买过该商品");
                break;
            case SKPaymentTransactionStatePurchasing: //商品添加进列表
                NSLog(@"商品添加进列表");
                break;
            default:
                break;
        }
        
        if ([TJAppPay shardAppPay].transaction) {
            [TJAppPay shardAppPay].transaction(transaction);
        }
    }
}

- (void)dealloc {
    //移除购买监听
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:[TJAppPay shardAppPay]];
    NSLog(@"移除购买监听");
}

@end
