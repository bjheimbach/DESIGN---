//
//  PEFViewController.h
//  SeniorDesign
//
//  Created by Cheng Yang on 2/21/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "sqlite3.h"


@interface PEFViewController : UIViewController
{
    sqlite3 *db;
}
@property (weak, nonatomic) IBOutlet UITextField *PEFData;
@property (weak, nonatomic) IBOutlet UIButton *RecordButton;
@property (weak, nonatomic) IBOutlet UILabel *ResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *PercentLabel;
@property (weak, nonatomic) IBOutlet UITextField *commentText;

@property (weak, nonatomic) IBOutlet UILabel *LongitudeResult;
@property (weak, nonatomic) IBOutlet UILabel *LatitudeResult;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, readonly) NSDate *currentDate;

-(NSString *) filePath;
-(void)openDB;

//field names: date, longitude, latitude, PEF%
-(void) createTable: (NSString *) tableName
         withField1: (NSString *) field1
         withField2: (NSString *) field2
         withField3: (NSString *) field3
         withField4: (NSString *) field4
         withField5: (NSString *) field5;
- (IBAction)Click:(id)sender;


@end
