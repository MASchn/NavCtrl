//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"
#import "ProductWebVC.h"


@interface ProductVC ()

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        self.products = [[NSMutableArray alloc]initWithArray:@[@"iPad", @"iPod Touch",@"iPhone"]] ;
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]) {
        self.products = [[NSMutableArray alloc]initWithArray: @[@"Galaxy S7", @"Galaxy Note", @"Galaxy Tab"]];
    }
    else if ([self.title isEqualToString:@"Google mobile devices"]){
        self.products = [[NSMutableArray alloc]initWithArray: @[@"Pixel", @"Nexus", @"Daydream Device"]];
    }
    else if ([self.title isEqualToString:@"Microsoft mobile devices"]){
        self.products = [[NSMutableArray alloc]initWithArray: @[@"Lumia 950", @"XPS Laptop", @"Surface Pro"]];
    }
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.products count];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        [self.products removeObjectAtIndex:indexPath.row];
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
    
    NSString *currentProduct = [self.products objectAtIndex:indexPath.row];

    
        if([currentProduct isEqualToString: @"iPad"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"ipad.png"]];
        }
        if([currentProduct isEqualToString: @"iPod Touch"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"ipod.png"]];
        }
        if([currentProduct isEqualToString: @"iPhone"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"iphone.png"]];
        }

        if([currentProduct isEqualToString: @"Galaxy S7"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"S7.png"]];
        }
        if([currentProduct isEqualToString: @"Galaxy Note"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"note3.jpg"]];
        }
        if([currentProduct isEqualToString: @"Galaxy Tab"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"tab.png"]];
        }
    

       if([currentProduct isEqualToString: @"Pixel"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"pixel.jpeg"]];
        }
       if([currentProduct isEqualToString: @"Nexus"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"nexus.jpg"]];
        }
        if([currentProduct isEqualToString: @"Daydream Device"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"daydream.jpg"]];
    }
    

       if([currentProduct isEqualToString: @"Lumia 950"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"lumia.jpg"]];
        }
        if([currentProduct isEqualToString: @"XPS Laptop"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"xps.png"]];
        }
        if([currentProduct isEqualToString: @"Surface Pro"]){
            [[cell imageView] setImage: [UIImage imageNamed:@"surfacePro.jpg"]];
        }
        


    // Configure the cell...
//    cell.showsReorderControl = YES;
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
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
 // Navigation logic may go here, for example:
 // Create the next view controller.
     ProductWebVC *detailViewController = [[ProductWebVC alloc] init]; // Pass the selected object to the new view controller.
     
     NSString *currentProduct = [self.products objectAtIndex:indexPath.row];
     
     if([currentProduct isEqualToString: @"iPad"]){
         detailViewController.url = @"http://www.apple.com/ipad/";
     }
     else if([currentProduct isEqualToString: @"iPod Touch"]){
         detailViewController.url = @"http://www.apple.com/ipod/";
     }
     else if([currentProduct isEqualToString: @"iPhone"]){
         detailViewController.url = @"http://www.apple.com/iphone/";
     }
     else if([currentProduct isEqualToString: @"Galaxy S7"]){
         detailViewController.url = @"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+s7";
     }
     else if([currentProduct isEqualToString: @"Galaxy Note"]){
         detailViewController.url = @"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+note&rh=i%3Aaps%2Ck%3Agalaxy+note";
     }
     else if([currentProduct isEqualToString: @"Galaxy Tab"]){
         detailViewController.url = @"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=galaxy+tab&rh=i%3Aaps%2Ck%3Agalaxy+tab";
     }
     else if([currentProduct isEqualToString: @"Pixel"]){
         detailViewController.url = @"https://store.google.com/product/pixel_phone";
     }
     else if([currentProduct isEqualToString: @"Nexus"]){
         detailViewController.url = @"https://www.google.com/nexus/";
     }
     else if([currentProduct isEqualToString: @"Daydream Device"]){
         detailViewController.url = @"https://vr.google.com/daydream/";
     }
     else if([currentProduct isEqualToString: @"Lumia 950"]){
         detailViewController.url = @"https://www.microsoft.com/en-us/mobile/phone/lumia950/";
     }
     else if([currentProduct isEqualToString: @"XPS Laptop"]){
         detailViewController.url = @"https://www.amazon.com/Dell-XPS-15-15-6-Inch-i7-6700HQ/dp/B019PB6X78";
     }
     else{
         detailViewController.url = @"https://www.microsoftstore.com/store/msusa/en_US/cat/All-Surface/categoryID.69403400";
     }
     
     
     
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    NSString *companyToMove = [self.products objectAtIndex:fromIndexPath.row];
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:companyToMove atIndex:toIndexPath.row];
    [self.tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    [self.tableView endUpdates];
    
}





- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
