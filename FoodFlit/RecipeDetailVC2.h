//
//  RecipeDetailVC2.h
//  FoodFlit
//
//  Created by Dominique Raymond on 12/3/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailVC2 : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Recipe *recipe;
@property (nonatomic, strong)IBOutlet UIImageView *pic;
@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IBOutlet UILabel *name;
@property (nonatomic, strong)IBOutlet UISegmentedControl *segment;

-(IBAction)favorite:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)cooked:(id)sender;
-(IBAction)valueChanged:(UISegmentedControl *)segment;
@end