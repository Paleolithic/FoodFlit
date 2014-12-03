//
//  Recipe.m
//  FoodFlit
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "Recipe.h"
#define applicationID @"29b9d634"
#define applicationKey @"117626e0b87c1c939e82a5ed3102f6e8"

@implementation Recipe

@synthesize recipeID, recipeName, recipeImage, recipeIngredients, recipeNutrition;

-(id) init{
    /*
     self = [super init];
     if(self){
     //init code goes here
     }
     return self;
     */
    return [self initWithID:@"unknown"];
    //return[self initWithName:@"unknown" location:@"unknown" formed:@"unknown" area:@"unknown" link:@"unknown" cLocation:nil imageLink:@"unknown" parkDescription:@"unknown" ];
}

-(id)initWithID:(NSString *)r_ID{
    self.recipeID = r_ID;
    //self.recipeName = r_Name;
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipe/%@?_app_id=%@&_app_key=%@", self.recipeID, applicationID, applicationKey]];
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
    
    //Name set
    NSLog(@"Response : %@", json);
    self.recipeName = [json valueForKey:@"name"];
    
    //Image url set
    NSArray *images = [json valueForKey:@"images"];
    NSLog(@"Recipe Images: %@", images);
    NSDictionary *imagesDict = [images objectAtIndex: 0];
    self.recipeImage = [imagesDict valueForKey:@"hostedLargeUrl"];
    
    //Ingredients array set
    self.recipeIngredients = [json valueForKey:@"ingredientLines"];
    
    //Nutrition array set
    self.recipeNutrition   = [json valueForKey:@"nutritionEstimates"];
    
    
    return self;
}

+(id)recipe{
    Recipe *recipe = [[self alloc] init];
    
    return recipe;
}
@end
