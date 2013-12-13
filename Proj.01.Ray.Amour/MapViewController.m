//
//  MapViewController.m
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 11/12/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import "MapViewController.h"

#import "Coordinates.h"

@interface MapViewController ()

@property (nonatomic, strong) MKRoute *routeDetails;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addressTextField.delegate = self;
    self.geoCoder = [[CLGeocoder alloc]init];
    [self startStandardUpdates];
    [self addAnnotation];
   
    NSLog(@"latitude in map is %@", [self.coordinatesObject valueForKey:@"latitude"]);
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startStandardUpdates
{
    if (self.locationManager == nil)
        self.locationManager = [[CLLocationManager alloc]init];
    
    self.locationManager.delegate = self;
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager startUpdatingLocation];
    
    self.map.delegate = self;
    
    self.userLocation = self.locationManager.location.coordinate;
    
    CLLocationCoordinate2D zoomlocation;
    zoomlocation.latitude = self.userLocation.latitude;
    zoomlocation.longitude = self.userLocation.longitude;
    
    MKCoordinateSpan span;
    span.latitudeDelta = 1;
    span.longitudeDelta = 1;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(zoomlocation, span);
    
    [self.map setRegion:viewRegion animated:YES];
    
    
}

-(void)addAnnotation
{
    
    CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = [[self.coordinatesObject valueForKey:@"latitude"]doubleValue];
    newCoordinate.longitude = [[self.coordinatesObject valueForKey:@"longitude"]doubleValue];
    
    Annotations *newAnnotation = [[Annotations alloc]init];
    [newAnnotation setCoordinate:newCoordinate];
    [newAnnotation setTitle:[self.placemark.addressDictionary valueForKey:@"City"]];
    [newAnnotation setSubtitle:[self.placemark.addressDictionary valueForKey:@"Country"]];
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:newCoordinate.latitude longitude:newCoordinate.longitude];
    
    [self.map addAnnotation:newAnnotation];
    [self geoCoderUpdate:location];
    
    
}


-(void)geoCoderUpdate:(CLLocation *)location
{
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {

            self.placemark = [placemarks lastObject];
            self.addressTextField.text = [NSString stringWithFormat:@"%@",[self.placemark.addressDictionary valueForKey:@"City"]];
        }
        
    }];

}

- (IBAction)findAdress:(UIButton *)sender {
    
    NSArray *pins = [[NSArray alloc]initWithArray:self.map.annotations];
    [self.map removeAnnotations:pins];
    
    
    
    [self.geoCoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!error) {

   
        self.placemark = [placemarks lastObject];
        MKCoordinateRegion region;
        region.center.latitude = self.placemark.location.coordinate.latitude;
        region.center.longitude = self.placemark.location.coordinate.longitude;
        region.span.latitudeDelta = 3;
        region.span.longitudeDelta = 3;
        
        [self.map setRegion:region animated:YES];
        [self.coordinatesObject setValue:[NSNumber numberWithDouble:self.placemark.location.coordinate.latitude]forKey:@"latitude"];
        [self.coordinatesObject setValue:[NSNumber numberWithDouble:self.placemark.location.coordinate.longitude] forKey:@"longitude"];
        [self addAnnotation];
            
        }
        
        else NSLog(@"%@",error);
    }];
    

    [self.addressTextField resignFirstResponder];
}

- (IBAction)getRoute:(UIButton *)sender {
    
    NSArray *overlay = [[NSArray alloc]initWithArray:[self.map overlays]];
    [self.map removeOverlays:overlay];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    
    CLLocationCoordinate2D src;
    src.latitude = self.userLocation.latitude;
    src.longitude = self.userLocation.longitude;
    
    CLLocationCoordinate2D dest;
    dest.latitude = self.placemark.location.coordinate.latitude;
    dest.longitude = self.placemark.location.coordinate.longitude;
    
    MKPlacemark *sMK = [[MKPlacemark alloc]initWithCoordinate:src addressDictionary:NULL];
    MKPlacemark *dMK = [[MKPlacemark alloc] initWithCoordinate:dest addressDictionary:NULL];
    
    request.source = [[MKMapItem alloc]initWithPlacemark:sMK];
    request.destination = [[MKMapItem alloc]initWithPlacemark:dMK];
    request.transportType = MKDirectionsTransportTypeAutomobile;
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        if (error) {
            
            NSLog(@"we have an error: %@\n",[error description]);
        }else {
            
            self.routeDetails = response.routes.lastObject;
            [self.map addOverlay:self.routeDetails.polyline];
        }
        
    
    }];
    
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    MKPolylineRenderer *routeLineRenderer = [[MKPolylineRenderer alloc]initWithPolyline:self.routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 5;
    return routeLineRenderer;
}


@end

















