//
//  TimelineVC.m
//  FoodFlit
//
//  Created by Dominique Raymond on 12/16/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "TimelineVC.h"

@interface TimelineVC ()

@end

@implementation TimelineVC

@synthesize recipes;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    favoritesSelected = true;
    recipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thecookedlist"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"cooked" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadTable{
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:false];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [recipes count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"TimelineCell" forIndexPath:indexPath];
    Recipe *rec=[[Recipe alloc] initWithID:[recipes objectAtIndex:indexPath.section]];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.imgView.image = rec.recipeImage;
    cell.recipeID = rec.recipeID;
    cell.name.text = rec.recipeName;
    cell.info.text = [NSString stringWithFormat:@"%@ ∫ %@ ∫ %@",rec.recipeMeal, rec.recipeDish, rec.recipeDifficulty];
    [cell ButtonStates];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Recipe *rec=[[Recipe alloc] initWithID:[recipes objectAtIndex:indexPath.row]];
    RecipeDetailVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Details"];
    detailVC.recipe = rec;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Date PlaceHolder";
}

@end
