//
//  AddGroceryItemController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "AddGroceryItemViewController.h"

@implementation AddGroceryItemViewController {
    int numberOfCellsAddedByTheUser;
    int numberOfCellsAddedWhenViewLoads;
}


-(void)viewWillAppear:(BOOL)animated {
    numberOfCellsAddedByTheUser = 0;
    numberOfCellsAddedWhenViewLoads = 1;
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
            TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlankTextFieldTableViewCell"];
            cell.textField.placeholder = @"Add Grocery Item";
            [cell.textField addTarget:self
                          action:@selector(textFieldWasTapped:)
                forControlEvents:UIControlEventEditingDidBegin];
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
        return groceryCategory.groceryItems.count + numberOfCellsAddedWhenViewLoads + numberOfCellsAddedByTheUser;
    } else {
        return 0;
    }
}

- (void) insertRowInTable {
    GroceryCategory *groceryCategory = _groceryCategories[self.index];
    numberOfCellsAddedByTheUser++;
    NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:(groceryCategory.groceryItems.count + numberOfCellsAddedByTheUser) inSection:1]];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:indexPaths.firstObject atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void) textFieldWasTapped: (UITextField *) textField {
    [textField removeTarget:self action:@selector(textFieldWasTapped:) forControlEvents:UIControlEventEditingDidBegin];
    [self insertRowInTable];
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
    
    NSInteger tableViewCellCount = groceryCategory.groceryItems.count + numberOfCellsAddedWhenViewLoads + numberOfCellsAddedByTheUser;
    for (int index = 0; index < tableViewCellCount; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
        TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (![textFieldTableViewCell.textField.text isEqual: @""]) {
            GroceryItem *groceryItem = [[GroceryItem alloc]initWithTitle:textFieldTableViewCell.textField.text];
            groceryCategory.groceryItems[index] = groceryItem;
        }
    }

}

@end
