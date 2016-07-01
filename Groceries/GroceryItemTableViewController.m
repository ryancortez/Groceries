
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

- (void)viewDidLoad {
    self.navigationItem.title = _groceryCategory.title;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void) saveGroceryItems: (NSArray *) groceryItems inGroceryCategory: (GroceryCategory *) groceryCategory {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:groceryCategory.groceryItems];
    _groceryCategories[_index] = groceryCategory;
    [self saveGroceryCategoriesToUserDefault];
    [_groceryCategory setTitle:groceryCategory.title andGroceryItems:mutableArray];
    
}

- (void) saveGroceryCategories: (NSMutableArray *) groceryCategories {
    _groceryCategories = groceryCategories;
    [self saveGroceryCategoriesToUserDefault];
    [self.tableView reloadData];
}

- (void) saveGroceryCategoriesToUserDefault {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *groceryCategories = [[NSMutableArray alloc]initWithArray:_groceryCategories];
    NSData *groceryCategoryData = [NSKeyedArchiver archivedDataWithRootObject:groceryCategories];
    [userDefaults setObject:groceryCategoryData forKey:@"groceryCategories"];
    [userDefaults synchronize];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *groceryItemCell = [tableView dequeueReusableCellWithIdentifier:@"GroceryItemCell"];
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    GroceryItem *groceryItem = groceryCategory.groceryItems[indexPath.row];
    groceryItemCell.textLabel.text = groceryItem.title;
    return groceryItemCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    return groceryCategory.groceryItems.count ;
}

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
