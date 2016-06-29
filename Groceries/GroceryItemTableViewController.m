//
//  GroceryItemTableViewController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "GroceryItemTableViewController.h"

@implementation GroceryItemTableViewController

-(void)viewDidLoad {
    self.navigationItem.title = _groceryCategory.title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *groceryItemCell = [tableView dequeueReusableCellWithIdentifier:@"GroceryItemCell"];
    groceryItemCell.textLabel.text = _groceryCategory.groceryItems[indexPath.row];
    return groceryItemCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _groceryCategory.groceryItems.count;
}


- (IBAction)addButtonPressed:(id)sender {
    AddGroceryItemController *addGroceryItemController = (AddGroceryItemController *) [self.storyboard instantiateViewControllerWithIdentifier: @"AddGroceryItemView"];
    
    [self presentViewController:addGroceryItemController animated:YES completion:^{    }];
}

@end
