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
     
     
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:self.recipeDish completionHandler:^(NSArray *placemarks, NSError *error){
        if(error){
            //NSLog(@"Error: %@", [error localizedDescription]);
            return;
        }
        
        if([placemarks count] > 0){
            CLPlacemark *placemark = [placemarks lastObject];
            //self.location = placemark.location.coordinate;
            self.location = placemark.location;
            NSLog(@"Location inside: %@", self.location);
        }
    }];
    NSLog(@"Location outside: %@", self.location);
    

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
