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
                        andProducts: (NSMutableArray*)productArray{
    if(self = [super init]){
    self.companyName = companyNameInput;
    self.companyLogo = [UIImage imageNamed:companyLogoInput];
    self.products = productArray;
    }
    return self;
}



@end
