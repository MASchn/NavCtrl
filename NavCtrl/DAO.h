//
//  DAO.h
//  NavCtrl
//
//  Created by Maxwell Schneider on 3/29/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "StockPriceDelegate.h"



@interface DAO : NSObject


//@property (nonatomic, retain) addScreenVC *addScreen;
@property (retain, nonatomic) NSMutableArray<Company*> *companyList;
@property BOOL companyAdd;
@property BOOL productAdd;
@property BOOL companyEdit;
@property BOOL productEdit;
@property (retain, nonatomic) NSMutableArray *stockArray;
@property (strong, nonatomic) id<StockPriceDelegate> delegate;

+ (id)sharedManager;
-(void) createCompaniesAndProducts;
-(void)fetchStockData;


@end
