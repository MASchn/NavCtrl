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
        
        NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        sharedMyManager.context = context;
        sharedMyManager.managedCompanyList = [[NSMutableArray alloc] init];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Ran Once"] == NO){
        [sharedMyManager createCompaniesAndProducts];
        }
        else{
            
           
            [sharedMyManager fetchCoreData];
//            [sharedMyManager.managedCompanyList release];
            //Fetchrequest method
            
        }
    });
    return sharedMyManager;
}


//NSFetchRequest


-(void) createCompaniesAndProducts {
    

    
    
    self.companyAdd = NO;
    self.productAdd = NO;
    self.companyEdit = NO;
    self.productEdit = NO;
    

Product *iPad = [[Product alloc]initWithProductName:@"iPad" andProductURL:@"http://www.apple.com/ipad/" andProductImage:@"ipad.png"];

Product *iPodTouch = [[Product alloc]initWithProductName:@"ipod Touch" andProductURL:@"http://www.apple.com/ipod/" andProductImage:@"ipod.png"];

Product *iPhone = [[Product alloc]initWithProductName:@"iPhone" andProductURL:@"http://www.apple.com/iphone/" andProductImage:@"iphone.png"];

    Company *apple = [[Company alloc]initWithCompanyName:@"Apple" andLogo:@"apple.jpg" andProducts: [[NSMutableArray alloc] initWithObjects:iPad, iPodTouch, iPhone, nil] andTicker: @"AAPL" andStockPrice: @"Loading..."];


//Samsung Stuff


Product *galaxyS7 = [[Product alloc]initWithProductName:@"Galaxy S7" andProductURL:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+s7" andProductImage:@"S7.png"];

Product *galaxyNote = [[Product alloc]initWithProductName:@"Galaxy Note" andProductURL:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+note&rh=i%3Aaps%2Ck%3Agalaxy+note" andProductImage:@"note3.jpg"];

Product *galaxyTab = [[Product alloc]initWithProductName:@"Galaxy Tab" andProductURL:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+tab&rh=i%3Aaps%2Ck%3Agalaxy+tab" andProductImage:@"tab.png"];


    Company *samsung = [[Company alloc]initWithCompanyName:@"Samsung" andLogo:@"samsung.png" andProducts:[[NSMutableArray alloc]initWithObjects:galaxyS7, galaxyTab, galaxyNote, nil] andTicker: @"SSNLF" andStockPrice: @"Loading..."];


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


Company *google = [[Company alloc]initWithCompanyName:@"Google" andLogo:@"google.png" andProducts:[[NSMutableArray alloc]initWithObjects:pixel, nexus, daydream, nil] andTicker:@"GOOG" andStockPrice: @"Loading..."];


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


    Company *microsoft = [[Company alloc]initWithCompanyName:@"Microsoft" andLogo:@"microsoft.png" andProducts:[[NSMutableArray alloc]initWithObjects:lumia,xps, surfacePro, nil] andTicker: @"MSFT" andStockPrice: @"Loading..."];

self.companyList = [[NSMutableArray alloc]initWithObjects: apple, samsung, google, microsoft, nil];
    
    
    
    for (Company *comp in self.companyList) {
        
        
        ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.context];
        mC.companyName = comp.companyName;
        mC.companyTicker = comp.ticker;
        mC.companyLogoString = comp.companyImageString;
        for (Product *prod in comp.products) {
            ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.context];
            mP.productName = prod.productName;
            mP.productURL = prod.productURL;
            mP.imageString = prod.productImageString;
            [mP setCompany:mC];
            [mC.products setByAddingObject:mP];
            
            //Do URL Image String stuff here
        }
        
        [self.managedCompanyList addObject:mC];
        
        
        
        
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Ran Once"];
    }


    [self.context save:nil];
    
    [microsoft release];
    [apple release];
    [google release];
    [samsung release];
    [surfacePro release];
    [xps release];
    [lumia release];
    [daydream release];
    [nexus release];
    [pixel release];
    [galaxyS7 release];
    [galaxyTab release];
    [galaxyNote release];
    [iPad release];
    [iPhone release];
    [iPodTouch release];
}


-(void) fetchCoreData {
    self.companyList = [[NSMutableArray alloc] init];
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ManagedCompany"];
    
    NSError *err = nil;

    NSArray *results = [self.context executeFetchRequest:request error:&err];
    

    
    self.managedCompanyList = [results mutableCopy];
    

    
    for (ManagedCompany *mC in self.managedCompanyList) {
        
        
        Company *newComp = [[Company alloc] initWithCompanyName:mC.companyName andLogo:mC.companyLogoString andProducts:nil andTicker:mC.companyTicker andStockPrice:@"Loading..."];
        
        newComp.products = [[NSMutableArray alloc]init];
        
//        NSLog(@"%lu", mC.products.count);
        
        for (ManagedProduct *prod in mC.products) {
            Product *newProd = [[Product alloc] initWithProductName:prod.productName andProductURL:prod.productURL andProductImage: prod.imageString];
            
            [newComp.products addObject:newProd];
            [newProd release];
            
        }
        
        [self.companyList addObject:newComp];
        [newComp release];
//        [self.managedCompanyList release];
        
    }
    
    
}


-(void)fetchStockData {
    self.stockArray = [[NSMutableArray alloc] init];
    for (Company *tempCompany in self.companyList) {
        [self.stockArray addObject:tempCompany.ticker];
    }
    
    NSString *tickerData = [self.stockArray componentsJoinedByString:@"+"];
//    NSLog(@"TICKER DATA: %@",tickerData);

    NSString *urlString = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=a", tickerData];
        NSURL *url = [NSURL URLWithString:urlString];
    
//    NSLog(@"URL: %@",url);
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc]initWithURL:url] autorelease];
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *resultsString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSArray *resultsArray = [resultsString componentsSeparatedByString:@"\n"];
        
