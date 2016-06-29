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

-(void)viewDidLoad {
    self.navigationItem.title = @"Groceries";
    
    // Create a default collection of grocery lists
    [self initModel];
    
    
}


#pragma mark - Helper Methods

// Create a default collection of grocery lists
- (void) initModel {
    
    GroceryItem *carrots = [[GroceryItem alloc]initWithTitle:@"Carrots"];
    GroceryItem *onions = [[GroceryItem alloc]initWithTitle:@"Onions"];
    GroceryItem *eggs = [[GroceryItem alloc]initWithTitle:@"Eggs"];
    GroceryItem *bacon = [[GroceryItem alloc]initWithTitle:@"Bacon"];
    
    GroceryCategory *dinner = [[GroceryCategory alloc]initWithTitle:@"Dinner" andGroceryItems:(NSMutableArray * ) @[carrots, onions]];
    GroceryCategory *breakfast = [[GroceryCategory alloc]initWithTitle:@"Breakfast" andGroceryItems:(NSMutableArray * ) @[eggs, bacon]];
    _groceryCategories = (NSMutableArray *) @[dinner, breakfast];
}


- (void) saveGroceryItems: (NSArray *) groceryItems inGroceryCategory: (GroceryCategory *) groceryCategory {
    [_groceryCategories addObject:[groceryCategory initWithTitle:groceryCategory.title andGroceryItems:(NSMutableArray *) groceryItems]];
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
    }
    
    if ([segue.identifier isEqualToString:@"groceryItemTableViewToAddGroceryItemTableViewSegue"]) {
        AddGroceryCategoryViewController *addGroceryCategoryViewController = (AddGroceryCategoryViewController *) segue.destinationViewController;
        addGroceryCategoryViewController.delegate = self;
    }
    
}

@end
