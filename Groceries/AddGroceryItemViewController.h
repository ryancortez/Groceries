//
//  AddGroceryItemViewController.h
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroceryCategory.h"
#import "GroceryItem.h"
#import "TextFieldTableViewCell.h"

@protocol AddGroceryItemDelegate <NSObject>

- (void) saveGroceryItems: (NSArray *) groceryItems inGroceryCategory: (GroceryCategory *) groceryCategory;
- (void) saveGroceryCategories: (NSMutableArray *) groceryCategories;

@end

@interface AddGroceryItemViewController : UITableViewController <UITextFieldDelegate>

@property id<AddGroceryItemDelegate> delegate;
@property NSInteger index;
@property NSMutableArray *groceryCategories;

@end
