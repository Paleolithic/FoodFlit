//
//  RecipeDetailVC.h
//  FoodFlit
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Recipe *recipe;

@end
