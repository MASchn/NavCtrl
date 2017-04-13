//
//  addScreenVC.m
//  NavCtrl
//
//  Created by Maxwell Schneider on 3/29/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "addScreenVC.h"


@interface addScreenVC ()
@property (retain, nonatomic) IBOutlet UITextField *companyTextField;
@property (retain, nonatomic) IBOutlet UITextField *urlTextField;
@property (retain, nonatomic) IBOutlet UILabel *textName;
@property (retain, nonatomic) IBOutlet UITextField *websiteTextField;
@property (retain, nonatomic) IBOutlet UILabel *websiteLabel;

@end

@implementation addScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.dao = [DAO sharedManager];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if(self.dao.companyAdd == YES){
        self.websiteLabel.hidden = NO;
        self.websiteTextField.hidden = NO;
        self.textName.text = @"Company Name:";
        self.websiteLabel.text = @"Enter Stock Ticker Name:";
    }
    
    
    
    
    else if(self.dao.productAdd == YES){
        self.textName.text = @"Product Name:";
    }
    
    
    
    
    
    else if (self.dao.companyEdit == YES){
        self.websiteLabel.hidden = NO;
        self.websiteTextField.hidden = NO;
        self.websiteLabel.text = @"Enter Stock Ticker Name:";
        self.textName.text = @"Company Name:";
        
    }
    
    
    
    
    else if(self.dao.productEdit == YES){
        self.textName.text = @"Product Name:";
        self.websiteLabel.hidden = NO;
        self.websiteTextField.hidden = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButton:(id)sender {
    
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    // Here pass new size you need
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)submitButton:(id)sender {
    
    
    
    NSURL *url = [NSURL URLWithString:self.urlTextField.text];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[[UIImage alloc] initWithData:data] autorelease];
        [img drawInRect:CGRectMake(0, 0, 32, 32)];
        
        
        
        
        if (self.dao.companyAdd == YES){
            Company *newCompany = [[Company alloc]initWithCompanyName:self.companyTextField.text downloadLogo:img ticker: self.websiteLabel.text stockPrice: @"Loading..."];
        
        [self.dao.companyList addObject:newCompany];
        }
        
        else if (self.dao.productAdd == YES){
            Product *newProduct = [[Product alloc]initWithProductName:self.companyTextField.text downloadLogo:img];
            [self.companyToEdit.products addObject:newProduct];
        }
        
        else if (self.dao.companyEdit == YES){
            if (self.companyTextField.text != nil){
            self.companyToEdit.companyName = self.companyTextField.text;
            }
            if(img != nil){
            self.companyToEdit.companyLogo = img;
            }
        }
        else if (self.dao.productEdit == YES){
            
             if (self.companyTextField.text != nil){
            self.productToEdit.productName = self.companyTextField.text;
             }
            
                 if(img != nil){
                     self.productToEdit.productImage = img;
             }
            
            if(self.websiteTextField != nil){
                self.productToEdit.productURL = self.websiteTextField.text;
            }
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dao.companyAdd = NO;
            self.dao.productAdd = NO;
            self.dao.companyEdit = NO;
            self.dao.productEdit = NO;
            self.websiteLabel.hidden = NO;
            self.websiteTextField.hidden = NO;
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height+200;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_companyTextField release];
    [_urlTextField release];
    [_textName release];
    [_websiteTextField release];
    [_websiteLabel release];
    [_websiteTextField release];
    [super dealloc];
}
@end
