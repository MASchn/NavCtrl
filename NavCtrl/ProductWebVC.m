//
//  ProductWebVC.m
//  NavCtrl
//
//  Created by Maxwell Schneider on 3/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductWebVC.h"
#import <WebKit/WebKit.h>

@interface ProductWebVC ()
//@property NSString *url;
@end

@implementation ProductWebVC

- (void)viewDidLoad {
   
    [super viewDidLoad];
    WKWebViewConfiguration *theConfig = [[WKWebViewConfiguration alloc]init];
    WKWebView *productWebView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:theConfig];
    
    
    //load URL in
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    

    request.URL = [NSURL URLWithString:self.url];
    if([request.URL isEqual:nil]){ request.URL = [NSURL URLWithString:@"https://www.google.com"];
    }
    
    if(productWebView.isLoading){
        
    }
    
    NSURLRequest *productRequest = [NSURLRequest requestWithURL:request.URL];
    
    [productWebView loadRequest:productRequest];
    
    [self.view addSubview:productWebView];
    

    // Do any additional setup after loading the view from its nib.
    
    [request release];
    [theConfig release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
