//
//  AddGroceryCategoryViewController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "AddGroceryCategoryViewController.h"


@implementation AddGroceryCategoryViewController

-(void) viewDidLoad {
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 0;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{    }];
    
}
- (IBAction)saveButtonPressed:(id)sender {
    
    NSIndexPath *categoryTitleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *groceryItem1TitleIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *groceryItem2TitleIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *groceryItem3TitleIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    
    TextFieldTableViewCell *categoryTableViewCell = [self.tableView cellForRowAtIndexPath:categoryTitleIndexPath];
    NSString *title = categoryTableViewCell.textField.text;
    
    TextFieldTableViewCell *groceryItem1TableViewCell = [self.tableView cellForRowAtIndexPath:groceryItem1TitleIndexPath];
    TextFieldTableViewCell *groceryItem2TableViewCell = [self.tableView cellForRowAtIndexPath:groceryItem2TitleIndexPath];
    TextFieldTableViewCell *groceryItem3TableViewCell = [self.tableView cellForRowAtIndexPath:groceryItem3TitleIndexPath];
    
    NSString *groceryItem1 = groceryItem1TableViewCell.textField.text;
    NSString *groceryItem2 = groceryItem2TableViewCell.textField.text;
    NSString *groceryItem3 = groceryItem3TableViewCell.textField.text;
    
    NSMutableArray *groceryItems = [NSMutableArray arrayWithObjects:groceryItem1, groceryItem2, groceryItem3, nil];
    
    GroceryCategory *category = [[GroceryCategory alloc]initWithTitle:title andGroceryItems:groceryItems];
    
    [self.delegate saveGroceryItems:groceryItems inGroceryCategory: category];
    [self dismissViewControllerAnimated:YES completion:^{  }];
}

@end
