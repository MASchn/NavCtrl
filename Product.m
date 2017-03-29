//
//  Product.m
//  NavCtrl
//
//  Created by Maxwell Schneider on 3/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product


-(instancetype)initWithProductName: (NSString*)productNameInput
                     andProductURL: (NSString*)productURLInput
                   andProductImage: (NSString*)imageInput{
    
    if(self = [super init]){
        self.productName = productNameInput;
        self.productURL = productURLInput;
        self.productImage = [UIImage imageNamed: imageInput];
    }
    return self;
}


@end