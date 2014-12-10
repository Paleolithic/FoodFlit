//
//  GlobeVC.h
//  FoodFlit
//
//  Created by Student on 12/9/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocation.h>
#import <AddressBook/AddressBook.h>

#import "Recipe.h"
#import "RecipeDetailVC.h"

@interface GlobeVC : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *recipes;

-(void)startUpdating; //start location manager updating
-(void)stopUpdating;  //stop location manager updating

@end