//        NSLog(@"RESULTS: %@", resultsArray);
        
        int i = 0;
        
        for (Company *company in self.companyList) {
            company.stockPrice = resultsArray[i];
            i++;
        }
//        [request release];
//        [self.stockArray release];
//        [session release];
//        [resultsString release];
//        [resultsArray release];
        
         dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate didUpdateCompanyStockPrices];
         });
        
    }];
    
    [task resume];
}



-(void) addCompany: (Company*) company{
    
    [self.companyList addObject:company];
    
    ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.context];
    [mC setCompanyName:company.companyName];
    [mC setCompanyTicker:company.ticker];
    [mC setCompanyLogoString:company.companyImageString];
    
    [self.managedCompanyList addObject:mC];
    
//    [self.context save:nil];
    [mC release];
    
}


-(void)deleteCompany: (Company*)company{
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    // find index from companyList
    int index = (int)[self.companyList indexOfObject:company];
    ManagedCompany *mC = [self.managedCompanyList objectAtIndex:index];
    
    
    [self.managedCompanyList removeObjectAtIndex:index];
    [context deleteObject:mC];
    [self.companyList removeObjectAtIndex:index];
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if(!successful){
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }else{
        NSLog(@"Data Saved");
    }

    
}

-(void)editCompany: (Company*) company{
    
    
    int index = (int)[self.companyList indexOfObject:company];
    ManagedCompany *mC = [self.managedCompanyList objectAtIndex:index];
    [mC setCompanyName:company.companyName];
    [mC setCompanyTicker:company.ticker];
    [mC setCompanyLogoString:company.companyImageString];
    
//    [self.context save:nil];
    
}

-(void)addProduct: (Product*) product andCompany:(Company*) company {
    
    int index = (int)[self.companyList indexOfObject:company];
    ManagedCompany *mC = [self.managedCompanyList objectAtIndex:index];
    
    ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.context];
    
    [mP setProductName:product.productName];
    [mP setProductURL:product.productURL];
    [mP setImageString:product.productImageString];
    
    [mC.products setByAddingObject:mP];
    mP.company = mC;
    
//    [self.context save:nil];
    
    
}

-(void)editProduct: (Product*) product andCompany:(Company*) company {
    
    
    int index = (int)[self.companyList indexOfObject:company];
    int prodIndex = (int)[company.products indexOfObject:product];
    ManagedCompany *mC = [self.managedCompanyList objectAtIndex:index];
    
    ManagedProduct *mP= [[mC.products allObjects] objectAtIndex:prodIndex];
    
    [mP setProductName:product.productName];
    [mP setImageString:product.productImageString];
    [mP setProductURL:product.productURL];
    
    mP.company = mC;
    
    
}



-(void)dealloc {
    [super dealloc];
    [_managedCompanyList release];
    [_stockArray release];
    [_context release];
    [_companyList release];
    [_managedCompanyList release];
    
    
    
}







@end
