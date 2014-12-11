//
//  Recipe.h
//  FoodFlit
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>

@interface Recipe : NSObject<MKAnnotation>{
   
    UIImage *recipeImage;
    NSArray  *recipeIngredients;
    NSArray  *recipeNutrition;
    CLLocationCoordinate2D *location;
}

@property (nonatomic, assign) NSString *recipeID;
@property (nonatomic, strong) NSString *recipeName;
@property (nonatomic, strong) UIImage *recipeImage;
@property (nonatomic, strong) NSArray  *recipeIngredients;
@property (nonatomic, strong) NSArray  *recipeNutrition;
@property (nonatomic, strong) NSURL    *recipeURL;
@property (nonatomic, strong) NSString *recipeMeal;
@property (nonatomic, strong) NSString *recipeDish;
@property (nonatomic, strong) NSString *recipeDifficulty;
@property (nonatomic, strong) CLLocation *location;


+(id)recipe;
-(id)initWithID:(NSString *)r_ID;



@end
