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
    [self initModel];
}


#pragma mark - Helper Methods

- (void) initModel {
    GroceryCategory *dinner = [[GroceryCategory alloc]initWithTitle:@"Dinner" andGroceryItems:(NSMutableArray * ) @[@"Carrots", @"Onions"]];
    GroceryCategory *breakfast = [[GroceryCategory alloc]initWithTitle:@"Breakfast" andGroceryItems:(NSMutableArray * ) @[@"Eggs", @"Bacon"]];
    _groceryCategories = (NSMutableArray *) @[dinner, breakfast];
}


#pragma mark - TableView Data Source

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


#pragma mark - Actions

- (IBAction)addButtonPressed:(id)sender {

}


#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"groceryCategoryTableViewToGroceryItemTableView"]){
        GroceryItemTableViewController *groceryItemTableViewController = (GroceryItemTableViewController *) segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        groceryItemTableViewController.groceryCategory = _groceryCategories[indexPath.row];
    }
    
//    if ([segue.identifier isEqualToString:@"grocertyCategoryTableViewToAddGroceryCategoryTableViewSegue"]) {
//        
//    }
}

@end
