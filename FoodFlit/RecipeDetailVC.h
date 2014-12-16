//
//  RecipeDetailVC2.h
//  FoodFlit
//
//  Created by Dominique Raymond on 12/3/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Recipe *recipe;
@property (nonatomic, strong)IBOutlet UIImageView *pic;
@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IBOutlet UIWebView *webView;
@property (nonatomic, strong)IBOutlet UILabel *name;
@property (nonatomic, strong)IBOutlet UILabel *info;
@property (nonatomic, strong)IBOutlet UISegmentedControl *segment;
@property (nonatomic, strong)IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, strong)IBOutlet UIButton *save;
@property (nonatomic, strong)IBOutlet UIButton *heart;
@property (nonatomic, strong)IBOutlet UIButton *cooked;


-(IBAction)valueChanged:(UISegmentedControl *)segment;
@end