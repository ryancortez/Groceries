//
//  GroceryCategory.h
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroceryItem.h"

@interface GroceryCategory : NSObject

@property NSString *title;
@property (copy) NSMutableArray *groceryItems;

- (instancetype)initWithTitle: (NSString *) title;
- (instancetype)initWithTitle: (NSString *) title andGroceryItems: (NSMutableArray *) groceryItems;
- (void)setTitle: (NSString *) title andGroceryItems: (NSMutableArray *) groceryItems;

@end
