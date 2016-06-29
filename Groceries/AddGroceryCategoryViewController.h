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

@protocol AddGroceryCategoryDelegate <NSObject>

- (void) saveGroceryItems: (NSArray *) groceryItems inGroceryCategory: (GroceryCategory *) groceryCategory;

@end

@interface AddGroceryCategoryViewController : UITableViewController <UITextFieldDelegate>

@property GroceryCategory *groceryCategory;
@property id<AddGroceryCategoryDelegate> delegate;

@end
