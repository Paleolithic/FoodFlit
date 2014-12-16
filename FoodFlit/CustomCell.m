//
//  CustomCell.m
//  FoodFlit
//
//  Created by Dominique Raymond on 12/10/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
    //[self ButtonStates];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)ButtonStates{
    NSMutableArray *arrayB = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thebookmarkslist"]];
    if ([arrayB containsObject:self.recipeID]){
        self.save.selected = YES;
    }else self.save.selected = NO;
    
    NSMutableArray *arrayF = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];
    if ([arrayF containsObject:self.recipeID]){
        self.heart.selected = YES;
    }else self.heart.selected = NO;
    NSMutableArray *arrayC = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thecookedlist"]];
    if ([arrayC containsObject:self.recipeID]){
        self.cooked.selected = YES;
    }else self.cooked.selected = NO;
    
    
}

-(IBAction)save:(id)sender{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thebookmarkslist"]];
    if ([array containsObject:self.recipeID]){
        [array removeObject:self.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thebookmarkslist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bookmarked" object:nil];
        self.save.selected = NO;
    }else{
        [array addObject:self.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thebookmarkslist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bookmarked" object:nil];
        self.save.selected = YES;
    }
}
-(IBAction)cooked:(id)sender{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thecookedlist"]];
    if ([array containsObject:self.recipeID]){
        [array removeObject:self.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thecookedlist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cooked" object:nil];
        self.cooked.selected = NO;
    }else{
        [array addObject:self.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thecookedlist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cooked" object:nil];
        self.cooked.selected = YES;
    }
    
}
-(IBAction)heart:(id)sender{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];
    if ([array containsObject:self.recipeID]){
        [array removeObject:self.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thefavoriteslist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"faveAdded" object:nil];
        self.heart.selected = NO;
    }else{
        [array addObject:self.recipeID];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"thefavoriteslist"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"faveAdded" object:nil];
        self.heart.selected = YES;
    }
}

-(IBAction)comment:(id)sender{
    if(![self.textField.text isEqual:@""]){
        self.textView.text = [NSString stringWithFormat:@"%@\n%@", self.textView.text, self.textField.text];
        self.textField.text=@"";
    }
}

@end
