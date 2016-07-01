//
//  GroceryItemTableViewController.h
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGroceryItemViewController.h"
#import "GroceryCategory.h"
#import "GroceryItem.h"

@interface GroceryItemTableViewController : UITableViewController <AddGroceryItemDelegate>

@property GroceryCategory *groceryCategory;
@property NSInteger index;
@property NSMutableArray *groceryCategories;

@end
