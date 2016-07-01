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
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    self.navigationController.title = groceryCategory.title;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *groceryCategoriesData = [userDefaults objectForKey:@"groceryCategories"];
    _groceryCategories = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:groceryCategoriesData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    if (indexPath.section == 0) {
        TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
        cell.textField.text = groceryCategory.title;
        return cell;
    } else if(indexPath.section == 1) {
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return groceryCategory.groceryItems.count + 1;
    } else {
        return 0;
    }
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
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    [self saveTitleFromTextFieldIntoGroceryCategory:groceryCategory];
    [self saveContentFromTextFieldsIntoGroceryCategory:groceryCategory];
    _groceryCategories[self.index] = groceryCategory;
    [self.delegate saveGroceryCategories:_groceryCategories];
    [self dismissViewControllerAnimated:YES completion:^{    }];
}

- (void) saveTitleFromTextFieldIntoGroceryCategory: (GroceryCategory *) groceryCategory {
    NSIndexPath *groceryCategoryTitleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];;
    TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:groceryCategoryTitleIndexPath];
    if (![textFieldTableViewCell.textField.text isEqual: @""]) {
        groceryCategory.title = textFieldTableViewCell.textField.text;
    }
}

// Keeps adding to groceryItems
- (void) saveContentFromTextFieldsIntoGroceryCategory:(GroceryCategory *) groceryCategory {
    
    NSInteger initalTableViewCellCount = groceryCategory.groceryItems.count + 1;
    for (int index = 0; index < initalTableViewCellCount; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
        TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (![textFieldTableViewCell.textField.text isEqual: @""]) {
            GroceryItem *groceryItem = [[GroceryItem alloc]initWithTitle:textFieldTableViewCell.textField.text];
            groceryCategory.groceryItems[index] = groceryItem;
        }
    }

}

@end
