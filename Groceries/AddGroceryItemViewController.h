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

@end

@interface AddGroceryItemViewController : UITableViewController <UITextFieldDelegate>

@property GroceryCategory *groceryCategory;
@property id<AddGroceryItemDelegate> delegate;

@end
