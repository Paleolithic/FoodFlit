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

@synthesize recipeID, recipeName, recipeImage, recipeIngredients, recipeNutrition, recipeURL, location=_location;

-(id) init{
    
     self = [super init];
     if(self){
     //init code goes here
     }
     return self;
     
    //return [self initWithID:@"unknown"];
    //return[self initWithName:@"unknown" location:@"unknown" formed:@"unknown" area:@"unknown" link:@"unknown" cLocation:nil imageLink:@"unknown" parkDescription:@"unknown" ];
}

-(id)initWithID:(NSString *)r_ID{
    self.recipeID = r_ID;
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipe/%@?_app_id=%@&_app_key=%@", self.recipeID, applicationID, applicationKey]];
    //NSLog(@"URL: %@", url);
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
    
    //NSLog(@"Response : %@", json);
    
    //Name set
    self.recipeName = [json valueForKey:@"name"];
    
    //Image url set
    NSArray *images = [json valueForKey:@"images"];
    NSDictionary *imagesDict = [images objectAtIndex: 0];
    self.recipeImage = [imagesDict valueForKey:@"hostedLargeUrl"];
    
    //Ingredients array set
    self.recipeIngredients = [json valueForKey:@"ingredientLines"];
    
    
    //Nutrition array set
    self.recipeNutrition   = [json valueForKey:@"nutritionEstimates"];
    //NSLog(@"Recipe Nutrition: %@", self.recipeNutrition);
    
    //URL set
    NSString *urlString = [[json objectForKey:@"source"] objectForKey:@"sourceRecipeUrl"];
    self.recipeURL = [NSURL URLWithString:urlString];
    //NSLog(@"URL: %@", self.recipeURL);
    
    //Recipe dish set
    NSArray *cuisines = [[json objectForKey:@"attributes"] objectForKey:@"cuisine"];
    self.recipeDish = [cuisines objectAtIndex:0];
    
    
    //Coordinates set based on recipe dish
    CLLocationCoordinate2D coord;
    if([self.recipeDish isEqual: @"American"] || [self.recipeDish isEqual: @"Barbecue"]){
        coord = CLLocationCoordinate2DMake(37.090240, -95.712891);
    }
    else if([self.recipeDish isEqual: @"Italian"]){
        coord = CLLocationCoordinate2DMake(41.871940, 12.567380);
    }
    else if([self.recipeDish isEqual: @"Asian"]){
        coord = CLLocationCoordinate2DMake(34.047863, 100.619655);
    }
    else if([self.recipeDish isEqual: @"French"]){
        coord = CLLocationCoordinate2DMake(46.227638, 2.213749);
    }
    else if([self.recipeDish isEqual: @"Chinese"]){
        coord = CLLocationCoordinate2DMake(9.648579, 123.855566);
    }
    else if([self.recipeDish isEqual: @"Greek"]){
        coord = CLLocationCoordinate2DMake(39.074208, 21.824312);
    }
    else if([self.recipeDish isEqual: @"German"]){
        coord = CLLocationCoordinate2DMake(51.165691, 10.451526);
    }
    else if([self.recipeDish isEqual: @"Thai"]){
        coord = CLLocationCoordinate2DMake(15.870032, 100.992541);
    }
    else if([self.recipeDish isEqual: @"Japanese"]){
        coord = CLLocationCoordinate2DMake(36.204824, 138.252924);
    }
    else if([self.recipeDish isEqual: @"Spanish"]){
        coord = CLLocationCoordinate2DMake(46.194796, -82.342278);
    }
    else if([self.recipeDish isEqual: @"Mediterranean"]){
        coord = CLLocationCoordinate2DMake(34.553128, 18.048011);
    }
    else if([self.recipeDish isEqual: @"Mexican"]){
        coord = CLLocationCoordinate2DMake(23.634501, -102.552784);
    }
    else if([self.recipeDish isEqual: @"Indian"]){
        coord = CLLocationCoordinate2DMake(20.593684, 78.96288);
    }
    
    self.location = [[CLLocation alloc]initWithCoordinate:coord
                                                 altitude:0
                                       horizontalAccuracy:0
                                         verticalAccuracy:0
                                                timestamp:[NSDate date] ];
    return self;
}

+(id)recipe{
    Recipe *recipe = [[self alloc] init];
    
    return recipe;
}

//needed for MKAnnotation Protocol method
-(CLLocationCoordinate2D)coordinate {
    return self.location.coordinate;
}

- (NSString*)title{
    return self.recipeName;
}

- (NSString *)subtitle{
    return self.recipeDish;
}

@end
