//
//  CompanyVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductVC.h"
#import "DAO.h"

@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) DAO *dao;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) ProductVC *productViewController;
@property (nonatomic, retain) NSMutableArray *appleProducts;
@property (nonatomic, retain) NSMutableArray *samsungProducts;
@property (nonatomic, retain) NSMutableArray *googleProducts;
@property (nonatomic, retain) NSMutableArray *microsoftProducts;
@end
