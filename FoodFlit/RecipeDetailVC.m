//
//  RecipeDetailVC.m
//  FoodFlit
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "RecipeDetailVC.h"

@interface RecipeDetailVC ()

@end

@implementation RecipeDetailVC

@synthesize recipe, pic, table, name;
- (void)viewDidLoad {
    [super viewDidLoad];

    //name.text = recipe.recipeName;
    
    
}
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 return [self.recipe.recipeIngredients count];
 }
 
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 // The header for the section is the region name -- get this from the region at the section index.
 return @"";
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *MyIdentifier = @"MyReuseIdentifier";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyReuseIdentifier"];
 }
 cell.textLabel.text = [self.recipe.recipeIngredients objectAtIndex:indexPath.row];
 return cell;
 }

 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)favorite:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
    //Remove from favorites
    if ([sender isSelected])
    {
        [sender setSelected:NO];
    }
    //Add to favorites
    else
    {
        NSMutableArray *farray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey:@"favorites"]];
        if (![farray containsObject:self.recipe.recipeID]) {
            [farray addObject:self.recipe.recipeID];
        }
        //NSLog(@"%lu", (unsigned long)[farray count]);
        [[NSUserDefaults standardUserDefaults] setObject:farray forKey:@"favorites"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"favoriteAdded" object:nil];
    }
}

-(IBAction)save:(id)sender{
    
}
-(IBAction)cooked:(id)sender{
    
}
- (IBAction)valueChanged:(UISegmentedControl *)segment {
    
    if(segment.selectedSegmentIndex == 0) {
        //action for the first button (Ingredients)
        
    }else if(segment.selectedSegmentIndex == 1){
        //action for the second button (Nutrition)
    }else if(segment.selectedSegmentIndex == 2){
        //action for the third button (Recipe)
    }
}


@end
