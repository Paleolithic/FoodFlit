//
//  FirstViewController.h
//  FoodFlit
//
//  Created by Student on 11/18/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"


@interface RandomizerVC : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *randomPicker;
@property (nonatomic, strong) IBOutlet UIButton *recipeButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) NSString *mealType;
@property (weak, nonatomic) NSString *dishType;
@property (weak, nonatomic) NSString *difficulty;

@property (strong, nonatomic) Recipe *recipe;
@property (strong, nonatomic) NSString *recipeID;
@property (strong, nonatomic) NSString *recipeName;

- (IBAction)randomizeRecipe:(id)sender;
- (IBAction)loadRecipe:(id)sender;

@end
