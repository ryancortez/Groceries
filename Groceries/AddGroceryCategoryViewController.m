//
//  AddGroceryCategoryViewController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "AddGroceryCategoryViewController.h"

@implementation AddGroceryCategoryViewController {
    int numberOfGroceryItemCellsAddedByTheUser;
    int numberOfGroceryItemCellsAddedWhenViewLoads;
}

#pragma mark - ViewController Lifecycle 

-(void)viewWillAppear:(BOOL)animated {
    numberOfGroceryItemCellsAddedByTheUser = 0;
    numberOfGroceryItemCellsAddedWhenViewLoads = 3;
    _groceryCategory = [[GroceryCategory alloc]initWithTitle:@""];
}

#pragma mark - TableView DataSource

// Fill in the TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
        [cell.textField setPlaceholder: @"Add Grocery Category"];
        return cell;
    } else if (indexPath.section == 1) {
        TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
        cell.textField.placeholder = @"Add Grocery Item";
        [cell.textField addTarget:self
                           action:@selector(textFieldWasTapped:)
                 forControlEvents:UIControlEventEditingDidBegin];
        return cell;
    } else {
        TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
        return cell;
    }
}

// Assign the number of the sections in the TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Assign the number of rows in each section of the TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1 + numberOfGroceryItemCellsAddedByTheUser;
    } else {
        return 0;
    }
}

- (void) insertRowInTable {
    numberOfGroceryItemCellsAddedByTheUser++;
    NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:(numberOfGroceryItemCellsAddedByTheUser) inSection:1]];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:indexPaths.firstObject atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - TextField Delegate

- (void) textFieldWasTapped: (UITextField *) textField {
    [textField removeTarget:self action:@selector(textFieldWasTapped:) forControlEvents:UIControlEventEditingDidBegin];
    [self insertRowInTable];
}

// Triggered when the return button is pressed
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self saveButtonPressed:self];
    return YES;
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{    }];
}

#pragma mark Save Content

// Take all text content from the TableView rows and add it to the model
- (IBAction)saveButtonPressed:(id)sender {
    [self saveCategoryTitleFromTextFieldTableViewCellContent];
    [self saveContentFromTextFieldsIntoGroceryCategory];
    [self.delegate saveGroceryItems:_groceryCategory.groceryItems inGroceryCategory: _groceryCategory];
    [self dismissViewControllerAnimated:YES completion:^{  }];
}

#pragma mark Save Content - Helper Methods

// Get the GroceryCategory title from the text
- (void) saveCategoryTitleFromTextFieldTableViewCellContent {
    NSIndexPath *categoryTitleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:categoryTitleIndexPath];
    _groceryCategory.title = textFieldTableViewCell.textField.text;
}

// Get the content add by the user in the grocery item text fields
- (void) saveContentFromTextFieldsIntoGroceryCategory {
    NSInteger tableViewCellCount = numberOfGroceryItemCellsAddedByTheUser + numberOfGroceryItemCellsAddedWhenViewLoads;
    
    for (int index = 0; index < tableViewCellCount; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
        TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (![textFieldTableViewCell.textField.text isEqual: @""]) {
            GroceryItem *groceryItem = [[GroceryItem alloc]initWithTitle:textFieldTableViewCell.textField.text];
            _groceryCategory.groceryItems[index] = groceryItem;
        }
    }
}




@end
