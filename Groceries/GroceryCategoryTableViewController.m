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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"isFirstLaunch"]) {
        // Create a default collection of grocery lists
        [self initModel];
        [self saveGroceryCategoriesToUserDefault];
        [userDefaults setBool:YES forKey:@"isFirstLaunch"];
    }   
    
    NSData *groceryCategoriesData = [userDefaults objectForKey:@"groceryCategories"];
    _groceryCategories = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:groceryCategoriesData];
    
    [self.tableView reloadData];
}


#pragma mark - Helper Methods

// Create a default collection of grocery lists
- (void) initModel {
    
    GroceryItem *carrots = [[GroceryItem alloc]initWithTitle:@"Carrots"];
    GroceryItem *onions = [[GroceryItem alloc]initWithTitle:@"Onions"];
    GroceryItem *eggs = [[GroceryItem alloc]initWithTitle:@"Eggs"];
    GroceryItem *bacon = [[GroceryItem alloc]initWithTitle:@"Bacon"];
    
    NSMutableArray *dinnerArray = [[NSMutableArray alloc]initWithObjects:carrots, onions, nil];
    NSMutableArray *breakfastArray = [[NSMutableArray alloc]initWithObjects:eggs, bacon, nil];
    
    GroceryCategory *dinner = [[GroceryCategory alloc]initWithTitle:@"Dinner" andGroceryItems:dinnerArray];
    GroceryCategory *breakfast = [[GroceryCategory alloc]initWithTitle:@"Breakfast" andGroceryItems:breakfastArray];
    
    NSMutableArray *categoriesArray = [[NSMutableArray alloc]initWithObjects:dinner, breakfast, nil];
    _groceryCategories = categoriesArray;
}

- (void) saveGroceryItems: (NSArray *) groceryItems inGroceryCategory: (GroceryCategory *) groceryCategory {
    NSMutableArray *groceryItemsMutableArray = [[NSMutableArray alloc]initWithArray:groceryItems];
    [_groceryCategories addObject:[groceryCategory initWithTitle:groceryCategory.title andGroceryItems:groceryItemsMutableArray]];
    
    [self saveGroceryCategoriesToUserDefault];
}

- (void) saveGroceryCategoriesToUserDefault {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *groceryCategories = [[NSMutableArray alloc]initWithArray:_groceryCategories];
    NSData *groceryCategoryData = [NSKeyedArchiver archivedDataWithRootObject:groceryCategories];
    [userDefaults setObject:groceryCategoryData forKey:@"groceryCategories"];
    [userDefaults synchronize];
}


#pragma mark - TableView Data Source

//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *groceryCategoryCell = [tableView dequeueReusableCellWithIdentifier:@"GroceryCategoryCell"];
    GroceryCategory *groceryCategory = _groceryCategories[indexPath.row];
    groceryCategoryCell.textLabel.text = groceryCategory.title;
    return groceryCategoryCell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groceryCategories.count;
}


#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - TextField Delegate Methods

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"groceryCategoryTableViewToGroceryItemTableView"]){
        GroceryItemTableViewController *groceryItemTableViewController = (GroceryItemTableViewController *) segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        groceryItemTableViewController.groceryCategory = _groceryCategories[indexPath.row];
        groceryItemTableViewController.index = indexPath.row;
        groceryItemTableViewController.groceryCategories = _groceryCategories;
    }
    
    if ([segue.identifier isEqualToString:@"groceryCategoryTableViewToAddGroceryCategoryTableViewSegue"]) {
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        
        AddGroceryCategoryViewController *addGroceryCategoryViewController = (AddGroceryCategoryViewController *) navigationController.viewControllers.firstObject;
        addGroceryCategoryViewController.delegate = self;

    }
    
}

@end
