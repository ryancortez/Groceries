//
//  GroceryCategoryTableViewController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "GroceryCategoryTableViewController.h"

@implementation GroceryCategoryTableViewController

#pragma View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Groceries";
    [self checkForIntialLaunch];
    [self readFromPersistentStorageAndUpdateView];
}

#pragma mark - Helper Methods


// Fills in the table view with example categories and food on the inital launch
- (void) checkForIntialLaunch {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"isFirstLaunch"]) {
        // Create a default collection of grocery lists
        [self initViewWithDefaultValues];
        [self saveGroceryCategoriesToUserDefault];
        [userDefaults setBool:YES forKey:@"isFirstLaunch"];
    }
}

// Create a default collection of grocery lists
- (void) initViewWithDefaultValues {
    GroceryCategory *dinner = [[GroceryCategory alloc]initWithTitle:@"Dinner" andGroceryItemTitles:[NSArray arrayWithObjects:@"Carrots", @"Onions", nil]];
    GroceryCategory *breakfast = [[GroceryCategory alloc]initWithTitle:@"Breakfast" andGroceryItemTitles:[NSArray arrayWithObjects:@"Eggs", @"Bacon", nil]];
    NSMutableArray *categoriesArray = [[NSMutableArray alloc]initWithObjects:dinner, breakfast, nil];
    _groceryCategories = categoriesArray;
}


// Pull data from persistent storage
- (void) readFromPersistentStorageAndUpdateView {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *groceryCategoriesData = [userDefaults objectForKey:@"groceryCategories"];
    _groceryCategories = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:groceryCategoriesData];
    [self.tableView reloadData];
}

// Save new items made from the AddGroceryItemTableViewController
- (void) saveGroceryItems: (NSArray *) groceryItems inGroceryCategory: (GroceryCategory *) groceryCategory {
    NSMutableArray *groceryItemsMutableArray = [[NSMutableArray alloc]initWithArray:groceryItems];
    [_groceryCategories addObject:[groceryCategory initWithTitle:groceryCategory.title andGroceryItems:groceryItemsMutableArray]];
    [self saveGroceryCategoriesToUserDefault];
}

// Save the current state of the grocery categories to persisent storage
- (void) saveGroceryCategoriesToUserDefault {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *groceryCategories = [[NSMutableArray alloc]initWithArray:_groceryCategories];
    NSData *groceryCategoryData = [NSKeyedArchiver archivedDataWithRootObject:groceryCategories];
    [userDefaults setObject:groceryCategoryData forKey:@"groceryCategories"];
    [userDefaults synchronize];
}


#pragma mark - TableView Data Source

// Create each cell for the table view
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *groceryCategoryCell = [tableView dequeueReusableCellWithIdentifier:@"GroceryCategoryCell"];
    GroceryCategory *groceryCategory = _groceryCategories[indexPath.row];
    groceryCategoryCell.textLabel.text = groceryCategory.title;
    return groceryCategoryCell;
}

// Return the number of rows that should be in the table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groceryCategories.count;
}

#pragma mark - Segues

// Pass information to the next ViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"groceryCategoryTableViewToGroceryItemTableView"]){
        [self transferModelFromCurrentViewControllerToGroceryItemViewController:(GroceryItemTableViewController *) segue.destinationViewController];
    }
    if ([segue.identifier isEqualToString:@"groceryCategoryTableViewToAddGroceryCategoryTableViewSegue"]) {
        [self transferModelFromCurrentViewControllerToNavigationViewController: (UINavigationController *)segue.destinationViewController];
    }
}

// Passing information to GroceryItemViewController
- (void) transferModelFromCurrentViewControllerToGroceryItemViewController: (GroceryItemTableViewController *) groceryItemTableViewController {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    groceryItemTableViewController.index = indexPath.row;
    groceryItemTableViewController.groceryCategories = _groceryCategories;
}

// Passing information to the AddGroceryCategoryViewController
- (void) transferModelFromCurrentViewControllerToNavigationViewController: (UINavigationController *) navigationController {
    AddGroceryCategoryViewController *addGroceryCategoryViewController = (AddGroceryCategoryViewController *) navigationController.viewControllers.firstObject;
    addGroceryCategoryViewController.delegate = self;

}

@end
