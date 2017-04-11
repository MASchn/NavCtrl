//
//  addScreenVC.h
//  NavCtrl
//
//  Created by Maxwell Schneider on 3/29/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface addScreenVC : UIViewController

@property (retain, nonatomic) DAO *dao;
//Current Company
//Current Product

@property (retain, nonatomic) Company *companyToEdit;
@property (retain, nonatomic) Product *productToEdit;
@end
