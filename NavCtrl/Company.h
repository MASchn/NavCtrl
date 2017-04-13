//
//  Company.h
//  NavCtrl
//
//  Created by Maxwell Schneider on 3/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject



@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) UIImage *companyLogo;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSString *ticker;
@property (nonatomic, retain) NSString *stockPrice;

- (instancetype)initWithCompanyName: (NSString*)companyName
                            andLogo: (NSString*)companyLogo
                        andProducts: (NSMutableArray*)productArray
                          andTicker: (NSString*)companyTicker
                      andStockPrice: (NSString*) companyPrice;



- (instancetype)initWithCompanyName: (NSString*)companyName
                       downloadLogo: (UIImage*)companyLogo
                             ticker: (NSString*)companyTicker
                         stockPrice:(NSString*)companyPrice;
@end
