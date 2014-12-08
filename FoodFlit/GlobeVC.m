//
//  GlobeVC.m
//  FoodFlit
//
//  Created by Student on 12/8/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "GlobeVC.h"
#import "Recipe.h"

@interface GlobeVC ()

@end

@implementation GlobeVC

@synthesize recipes;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"IOS8");
        [self.locationManager requestWhenInUseAuthorization];
    } else{
        NSLog(@"Not");
        [self.locationManager requestAlwaysAuthorization];
    }
    [self startUpdating];
    
    recipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];
    NSLog(@"Favorites List: %@", recipes);
    /*for (NSString *recipeID in recipes) {
        Recipe *rec=[[Recipe alloc] initWithID:recipeID];
        id<MKAnnotation> recAnnot = rec;
        NSLog(@"recAnnot: %@", rec.location);
        [self.mapView addAnnotation:recAnnot];
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"didUpdateToLocation: %@", userLocation);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 20000, 20000);
    [self.mapView setRegion:region animated:YES];
    
    [self stopUpdating];
}

-(void)startUpdating
{
    [self.indicatorView startAnimating];
    [self.locationManager startUpdatingLocation];
}

-(void)stopUpdating
{
    [self.indicatorView stopAnimating];
    [self.locationManager stopUpdatingLocation];
}

// This delegate method is called once for evesry annotation that is created.
// If no view is returned by this method, then only the default pin is seen by the user
- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id )annotation{
    
    MKAnnotationView *view = nil;
    
    if(annotation != mv.userLocation) {
        
        // if it's NOT the user's current location pin, create the annotation
        Recipe *recipeAnnotation = (Recipe*)annotation;
        
        // Look for an existing view to reuse
        view = [mv dequeueReusableAnnotationViewWithIdentifier:@"recipeAnnotation"];
        
        // If an existing view is not found, create a new one
        if(view == nil) {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:(id) recipeAnnotation reuseIdentifier:@"recipeAnnotation"];
        }
        
        // Now we have a view for the annotation, so let's set some properties
        [(MKPinAnnotationView *)view setPinColor:MKPinAnnotationColorRed];
        [(MKPinAnnotationView *)view setAnimatesDrop:YES];
        [view setCanShowCallout:YES];
        
        // Now create buttons for the annotation view
        // The 'tag' properties are set so that we can identify which button was tapped later
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        leftButton.tag = 0;
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        rightButton.tag = 1;
        
        // Add buttons to annotation view
        [view setLeftCalloutAccessoryView:leftButton];
        [view setRightCalloutAccessoryView:rightButton];
    }
    
    // send this annotation view back to MKMapView so it can add it to the pin
    return view;
}

// This method is called when one of the two buttons added to the annotation view is tapped
- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    Recipe *recipeAnnotation = (Recipe *)[view annotation];
    switch ([control tag]) {
        case 0: // left button
        {
            NSLog(@"Left button clicked");
            /*
            ParkDetailGroupedTableVC *detailVC = [[ParkDetailGroupedTableVC alloc] initWithStyle:UITableViewStyleGrouped];
            detailVC.title = parkAnnotation.title;
            detailVC.park = parkAnnotation;
            [self.navigationController pushViewController:detailVC animated:YES];
             */
        }
            break;
            
        case 1: // right button
        {
            NSLog(@"Right button clicked");
            /*
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder reverseGeocodeLocation:parkAnnotation.location completionHandler:^(NSArray *placemarks, NSError *error){
                if(error){
                    NSLog(@"Reverse geocode failed with error: %@", error);
                }
                if(placemarks && placemarks.count > 0){
                    CLPlacemark *placemark = placemarks[0];
                    NSDictionary *address = placemark.addressDictionary;
                    MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:parkAnnotation.coordinate addressDictionary:address];
                    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:place];
                    NSDictionary * options = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving};
                    [mapItem openInMapsWithLaunchOptions:options];
                }
            }];
            */
            //NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@ %@", parkAnnotation.parkLocation];
            // build a maps url. This will launch the Maps app on the hardware, and the apple maps website in the simulator
            //CLLocationCoordinate2D coordinate = self.locationManager.location.coordinate;
            // NSString *url2 = [NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f",coordinate.latitude,coordinate.longitude,parkAnnotation.location.coordinate.latitude,parkAnnotation.location.coordinate.longitude];
            // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url2]];
        }
            break;
            
        default:
            NSLog(@"Should not be here in calloutAccessoryControlTapped, tag=%d!",[control tag]);
            break;
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
