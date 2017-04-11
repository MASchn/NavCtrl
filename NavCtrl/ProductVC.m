//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"
#import "ProductWebVC.h"
#import "Product.h"

@interface ProductVC ()

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonProduct)];
    //self.navigationItem.rightBarButtonItem = editButton;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, addButton, nil];
    // Do any additional setup after loading the view from its nib.
        self.dao = [DAO sharedManager];
     self.tableView.allowsSelectionDuringEditing = YES;
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
-(void)addButtonProduct{
    self.dao.productAdd = YES;
    addScreenVC *addScreen = [[addScreenVC alloc]init];
    addScreen.companyToEdit = self.selectedCompany;
    [self.navigationController pushViewController:addScreen animated:YES];
    NSLog(@"Gangsta bidness");
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dao.productAdd = NO;
    self.dao.companyAdd = NO;
    self.dao.productEdit = NO;
    self.dao.companyEdit = NO;
    
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.selectedCompany.products count];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        [self.selectedCompany.products removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Product *currentProduct = [self.selectedCompany.products objectAtIndex:indexPath.row];

    
    


    // Configure the cell...
//    cell.showsReorderControl = YES;
    cell.textLabel.text = currentProduct.productName;
    cell.imageView.image = currentProduct.productImage;
    return cell;
}



 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }


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
// }



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
     
     if (self.tableView.isEditing) {
         
         //push to an edit vc
         self.dao.productEdit = YES;
         addScreenVC *addScreen = [[addScreenVC alloc]init];
         Product *currentProduct = [self.selectedCompany.products objectAtIndex:indexPath.row];
         addScreen.productToEdit = currentProduct;
         [self.navigationController pushViewController: addScreen animated:YES];
         
         return;
     }

     
 // Navigation logic may go here, for example:
 // Create the next view controller.
     ProductWebVC *detailViewController = [[ProductWebVC alloc] init]; // Pass the selected object to the new view controller.
     
     Product *currentProduct = [self.selectedCompany.products objectAtIndex:indexPath.row];
     
     
     detailViewController.url = currentProduct.productURL;
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    Company *companyToMove = [self.selectedCompany.products objectAtIndex:fromIndexPath.row];
    [self.selectedCompany.products removeObjectAtIndex:fromIndexPath.row];
    [self.selectedCompany.products insertObject:companyToMove atIndex:toIndexPath.row];
    //[self.selectedCompany.products moveRowAtIndexPath:fromIndexPath.row toIndexPath:toIndexPath.row];
    //[self.selectedCompany.products endUpdates];
    
}





- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
