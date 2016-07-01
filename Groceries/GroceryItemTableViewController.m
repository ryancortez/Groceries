
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

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = _groceryCategory.title;
    [self.tableView reloadData];
}

#pragma mark - Saving Content

// Saving content added from the AddItemView Controller
- (void) saveGroceryItems: (NSArray *) groceryItems inGroceryCategory: (GroceryCategory *) groceryCategory {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:groceryCategory.groceryItems];
    _groceryCategories[_index] = groceryCategory;
    [self saveGroceryCategoriesToUserDefault];
    [_groceryCategory setTitle:groceryCategory.title andGroceryItems:mutableArray];
}

// Saving content added from the AddItemView Controller
- (void) saveGroceryCategories: (NSMutableArray *) groceryCategories {
    _groceryCategories = groceryCategories;
    [self saveGroceryCategoriesToUserDefault];
    [self.tableView reloadData];
}

// Make the newly added content persistent
- (void) saveGroceryCategoriesToUserDefault {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *groceryCategories = [[NSMutableArray alloc]initWithArray:_groceryCategories];
    NSData *groceryCategoryData = [NSKeyedArchiver archivedDataWithRootObject:groceryCategories];
    [userDefaults setObject:groceryCategoryData forKey:@"groceryCategories"];
    [userDefaults synchronize];
}

#pragma mark - TableView Data Source

// Fill in the TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *groceryItemCell = [tableView dequeueReusableCellWithIdentifier:@"GroceryItemCell"];
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    GroceryItem *groceryItem = groceryCategory.groceryItems[indexPath.row];
    groceryItemCell.textLabel.text = groceryItem.title;
    return groceryItemCell;
}

// Fill the table with this number of the rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    return groceryCategory.groceryItems.count ;
}

#pragma mark - Segue

// Pass information to other ViewControllers
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"groceryItemTableViewToAddGroceryItemTableViewSegue"]) {
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        AddGroceryItemViewController *addGroceryItemViewController = navigationController.viewControllers.firstObject;
        addGroceryItemViewController.delegate = self;
        addGroceryItemViewController.groceryCategories = _groceryCategories;
        addGroceryItemViewController.index = self.index;
    }
}

@end
