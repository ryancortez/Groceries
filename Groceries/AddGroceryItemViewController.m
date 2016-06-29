//
//  AddGroceryItemController.m
//  Groceries
//
//  Created by Ryan Cortez on 6/28/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "AddGroceryItemViewController.h"

@implementation AddGroceryItemViewController

-(void)viewDidLoad {
    self.navigationController.title = _groceryCategory.title;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        
        if (indexPath.row < _groceryCategory.groceryItems.count) {
            TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
            cell.textField.placeholder = @"Add Grocery Item";
            GroceryItem *groceryItem = _groceryCategory.groceryItems[indexPath.row];
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (IBAction)saveButtonPressed:(id)sender {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_groceryCategory.groceryItems.count inSection:0];
    
    TextFieldTableViewCell *textFieldTableViewCell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (![textFieldTableViewCell.textField.text isEqual: @""]) {
        GroceryItem *groceryItem = [[GroceryItem alloc]initWithTitle:textFieldTableViewCell.textField.text];
        [_groceryCategory.groceryItems addObject:groceryItem];
    }
    
    [self.delegate saveGroceryItems:_groceryCategory.groceryItems inGroceryCategory:_groceryCategory];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
