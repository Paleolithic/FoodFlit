//
//  GlobeVC.m
//  FoodFlit
//
//  Created by Student on 12/9/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "GlobeVC.h"


@interface GlobeVC ()

@end

@implementation GlobeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    } else{
        [self.locationManager requestAlwaysAuthorization];
    }
    [self startUpdating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"didUpdateToLocation: %@", userLocation);
    
    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 20000, 20000);
    //[self.mapView setRegion:region animated:YES];
    
    [self stopUpdating];
}

#pragma mark MKMapViewDelegate Methods

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    id<MKAnnotation> annotation = view.annotation;
    NSLog(@"The title of the tapped annotation is %@",annotation.title);
}

// This delegate method is called once for every annotation that is created.
// If no view is returned by this method, then only the default pin is seen by the user
- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id )annotation{
    
    MKAnnotationView *view = nil;
    
    if(annotation != mv.userLocation) {
        
        // if it's NOT the user's current location pin, create the annotation
        Recipe *parkAnnotation = (Recipe*)annotation;
        
        // Look for an existing view to reuse
        view = [mv dequeueReusableAnnotationViewWithIdentifier:@"recipeAnnotation"];
        
        // If an existing view is not found, create a new one
        if(view == nil) {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:(id) parkAnnotation reuseIdentifier:@"recipeAnnotation"];
        }
        
        // Now we have a view for the annotation, so let's set some properties
        [(MKPinAnnotationView *)view setPinColor:MKPinAnnotationColorRed];
        [(MKPinAnnotationView *)view setAnimatesDrop:YES];
        [view setCanShowCallout:YES];
        
        // Now create buttons for the annotation view
        // The 'tag' properties are set so that we can identify which button was tapped later
        //UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        //leftButton.tag = 0;
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        rightButton.tag = 0;
        
        // Add buttons to annotation view
        //[view setLeftCalloutAccessoryView:leftButton];
        [view setRightCalloutAccessoryView:rightButton];
    }
    
    // send this annotation view back to MKMapView so it can add it to the pin
    return view;
}

// This method is called when one of the two buttons added to the annotation view is tapped
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    Recipe *recipeAnnotation = (Recipe *)[view annotation];
    Recipe *recipe = [[Recipe alloc]initWithID:recipeAnnotation.recipeID];
    
    NSLog(@"Recipe stuff: %@, %@, %@", recipeAnnotation.recipeID, recipeAnnotation.recipeName, recipeAnnotation.recipeDifficulty);
    if([control tag] == 0){
        RecipeDetailVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Details"];
        detailVC.recipe = recipe;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else{
        NSLog(@"Should not be here in calloutAccesoryControlTapped");
        //NSLog(@"Should not be here in calloutAccessoryControlTapped, tag=%d!",[control tag]);
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//Checks for
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
    
    NSMutableArray *tempRecipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];
    self.recipes = [[NSMutableArray alloc]init];
    for(NSString *recID in tempRecipes){
        Recipe *rec = [[Recipe alloc]initWithID:recID];
        [self.recipes addObject:rec];
    }
    
    //CHECK IF PARKS WERE CREATED PROPERLY THIS IS IN CAPS IM SORRY
    for (Recipe *park in self.recipes){
        NSLog(@"park=%@",park);
        NSLog(@"Recipe Name:%@", park.recipeName);
        NSLog(@"Recipe Location:%@", park.location);
    }
    
    for (id<MKAnnotation> recipe in self.recipes) {
        //NSLog(self.mapView);
        [self.mapView addAnnotation:recipe];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
    for (id<MKAnnotation> recipe in self.recipes) {
        //NSLog(self.mapView);
        [self.mapView removeAnnotation:recipe];
    }
    
}
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
    
}
- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
    
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
