//
//  FavoritesVC.m
//  FoodFlit
//
//  Created by Student on 12/3/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "FavoritesVC.h"
#import "Recipe.h"
@interface FavoritesVC ()

@end

@implementation FavoritesVC

@synthesize recipes, tableView;

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
    
    recipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"favoriteslist2"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"faveAdded" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"\n\n\n\n%@\n\n\n\n",indexPath);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FaveCell" forIndexPath:indexPath];
    NSArray *p = (NSArray *)[recipes objectAtIndex:indexPath.row];
    Recipe *rec=(Recipe *)[NSKeyedUnarchiver unarchiveObjectWithData:[p objectAtIndex:1]];
    cell.textLabel.text = rec.recipeName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)reloadTable{
    recipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"favoriteslist2"]];
    [tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n\n\n\n%@\n\n\n\n",indexPath);
    NSArray *a = (NSArray *)[recipes objectAtIndex:[indexPath row]];
    Recipe *recipe = [NSKeyedUnarchiver unarchiveObjectWithData:[a objectAtIndex:1]];
    
    RecipeDetailVC *detailVC = [[RecipeDetailVC alloc] init];
    detailVC.recipe = recipe;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.recipes removeObjectAtIndex:indexPath.row];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:recipes forKey: @"favoriteslist2"];
        [defaults synchronize];
        [tableView reloadData];
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
