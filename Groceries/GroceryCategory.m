//
//  GroceryCategory.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "GroceryCategory.h"

@implementation GroceryCategory

- (instancetype)initWithTitle: (NSString *) title {
    self = [super init];
    self.title = title;
    
    return self;
}

- (instancetype)initWithTitle: (NSString *) title andGroceryItems: (NSMutableArray *) groceryItems {
    self = [super init];
    self.title = title;
    self.groceryItems = groceryItems;
    
    return self;
}

- (instancetype)initWithTitle: (NSString *) title andGroceryItemTitles: (NSArray *) titles {
    self = [super init];
    self.title = title;
    self.groceryItems = [self groceryItemsForTitles:[NSMutableArray arrayWithArray:titles]];
    return self;
}

- (NSMutableArray *)groceryItemsForTitles:(NSMutableArray *) titles {
    NSMutableArray *groceryItems = [[NSMutableArray alloc]init];
    for (NSString *title in titles) {
        GroceryItem *groceryItem = [[GroceryItem alloc]initWithTitle:title];
        [groceryItems addObject:groceryItem];
    }
    self.groceryItems = groceryItems;
    return groceryItems;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    self.title = [coder decodeObjectForKey:@"title"];
    self.groceryItems = [coder decodeObjectForKey:@"groceryItems"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.groceryItems forKey:@"groceryItems"];
}

- (void)setTitle: (NSString *) title andGroceryItems: (NSMutableArray *) groceryItems {
    self.title = title;
    self.groceryItems = groceryItems;
}

- (void)addGroceryItem:(GroceryItem *)groceryItem {
    [self.groceryItems addObject:groceryItem];
}

@end
