//
//  AppleStorePayVC.m
//  app
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import "AppleStorePayVC.h"
#import "OrderInfo.h"
#import <StoreKit/StoreKit.h>

@interface AppleStorePayVC ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@end

@implementation AppleStorePayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //监听购买结果
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    OrderInfo *order = [[OrderInfo alloc] init];
    order.productId = @"com.rtsapp.gold6";
    
    [self buy:order];
    
}

- (void)dealloc {
    
    //移除购买监听
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

//用户点击一个IAP项目时，首先查询用户是否允许应用内付费
- (void)buy:(OrderInfo *)orderInfo
{
    NSArray *productIds = [[NSArray alloc] initWithObjects:orderInfo.productId, nil];
    
    NSSet *set = [NSSet setWithArray:productIds];
    
    //请求商品信息
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    
    [request start];
    
}

#pragma mark SKProductsRequestDelegate
//查询的回调方法
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID：%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量：%d",(int)[myProduct count]);
    
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
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
