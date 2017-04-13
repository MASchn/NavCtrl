//
//  StockPriceDelegate.h
//  NavCtrl
//
//  Created by Maxwell Schneider on 4/12/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StockPriceDelegate <NSObject>

-(void)didUpdateCompanyStockPrices;

@end
