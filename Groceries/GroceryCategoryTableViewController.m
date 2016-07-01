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

-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Groceries";
    
    if (_groceryCategories == nil) {
        // Create a default collection of grocery lists
        [self initModel];
        [self saveGroceryCategoriesToUserDefault];
        
    } else {
        NSMutableArray *temporaryGroceryCategories = [[NSMutableArray alloc] init];
        
        for (GroceryCategory *groceryCategory in _groceryCategories) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSData *groceryCategoryData = [userDefaults valueForKey:groceryCategory.title];
            GroceryCategory *groceryCategory = (GroceryCategory *) [NSKeyedUnarchiver unarchiveObjectWithData:groceryCategoryData];
            [temporaryGroceryCategories addObject:groceryCategory];
        }
        
        _groceryCategories = temporaryGroceryCategories;
    }
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
    
}

- (void) saveGroceryCategoriesToUserDefault {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    for (GroceryCategory *groceryCategory in _groceryCategories) {
        NSData *groceryCategoryData = [NSKeyedArchiver archivedDataWithRootObject:groceryCategory];
        [userDefaults setObject:groceryCategoryData forKey:groceryCategory.title];
        [userDefaults synchronize];
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"groceryCategoryTableViewToGroceryItemTableView"]){
        GroceryItemTableViewController *groceryItemTableViewController = (GroceryItemTableViewController *) segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        groceryItemTableViewController.groceryCategory = _groceryCategories[indexPath.row];
        NSLog(@"");
    }
    
    if ([segue.identifier isEqualToString:@"groceryCategoryTableViewToAddGroceryCategoryTableViewSegue"]) {
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        
        AddGroceryCategoryViewController *addGroceryCategoryViewController = (AddGroceryCategoryViewController *) navigationController.viewControllers.firstObject;
        addGroceryCategoryViewController.delegate = self;
        
        NSLog(@"");
    }
    
}

@end
