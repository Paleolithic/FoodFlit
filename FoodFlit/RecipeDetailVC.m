//
//  RecipeDetailVC2.m
//  FoodFlit
//
//  Created by Dominique Raymond on 12/3/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "RecipeDetailVC.h"

@interface RecipeDetailVC ()

@end

@implementation RecipeDetailVC
@synthesize recipe, name, pic, segment, tableView, info;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    //NSLog(@"%@\n",recipe.recipeIngredients);
    
    name.text = recipe.recipeName;
    info.text = [NSString stringWithFormat:@"%@ ∫ %@ ∫ %@",recipe.recipeMeal, recipe.recipeDish, recipe.recipeDifficulty];
    pic.image = recipe.recipeImage;
    [self ButtonStates];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ButtonStates{
    NSMutableArray *arrayB = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thebookmarkslist"]];
    if ([arrayB containsObject:recipe.recipeID]){
        self.save.selected = YES;
    }else self.save.selected = NO;
    
    NSMutableArray *arrayF = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];
    if ([arrayF containsObject:recipe.recipeID]){
        self.heart.selected = YES;
    }else self.heart.selected = NO;
    NSMutableArray *arrayC = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thecookedlist"]];
    if ([arrayC containsObject:recipe.recipeID]){
        self.cooked.selected = YES;
    }else self.cooked.selected = NO;
    
    
}

-(IBAction)save:(id)sender{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thebookmarkslist"]];
    if ([array containsObject:recipe.recipeID]){
        [array removeObject:recipe.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thebookmarkslist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bookmarked" object:nil];
        self.save.selected = NO;
    }else{
        [array addObject:recipe.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thebookmarkslist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bookmarked" object:nil];
        self.save.selected = YES;
    }
}
-(IBAction)cooked:(id)sender{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thecookedlist"]];
    NSMutableArray *arrayDates = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"cookedDates"]];
    if ([array containsObject:recipe.recipeID]){
        [arrayDates removeObjectAtIndex:[array indexOfObject:recipe.recipeID]];
        [array removeObject:recipe.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thecookedlist"];
        [[NSUserDefaults standardUserDefaults] setObject:arrayDates forKey:@"cookedDates"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cooked" object:nil];
        self.cooked.selected = NO;
    }else{
        [array addObject:recipe.recipeID];
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy 'at' HH:mm"];
        [arrayDates addObject:[dateFormatter stringFromDate:today]];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thecookedlist"];
        [[NSUserDefaults standardUserDefaults] setObject:arrayDates forKey:@"cookedDates"];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"cooked" object:nil];
        self.cooked.selected = YES;
        
    }
    
}
-(IBAction)heart:(id)sender{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];
    if ([array containsObject:recipe.recipeID]){
        [array removeObject:recipe.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thefavoriteslist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"faveAdded" object:nil];
        self.heart.selected = NO;
    }else{
        [array addObject:recipe.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thefavoriteslist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"faveAdded" object:nil];
        self.heart.selected = YES;
    }
}

- (IBAction)valueChanged:(UISegmentedControl *)seg {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(segment.selectedSegmentIndex == 0) {
        return recipe.recipeIngredients.count;
    }else if(segment.selectedSegmentIndex == 1){
        return recipe.recipeNutrition.count;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];

    if(segment.selectedSegmentIndex == 0) {
        //Make table visible
        [self.webView setHidden:YES];
        [self.tableView setHidden:NO];
        cell.textLabel.text = [recipe.recipeIngredients objectAtIndex:indexPath.row];
        
    }else if(segment.selectedSegmentIndex == 1){
        //Make table visible
        [self.webView setHidden:YES];
        [self.tableView setHidden:NO];
       
        //Get and set cells text to nutrition information
        NSDictionary *nutDict = [recipe.recipeNutrition objectAtIndex:indexPath.row];
        NSDictionary *unitDict = [nutDict valueForKey:@"unit"];
        NSString *nutDesc = [nutDict valueForKey:@"description"];
        if(nutDesc == ( NSString *) [ NSNull null ]){
            nutDesc = @"Calories";
        }
         NSLog(@"Desc: %@", nutDesc);
        NSString *nutVal  = [nutDict valueForKey:@"value"];
        NSString *nutUnit = [unitDict valueForKey:@"abbreviation"];
        NSString *labelText = [NSString stringWithFormat:@"%@: %@ %@", nutDesc, nutVal, nutUnit];
        
        cell.textLabel.text = labelText;
    }else if(segment.selectedSegmentIndex == 2){
        [self.indicator startAnimating];
        //Make webView visible
        NSLog(@"Loading webView with url: %@", self.recipe.recipeURL);
        [self.webView setHidden:NO];
        [self.tableView setHidden:YES];
        NSURL *url = self.recipe.recipeURL;
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:requestObj];
        [self.indicator stopAnimating];
    }
    
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*if(segment.selectedSegmentIndex == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }*/
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
