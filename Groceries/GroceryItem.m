//
//  GroceryItem.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "GroceryItem.h"

@implementation GroceryItem

- (instancetype) initWithTitle: (NSString *) title {
    self = [super init];
    self.title = title;
    return self;
}

@end
