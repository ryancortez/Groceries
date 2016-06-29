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
#import "GroceryItemTableViewController.h"


@interface GroceryCategoryTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *groceryCategories;

@end
