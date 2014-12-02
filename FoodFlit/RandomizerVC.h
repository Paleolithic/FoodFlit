//
//  FirstViewController.h
//  FoodFlit
//
//  Created by Student on 11/18/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomizerVC : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *randomPicker;
@property (nonatomic, strong) IBOutlet UIButton *recipeButton;
@property (weak, nonatomic) NSString *mealType;
@property (weak, nonatomic) NSString *dishType;
@property (weak, nonatomic) NSString *difficulty;

- (IBAction)randomizeRecipe:(id)sender;

@end
