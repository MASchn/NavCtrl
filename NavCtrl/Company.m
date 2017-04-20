//
//  Company.m
//  NavCtrl
//
//  Created by Maxwell Schneider on 3/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (instancetype)initWithCompanyName: (NSString*)companyNameInput
                            andLogo: (NSString*)companyLogoInput
                        andProducts: (NSMutableArray*)productArray
                          andTicker: (NSString*)companyTicker
                      andStockPrice: (NSString*)companyPrice{
    if(self = [super init]){
    self.companyName = companyNameInput;
    self.companyLogo = [UIImage imageNamed:companyLogoInput];
    self.products = productArray;
    self.ticker = companyTicker;
        self.stockPrice = companyPrice;
        self.companyImageString = companyLogoInput;
    }
    return self;
}


- (instancetype)initWithCompanyName: (NSString*)companyNameInput
                       downloadLogo: (UIImage*)companyLogoInput
                             ticker: (NSString*) companyTicker
                         stockPrice: (NSString*)companyPrice;
{
    
    self.companyName = companyNameInput;
    self.companyLogo = companyLogoInput;
    self.products = [[NSMutableArray alloc]init];
    self.ticker = companyTicker;
    self.stockPrice = companyPrice;
    
    return self;
}


@end
