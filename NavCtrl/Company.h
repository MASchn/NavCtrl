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

- (instancetype)initWithCompanyName: (NSString*)companyName
                            andLogo: (NSString*)companyLogo
                        andProducts: (NSMutableArray*)productArray;



- (instancetype)initWithCompanyName: (NSString*)companyName
                       downloadLogo: (UIImage*)companyLogo;
@end
