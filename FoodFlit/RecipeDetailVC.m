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
@synthesize recipe, name, pic, segment, tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    NSLog(@"%@\n",recipe.recipeIngredients);
    
    name.text = recipe.recipeName;
    NSURL *url = [NSURL URLWithString:recipe.recipeImage];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    pic.image = img;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)favorite:(id)sender
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"favoriteslist2"]];
    NSArray *a = @[recipe.recipeID,[NSKeyedArchiver archivedDataWithRootObject:recipe]];
    if (![array containsObject:a]) {
        [array addObject:a];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"favoriteslist2"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"faveAdded" object:nil];
    }

}

-(IBAction)save:(id)sender{
    
}
-(IBAction)cooked:(id)sender{
    
}
- (IBAction)valueChanged:(UISegmentedControl *)seg {
    [tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(segment.selectedSegmentIndex == 0) {
        return 5;
        
    }else if(segment.selectedSegmentIndex == 1){
        return recipe.recipeNutrition.count;
    }else{
        return recipe.recipeIngredients.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];

    
    if(segment.selectedSegmentIndex == 0) {
        
    }else if(segment.selectedSegmentIndex == 1){
        cell.textLabel.text = [recipe.recipeNutrition objectAtIndex:indexPath.row];
    }else if(segment.selectedSegmentIndex == 2){
        cell.textLabel.text = [recipe.recipeIngredients objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(segment.selectedSegmentIndex == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
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
