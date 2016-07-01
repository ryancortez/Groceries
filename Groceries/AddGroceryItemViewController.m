//
//  AddGroceryItemController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "AddGroceryItemViewController.h"

@implementation AddGroceryItemViewController


-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.title = _groceryCategory.title;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *groceryCategoriesData = [userDefaults objectForKey:@"groceryCategories"];
    _groceryCategories = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:groceryCategoriesData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        GroceryCategory *groceryCategory = _groceryCategories[self.index];
        
        if (indexPath.row < groceryCategory.groceryItems.count) {
            TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
            cell.textField.placeholder = @"Add Grocery Item";
            GroceryItem *groceryItem = groceryCategory.groceryItems[indexPath.row];
            cell.textField.text = groceryItem.title;
            return cell;
        } else {
            TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
            cell.textField.placeholder = @"Add Grocery Item";
            return cell;
        }
    } else {
        TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groceryCategory.groceryItems.count + 1;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self saveButtonPressed:self];
    return YES;
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{    }];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_groceryCategory.groceryItems.count inSection:0];
    
    TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (![textFieldTableViewCell.textField.text isEqual: @""]) {
        
        GroceryCategory *groceryCategory = _groceryCategories[self.index];
        GroceryItem *groceryItem = [[GroceryItem alloc]initWithTitle:textFieldTableViewCell.textField.text];
        [groceryCategory.groceryItems addObject:groceryItem];
    }
    
    [self.delegate saveGroceryCategories:_groceryCategories];
    [self dismissViewControllerAnimated:YES completion:^{    }];
}

@end
