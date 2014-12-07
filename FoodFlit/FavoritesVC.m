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

@synthesize recipes;//, tableView;

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
    recipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"faveAdded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"bookmarked" object:nil];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FaveCell" forIndexPath:indexPath];
    Recipe *rec=[[Recipe alloc] initWithID:[recipes objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = rec.recipeName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)reloadTable{
    if(favoritesSelected){
        recipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];
        
    }else{
        recipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thebookmarkslist"]];
    }
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:false];
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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.recipes removeObjectAtIndex:indexPath.row];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:recipes forKey: @"favoriteslist"];
        [defaults synchronize];
        [tableView reloadData];
    }
}

-(IBAction)switchLists:(id)segment{
    if([segment selectedSegmentIndex]==0){ favoritesSelected=true; }
    else{ favoritesSelected=false; }
    
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:false];
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
