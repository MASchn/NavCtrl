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



@property (retain, nonatomic) NSMutableArray<Company*> *companyList;

+ (id)sharedManager;
-(void) createCompaniesAndProducts;


@end
