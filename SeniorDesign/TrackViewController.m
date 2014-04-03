//
//  TrackViewController.m
//  SeniorDesign
//
//  Created by Cheng Yang on 2/22/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import "TrackViewController.h"
#import <CoreLocation/CoreLocation.h>

CLLocationManager *locationManager;

@interface TrackViewController ()

@end

@implementation TrackViewController

int Start = 200;
int Next = 200;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.SecondResult.text = @"# left";
    self.PercentResult.text = @"Percent left";
    
    self.mapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickButton:(id)sender {
    self.SecondResult.text = [NSString stringWithFormat:@"%i", Next - 1];
    self.PercentResult.text = [NSString stringWithFormat:@"%i", _SecondResult.text.intValue * 100/200];
    Next = Next - 1;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    _LatitudeResult.text = latitude;
    _LongitudeResult.text = longitude;
    
}

@end
