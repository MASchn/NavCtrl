//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//
#import "Product.h"
#import "CompanyVC.h"
#import "Company.h"
//#import "addScreenVC.h"

@interface CompanyVC ()

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, addButton, nil];
//    self.navigationItem.leftBarButtonItem = editButton;
//    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.dao = [DAO sharedManager];
    self.dao.delegate = self;
    self.tableView.allowsSelectionDuringEditing = YES;
    
//    self.companyList = self.dao.companyList;
    
    self.title = @"Mobile device makers";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)redoButton:(id)sender {
    [self.dao.context redo];
    [self.dao fetchCoreData];
    [self.tableView reloadData];
}

- (IBAction)undoButton:(id)sender {
    [self.dao.context undo];
    [self.dao fetchCoreData];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    self.dao.productAdd = NO;
    self.dao.companyAdd = NO;
    self.dao.productEdit = NO;
    self.dao.companyEdit = NO;
    [self.dao fetchStockData];
    [self.tableView reloadData];
}


-(void)didUpdateCompanyStockPrices {
    [self.tableView reloadData];
}

-(void)addButtonPressed{
    self.dao.companyAdd = YES;
    addScreenVC *addScreen = [[addScreenVC alloc]init];
    addScreen.companyToEdit = self.productViewController.selectedCompany;
    [self.navigationController pushViewController:addScreen animated:YES];
//    NSLog(@"Gangsta bidness");
}

- (void)toggleEditMode {
    self.dao.companyEdit = YES;
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
//        self.navigationItem.leftBarButtonItem.tintColor = [UIColor clearColor];
//        self.navigationItem.leftBarButtonItem.enabled = NO;
    } else {
        [self.tableView setEditing:YES animated:NO];
        self.navigationItem.rightBarButtonItem.title = @"Done";
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
        self.navigationItem.leftBarButtonItem.enabled = YES;
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
    return [self.dao.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([self.dao.companyList count]>0) {
        Company *currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
        
        // Configure the cell...
        
        cell.textLabel.text = currentCompany.companyName;
        //if condition
        cell.detailTextLabel.text = currentCompany.stockPrice;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *tempImage = currentCompany.companyLogo;
        
        [tempImage drawInRect:CGRectMake(0, 0, 32, 32)];
        cell.imageView.image = tempImage;
        cell.imageView.clipsToBounds = YES;
        cell.imageView.frame = CGRectMake(0, 0, 40, 40);
    }
    
    
    
//    cell.imageView.image = self.dao.companyList
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
     
//        [self.dao.managedCompanyList removeObjectAtIndex:indexPath.row];
        [self.dao deleteCompany: [self.dao.companyList objectAtIndex:indexPath.row]];

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
    
    Company *companyToMove = [self.dao.companyList objectAtIndex:fromIndexPath.row];
    [self.dao.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.dao.companyList insertObject:companyToMove atIndex:toIndexPath.row];
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
    
    
    if (self.tableView.isEditing) {
        
        //push to an edit vc
        self.dao.companyEdit = YES;
         addScreenVC *addScreen = [[addScreenVC alloc]init];
        addScreen.companyToEdit = [self.dao.companyList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController: addScreen animated:YES];
        
        return;
    }
    
    self.productViewController = [[ProductVC alloc]init];
    
    Company *currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
    
    self.productViewController.selectedCompany = currentCompany;
    
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
    [_companyList release];
    [_productViewController release];
    [_addScreen release];
    [_appleProducts release];
    [_samsungProducts release];
    [_googleProducts release];
    [_microsoftProducts release];
    [super dealloc];
}
@end
