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

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    //Title and background color
    self.navigationItem.title = self.recipe.recipeName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create and add test Label
    UILabel *scoreLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(10.0, 70.0, 150.0, 43.0) ];
    scoreLabel.text = @"Test";
    [self.view addSubview:scoreLabel];
    
    // Create and add UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Ingredients", @"Nutrition", @"Recipe", nil]];
    segmentedControl.frame = CGRectMake(35, 200, 250, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    // Create and add Table View for ingredients
    CGRect fr = CGRectMake(0, 245, screenWidth - 20, 225);
    UITableView *tableView = [[UITableView alloc] initWithFrame:fr
                                                           style:UITableViewStylePlain];
    //tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView reloadData];
    [self.view addSubview:tableView];
}

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

- (void)valueChanged:(UISegmentedControl *)segment {
    
    if(segment.selectedSegmentIndex == 0) {
        //action for the first button (Ingredients)
        
    }else if(segment.selectedSegmentIndex == 1){
        //action for the second button (Nutrition)
    }else if(segment.selectedSegmentIndex == 2){
        //action for the third button (Recipe)
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
