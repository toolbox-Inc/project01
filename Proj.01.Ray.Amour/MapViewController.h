//
//  MapViewController.h
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 11/12/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Proj01DetailViewController.h"
#import "Annotations.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (nonatomic, strong)IBOutlet MKMapView *map;

@property (nonatomic, strong) NSManagedObject *coordinatesObject;

@property (nonatomic, strong) NSMutableDictionary *locationDictionary;
@property (nonatomic, strong) CLGeocoder *geoCoder;
@property (nonatomic, strong) CLPlacemark *placemark;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

- (IBAction)findAdress:(UIButton *)sender;
- (IBAction)getRoute:(UIButton *)sender;






@end
