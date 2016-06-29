//
//  GroceryItemTableViewController.h
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGroceryItemController.h"
#import "GroceryCategory.h"

@interface GroceryItemTableViewController : UITableViewController

@property GroceryCategory *groceryCategory;
@property NSMutableArray *groceryItems;

@end
