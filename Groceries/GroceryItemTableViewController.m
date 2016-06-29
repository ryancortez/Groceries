//
//  GroceryItemTableViewController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "GroceryItemTableViewController.h"
#import "AddGroceryItemViewController.h"

@implementation GroceryItemTableViewController

-(void)viewDidLoad {
    self.navigationItem.title = _groceryCategory.title;
}

- (void) saveGroceryItems: (NSArray *) groceryItems inGroceryCategory: (GroceryCategory *) groceryCategory {
    [_groceryCategory setTitle:groceryCategory.title andGroceryItems:(NSMutableArray *) [_groceryCategory.groceryItems arrayByAddingObjectsFromArray:groceryCategory.groceryItems]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *groceryItemCell = [tableView dequeueReusableCellWithIdentifier:@"GroceryItemCell"];
    GroceryItem *groceryItem = _groceryCategory.groceryItems[indexPath.row];
    groceryItemCell.textLabel.text = groceryItem.title;
    return groceryItemCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _groceryCategory.groceryItems.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"groceryItemTableViewToAddGroceryItemTableViewSegue"]) {
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        AddGroceryItemViewController *addGroceryItemViewController = navigationController.viewControllers.firstObject;
        addGroceryItemViewController.groceryCategory = _groceryCategory;
    }
    
    if ([segue.identifier isEqualToString:@"groceryItemTableViewToAddGroceryItemTableViewSegue"]) {
        AddGroceryItemViewController *addGroceryItemViewController = (AddGroceryItemViewController *) segue.destinationViewController;
        addGroceryItemViewController.delegate = self;
    }
}

@end
