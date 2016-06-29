//
//  AddGroceryCategoryViewController.h
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroceryCategory.h"
#import "TextFieldTableViewCell.h"

@interface AddGroceryCategoryViewController : UITableViewController <UITextFieldDelegate>

@property GroceryCategory *groceryCategory;

@end
