//
//  PEFViewController.m
//  SeniorDesign
//
//  Created by Cheng Yang on 2/21/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import "PEFViewController.h"
#import <CoreLocation/CoreLocation.h>

CLLocationManager *locationManager;

@interface PEFViewController ()

@end

@implementation PEFViewController
@synthesize LatitudeResult, LongitudeResult, PEFData, PercentLabel, ResultLabel,commentText;


-(void) createTable: (NSString *)tableName
         withField1: (NSString *) field1
         withField2: (NSString *) field2
         withField3: (NSString *) field3
         withField4: (NSString *) field4
         withField5: (NSString *) field5
{
    char *err;
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                     "TEXT PRIMARY KEY, '%@' DOUBLE, '%@'DOUBLE, '%@' INTEGER, '%@' TEXT);", tableName, field1, field2, field3, field4, field5];
    if(sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err)
       != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"Could not create table");
    }else{
        NSLog(@"table created");
    }
}


//file path to PEFHistory
-(NSString *) filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"bp.sql"];
}

//Open the DataBase
-(void)openDB {
    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"Database failed to open");
    }
    else{
        NSLog(@"database opened");
    }
    
}


- (void)viewDidLoad
{
    [self openDB];
    [self createTable:@"summary" withField1:@"theDate" withField2:@"Longitude" withField3:@"Latitude" withField4:@"PEF" withField5:@"Comments"];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.ResultLabel.text = @"Peak Flow Result";
    self.PercentLabel.text = @"Percent Maximum";
    [self.RecordButton setTitle:@"RECORD" forState:UIControlStateNormal];
    
    self.mapView.showsUserLocation = YES;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Click:(id)sender {
    //int direct = 1;
    
    self.ResultLabel.text = self.PEFData.text;
    [self.PEFData resignFirstResponder];
    [self.commentText resignFirstResponder];
    self.PercentLabel.text = [NSString stringWithFormat: @"%i", (PEFData.text.intValue * 100 / 500)];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    LatitudeResult.text = latitude;
    LongitudeResult.text = longitude;

    //Data Storage
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd, HH:mm"];
    NSDate *theDate = [[NSDate alloc] init];
    
    double longi = [LongitudeResult.text intValue];
    double lati = [LatitudeResult.text intValue];
    int percent = [PercentLabel.text intValue];
    NSString *comments = self.commentText.text;
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO summary ('theDate', 'Longitude', 'Latitude', 'PEF','Comments') VALUES ('%@','%f','%f','%d','%@')", theDate, longi, lati, percent, comments];
                     
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) !=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Could not update table)");
    }else{
        NSLog(@"table updated");
    }
    //LatitudeResult.text = @"";
    //LongitudeResult.text = @"";
    //PercentLabel.text = @"";
    //ResultLabel.text = @"";
    PEFData.text = @"";
    commentText.text = @"";
}
    
    
    

@end
