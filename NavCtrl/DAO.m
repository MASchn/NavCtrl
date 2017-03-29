//
//  DAO.m
//  NavCtrl
//
//  Created by Maxwell Schneider on 3/29/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

+ (id)sharedManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        [sharedMyManager createCompaniesAndProducts];
        
    });
    return sharedMyManager;
}


-(void) createCompaniesAndProducts {

Product *iPad = [[Product alloc]initWithProductName:@"iPad" andProductURL:@"http://www.apple.com/ipad/" andProductImage:@"ipad.png"];

Product *iPodTouch = [[Product alloc]initWithProductName:@"ipod Touch" andProductURL:@"http://www.apple.com/ipod/" andProductImage:@"ipod.png"];

Product *iPhone = [[Product alloc]initWithProductName:@"iPhone" andProductURL:@"http://www.apple.com/iphone/" andProductImage:@"iphone.png"];

Company *apple = [[Company alloc]initWithCompanyName:@"Apple" andLogo:@"apple.jpg" andProducts: [[NSMutableArray alloc] initWithObjects:iPad, iPodTouch, iPhone, nil]];


//Samsung Stuff


Product *galaxyS7 = [[Product alloc]initWithProductName:@"Galaxy S7" andProductURL:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+s7" andProductImage:@"S7.png"];

Product *galaxyNote = [[Product alloc]initWithProductName:@"Galaxy Note" andProductURL:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+note&rh=i%3Aaps%2Ck%3Agalaxy+note" andProductImage:@"note3.jpg"];

Product *galaxyTab = [[Product alloc]initWithProductName:@"Galaxy Tab" andProductURL:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+tab&rh=i%3Aaps%2Ck%3Agalaxy+tab" andProductImage:@"tab.png"];


Company *samsung = [[Company alloc]initWithCompanyName:@"Samsung" andLogo:@"samsung.png" andProducts:[[NSMutableArray alloc]initWithObjects:galaxyS7, galaxyTab, galaxyNote, nil]];


//Google stuff


Product *pixel = [[Product alloc] initWithProductName:@"Pixel"
                                        andProductURL:@"https:store.google.com/product/pixel_phone"
                                      andProductImage:@"pixel.jpeg"];

Product *nexus = [[Product alloc] initWithProductName:@"Nexus"
                                        andProductURL:@"https://www.google.com/nexus/"
                                      andProductImage:@"nexus.jpg"];

Product *daydream = [[Product alloc] initWithProductName:@"Daydream Device"
                                           andProductURL:@"https://vr.google.com/daydream/"
                                         andProductImage:@"daydream.jpg"];


Company *google = [[Company alloc]initWithCompanyName:@"Google" andLogo:@"google.png" andProducts:[[NSMutableArray alloc]initWithObjects:pixel, nexus, daydream, nil]];


//Microsoft stuff



Product *lumia = [[Product alloc] initWithProductName:@"Lumia 950"
                                        andProductURL:@"https://www.microsoft.com/en-us/mobile/phone/lumia950/"
                                      andProductImage:@"lumia.jpg"];

Product *xps = [[Product alloc] initWithProductName:@"XPS Laptop"
                                      andProductURL:@"https://www.amazon.com/Dell-XPS-15-15-6-Inch-i7-6700HQ/dp/B019PB6X78"
                                    andProductImage:@"xps.png"];


Product *surfacePro = [[Product alloc] initWithProductName:@"Surface"
                                             andProductURL:@"https://www.microsoftstore.com/store/msusa/en_US/cat/All-Surface/categoryID.69403400"
                                           andProductImage:@"surfacePro.jpg"];


Company *microsoft = [[Company alloc]initWithCompanyName:@"Microsoft" andLogo:@"microsoft.png" andProducts:[[NSMutableArray alloc]initWithObjects:lumia,xps, surfacePro, nil]];

self.companyList = [[NSMutableArray alloc]initWithObjects: apple, samsung, google, microsoft, nil];

   
}
@end
