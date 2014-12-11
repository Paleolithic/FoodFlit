//
//  FavoritesVC.h
//  FoodFlit
//
//  Created by Student on 12/3/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "RecipeDetailVC.h"
#import "CustomCell.h"

@interface FavoritesVC : UITableViewController{
    BOOL favoritesSelected;
}

@property (strong, nonatomic) NSMutableArray *recipes;

-(IBAction)switchLists:(id)sender;

@end
