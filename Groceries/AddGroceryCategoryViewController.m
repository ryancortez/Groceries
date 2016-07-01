//
//  AddGroceryCategoryViewController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "AddGroceryCategoryViewController.h"

@implementation AddGroceryCategoryViewController

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

// Assign the numbe of rows in each section of the TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 0;
    }
}

#pragma mark - TextField Delegate

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

    NSString *title = [self categoryTitleFromTextFieldTableViewCellContent];
    NSMutableArray *groceryItems = [self groceryItemsFromTextFieldTableViewCellContent];
    GroceryCategory *category = [[GroceryCategory alloc]initWithTitle:title andGroceryItems:groceryItems];
    [self.delegate saveGroceryItems:groceryItems inGroceryCategory: category];
    [self dismissViewControllerAnimated:YES completion:^{  }];
}

#pragma mark Save Content - Helper Methods

// Get hard coded paths for all the grocery items
- (NSArray *) indexPathsForAllCellsInTheTableView {
    NSIndexPath *groceryItem1TitleIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *groceryItem2TitleIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *groceryItem3TitleIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    NSArray *indexPaths = [[NSArray alloc]initWithObjects: groceryItem1TitleIndexPath, groceryItem2TitleIndexPath, groceryItem3TitleIndexPath, nil];
    return indexPaths;
}

// Get the GroceryCategory title from the text
- (NSString *) categoryTitleFromTextFieldTableViewCellContent {
    NSIndexPath *categoryTitleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:categoryTitleIndexPath];
    return textFieldTableViewCell.textField.text;
}

// Get the content add by the user in the grocery item text fields
- (NSMutableArray *) groceryItemsFromTextFieldTableViewCellContent {
    NSMutableArray *groceryItems = [[NSMutableArray alloc]init];
    for (NSIndexPath *indexPath in [self indexPathsForAllCellsInTheTableView]) {
        TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:indexPath];
        GroceryItem *groceryItem = [[GroceryItem alloc]initWithTitle:textFieldTableViewCell.textField.text];
        if(![groceryItem.title isEqualToString:@""]) {
            [groceryItems addObject:groceryItem];
        }
    }
    return groceryItems;
}

@end
