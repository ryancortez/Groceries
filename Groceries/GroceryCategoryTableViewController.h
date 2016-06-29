//
//  GroceryCategoryTableViewController.h
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGroceryCategoryViewController.h"
#import "GroceryCategory.h"
#import "GroceryItem.h"
#import "GroceryItemTableViewController.h"

// A view that displays a collection of grocery lists broken up by category
@interface GroceryCategoryTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, AddGroceryCategoryDelegate>

@property NSMutableArray *groceryCategories;

@end
