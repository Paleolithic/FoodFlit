//
//  TimelineVC.h
//  FoodFlit
//
//  Created by Dominique Raymond on 12/16/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "RecipeDetailVC.h"
#import "CustomCell.h"

@interface TimelineVC : UITableViewController{
    BOOL favoritesSelected;
}

@property (strong, nonatomic) NSMutableArray *recipes;


@end
