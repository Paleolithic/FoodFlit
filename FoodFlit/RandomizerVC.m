//
//  FirstViewController.m
//  FoodFlit
//
//  Created by Student on 11/18/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "RandomizerVC.h"
#import "RecipeDetailVC.h"
#include <stdlib.h>
#define applicationID @"29b9d634"
#define applicationKey @"117626e0b87c1c939e82a5ed3102f6e8"

@interface RandomizerVC (){
    NSArray *_pickerData;
}

@end

@implementation RandomizerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.recipeButton.hidden=true;
    [self.recipeButton setTitle:@"" forState:UIControlStateNormal];
    
    //Init picker data
    _pickerData = @[@[@"Breakfast and Brunch", @"Lunch and Snacks", @"Main Dishes", @"Desserts"],
                    @[@"American", @"Italian", @"Asian", @"French", @"Chinese", @"Greek", @"German", @"Thai", @"Japanese", @"Spanish", @"Mediterranean", @"Mexican", @"Indian"],
                    @[@"Very Easy", @"Easy", @"Medium", @"Hard", @"Very Hard"]];
    
    self.randomPicker.dataSource = self;
    self.randomPicker.delegate = self;
    self.mealType = @"Breakfast";
    self.dishType = @"American";
    self.difficulty = @"Very Easy";
    
    [self.randomPicker selectRow:2 inComponent:0 animated:YES];
    [self.randomPicker selectRow:2 inComponent:1 animated:YES];
    [self.randomPicker selectRow:2 inComponent:2 animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Picker View setup methods
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

//Yummly API Call
//Sets up variables with API response
- (IBAction)randomizeRecipe:(id)sender {
    NSLog(@"Randomize!\n");
    
    //Start spinner
    [self.spinner startAnimating];
    
    //Set NSString variable that yummly API understands for course
    NSString *yummlyCourse;
    if([self.mealType  isEqual: @"Breakfast and Brunch"]){
        yummlyCourse = @"Breakfast+and+Brunch";
    } else if([self.mealType  isEqual: @"Lunch and Snacks"]){
        yummlyCourse = @"Lunch+and+Snacks";
    } else if([self.mealType  isEqual: @"Main Dishes"]){
        yummlyCourse = @"Main+Dishes";
    } else if([self.mealType  isEqual: @"Desserts"]){
        yummlyCourse = @"Desserts";
    }
    
    //Set NSString variable that yummly API understands for max time (Our way of determining difficulty)
    NSString *yummlyMaxTime;
    if([self.difficulty isEqual: @"Very Easy"]){
        yummlyMaxTime = @"1800";
    } else if([self.difficulty isEqual: @"Easy"]){
        yummlyMaxTime = @"3600";
    } else if([self.difficulty isEqual: @"Medium"]){
        yummlyMaxTime = @"5400";
    } else if([self.difficulty isEqual: @"Hard"]){
        yummlyMaxTime = @"7200";
    } else if([self.difficulty isEqual: @"Very Hard"]){
        yummlyMaxTime = @"9000";
    }
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipes?_app_id=%@&_app_key=%@&allowedCourse=course%scourse-%@&allowedCuisine=cuisine%scuisine-%@&maxTotalTimeInSeconds=%@", applicationID, applicationKey, "%5E", yummlyCourse, "%5E",[self.dishType lowercaseString], yummlyMaxTime]];
    NSLog(@"URL: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    //getting the data
    NSData *newData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //json parse
    NSDictionary* json = nil;
    if (newData) {
        json = [NSJSONSerialization
                JSONObjectWithData:newData
                options:kNilOptions
                error:nil];
    }
    
    
    //Accessing JSON content
    //Get matches
    NSArray *matchesDict = [json valueForKey:@"matches"];
    
    //Get random recipe from matches
    int r = arc4random_uniform((int)[matchesDict count]);
    NSDictionary *recipe = [matchesDict objectAtIndex:r];
    //Grab that recipe's ID and name, set name to button text and make button visible
    self.recipeID = [recipe valueForKey:@"id"];
    self.recipeName = [recipe valueForKey:@"recipeName"];
    [self.recipeButton setTitle:self.recipeName forState:UIControlStateNormal];
    self.recipeButton.hidden=false;
    [self.spinner stopAnimating];

}

//Creates Recipe and RecipeDetailVC, loads up RecipeDetailVC
- (IBAction)loadRecipe:(id)sender {
    Recipe *recipe = [[Recipe alloc]initWithID:self.recipeID];
    RecipeDetailVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Details"];
    detailVC.recipe = recipe;
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
