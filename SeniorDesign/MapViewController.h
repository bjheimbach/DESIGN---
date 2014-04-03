//
//  MapViewController.h
//  SeniorDesign
//
//  Created by Matthew Schneiderhan on 3/26/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapPin.h"
#import "sqlite3.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    MKMapView *mapView;
    sqlite3 *db;
}
@property (strong, nonatomic)IBOutlet MKMapView *mapView;

@property (nonatomic, retain)NSMutableArray *entries;
-(NSString *) filePath;
-(void)openDB;

@end
