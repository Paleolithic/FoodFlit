//
//  Recipe.h
//  FoodFlit
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject<NSCoding>{
   
    NSString *recipeImage;
    NSArray  *recipeIngredients;
    NSArray  *recipeNutrition;
}

@property (nonatomic, assign) NSString *recipeID;
@property (nonatomic, assign) NSString *recipeName;
@property (nonatomic, strong) NSString *recipeImage;
@property (nonatomic, strong) NSArray  *recipeIngredients;
@property (nonatomic, strong) NSArray  *recipeNutrition;
@property (nonatomic, strong) NSURL    *recipeURL;
@property (nonatomic, strong) NSString *recipeMeal;
@property (nonatomic, strong) NSString *recipeDish;
@property (nonatomic, strong) NSString *recipeDifficulty;

+(id)recipe;
-(id)initWithID:(NSString *)r_ID;

- (void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

@end
