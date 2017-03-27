//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"

@interface CompanyVC ()

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    self.companyList = [[NSMutableArray alloc] initWithArray:@[@"Apple mobile devices",@"Samsung mobile devices", @"Google mobile devices", @"Microsoft mobile devices"]];
    
    self.appleProducts = [[NSMutableArray alloc]initWithArray:@[@"iPad",@"iPod Touch",@"iPhone"]];
    
    self.samsungProducts = [[NSMutableArray alloc]initWithArray:@[@"Galaxy S7",@"Galaxy Note",@"Galaxy Tab"]];
    
    self.googleProducts = [[NSMutableArray alloc]initWithArray:@[@"Pixel",@"Nexus",@"Daydream Device"]];
    
    self.microsoftProducts = [[NSMutableArray alloc]initWithArray:@[@"Lumia 950",@"XPS Laptop",@"Surface Pro"]];
    
    self.title = @"Mobile device makers";
    // Do any additional setup after loading the view from its nib.
}


- (void)toggleEditMode {
    
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    } else {
        [self.tableView setEditing:YES animated:NO];
        self.navigationItem.rightBarButtonItem.title = @"Done";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *currentCompany = [self.companyList objectAtIndex:indexPath.row];
    
    if([currentCompany isEqualToString:@"Apple mobile devices"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"apple.jpg"]];
    }
    else if ([currentCompany isEqualToString:@"Samsung mobile devices"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"samsung.png"]];
    }
    
    else if ([currentCompany isEqualToString:@"Google mobile devices"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"google.png"]];
    }
    
    else if ([currentCompany isEqualToString:@"Microsoft mobile devices"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"microsoft.png"]];
    }
    
    
    // Configure the cell...
    
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        [self.companyList removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    }
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */


 // Override to support rearranging the table view.
// - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
// {
//     //Work in here to keep the array in sync with the tableview
//    
//     NSString *currentCompany = [self.companyList objectAtIndex:fromIndexPath.row];
//     [self.companyList removeObject:currentCompany];
//     [self.companyList insertObject:currentCompany atIndex:toIndexPath.row];
// }

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    NSString *companyToMove = [self.companyList objectAtIndex:fromIndexPath.row];
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:companyToMove atIndex:toIndexPath.row];
    [self.tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    [self.tableView endUpdates];
    
}



 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.productViewController = [[ProductVC alloc]init];
    
/*
 
 ||||||||||||||||||||||| OLD CODE HERE ||||||||||||||||||||||||||||||||||||||
 
    if (indexPath.row == 0){ //change this to check the string
        self.productViewController.title = @"Apple mobile devices";
    } else if(indexPath.row == 1){
        self.productViewController.title = @"Samsung mobile devices";
    }else if(indexPath.row == 2){
        self.productViewController.title = @"Google mobile devices";
    }else{
        self.productViewController.title = @"Microsoft mobile devices";
 ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    }
 
 */
    
     NSString *currentCompany = [self.companyList objectAtIndex:indexPath.row];
    
    if([currentCompany isEqualToString:@"Apple mobile devices"]){
        self.productViewController.products = self.appleProducts;
    }
    else if ([currentCompany isEqualToString:@"Samsung mobile devices"]){
        self.productViewController.products = self.samsungProducts;
    }
    
    else if ([currentCompany isEqualToString:@"Google mobile devices"]){
        self.productViewController.products = self.googleProducts;
    }
    
    else if ([currentCompany isEqualToString:@"Microsoft mobile devices"]){
        self.productViewController.products = self.microsoftProducts;
    }

    
    

    
    [self.navigationController
     pushViewController:self.productViewController
     animated:YES];
    
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
    [_tableView release];
    [super dealloc];
}
@end
