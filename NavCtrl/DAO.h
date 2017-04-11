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



@interface DAO : NSObject


//@property (nonatomic, retain) addScreenVC *addScreen;
@property (retain, nonatomic) NSMutableArray<Company*> *companyList;
@property BOOL companyAdd;
@property BOOL productAdd;
@property BOOL companyEdit;
@property BOOL productEdit;

+ (id)sharedManager;
-(void) createCompaniesAndProducts;


@end
