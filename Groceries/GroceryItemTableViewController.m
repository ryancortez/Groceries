//
//  GroceryItemTableViewController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "GroceryItemTableViewController.h"
#import "AddGroceryItemController.h"

@implementation GroceryItemTableViewController

-(void)viewDidLoad {
    self.navigationItem.title = _groceryCategory.title;
}

- (void) saveGroceryItem {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *groceryItemCell = [tableView dequeueReusableCellWithIdentifier:@"GroceryItemCell"];
    groceryItemCell.textLabel.text = _groceryCategory.groceryItems[indexPath.row];
    return groceryItemCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _groceryCategory.groceryItems.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"groceryItemTableViewToAddGroceryItemTableViewSegue"]) {
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        AddGroceryItemController *addGroceryItemController = navigationController.viewControllers.firstObject;
        addGroceryItemController.groceryCategory = _groceryCategory;
    }
}

@end
