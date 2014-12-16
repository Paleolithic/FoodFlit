//
//  CustomCell.h
//  FoodFlit
//
//  Created by Dominique Raymond on 12/10/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, strong)IBOutlet UILabel *name;
@property (nonatomic, strong)IBOutlet UILabel *info;
@property (nonatomic, strong)IBOutlet UIImageView *imgView;
@property (nonatomic, strong) NSString *recipeID;
@property (nonatomic, strong)IBOutlet UIButton *save;
@property (nonatomic, strong)IBOutlet UIButton *heart;
@property (nonatomic, strong)IBOutlet UIButton *cooked;

@property (nonatomic, strong)IBOutlet UITextView *textView;
@property (nonatomic, strong)IBOutlet UITextField *textField;
-(IBAction)comment:(id)sender;

-(void)ButtonStates;

-(IBAction)save:(id)sender;
-(IBAction)heart:(id)sender;
-(IBAction)cooked:(id)sender;

@end
