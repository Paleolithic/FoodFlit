//
//  FirstViewController.m
//  FoodFlit
//
//  Created by Student on 11/18/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "RandomizerVC.h"

@interface RandomizerVC (){
    NSArray *_pickerData;
}

@end

@implementation RandomizerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Init picker data
    _pickerData = @[@[@"Breakfast", @"Lunch", @"Dinner", @"Dessert"],
                    @[@"American", @"Italian", @"Spanish", @"Mediterranean", @"Mexican", @"Indian"],
                    @[@"Very Easy", @"Easy", @"Medium", @"Hard", @"Very Hard"]];
    
    self.randomPicker.dataSource = self;
    self.randomPicker.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerData[component] count];
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        [tView setFont:[UIFont boldSystemFontOfSize:14]];
        tView.adjustsFontSizeToFitWidth = YES;
    }
    // Fill the label text here
    tView.text = _pickerData[component][row];
    return tView;
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    switch(component){
        case 0:
            self.mealType = _pickerData[component][row];
            break;
        case 1:
            self.dishType = _pickerData[component][row];
            break;
        case 2:
            self.difficulty = _pickerData[component][row];
            break;
    }
    
}

- (IBAction)randomizeRecipe:(id)sender {
    NSLog(@"Randomize!\n");
    NSLog(@"mealType = %@\n", self.mealType);
    NSLog(@"mealType = %@\n", self.dishType);
    NSLog(@"mealType = %@\n", self.difficulty);
}
@end
