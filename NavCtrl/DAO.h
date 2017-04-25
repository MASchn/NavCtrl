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
#import "ManagedCompany+CoreDataClass.h"
#import "NavControllerAppDelegate.h"
#import "ManagedProduct+CoreDataClass.h"


@interface DAO : NSObject


//@property (nonatomic, retain) addScreenVC *addScreen;
@property (retain, nonatomic) NSMutableArray<Company*> *companyList;
@property (retain, nonatomic) NSMutableArray *managedCompanyList;
@property BOOL companyAdd;
@property BOOL productAdd;
@property BOOL companyEdit;
@property BOOL productEdit;
@property (retain, nonatomic) NSMutableArray *stockArray;
@property (strong, nonatomic) id<StockPriceDelegate> delegate;
@property(nonatomic, strong) NSManagedObjectContext *context;

+ (id)sharedManager;
-(void) createCompaniesAndProducts;
-(void)fetchStockData;
-(void) addCompany: (Company*) company;
-(void)deleteCompany: (Company*)company;
-(void)editCompany: (Company*) company;
-(void)addProduct: (Product*) product andCompany:(Company*) company;
-(void)editProduct: (Product*) product andCompany:(Company*) company;
-(void) fetchCoreData;


@end
