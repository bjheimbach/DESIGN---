//
//  TrackViewController.h
//  SeniorDesign
//
//  Created by Cheng Yang on 2/22/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TrackViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *RecordButton;
@property (weak, nonatomic) IBOutlet UILabel *SecondResult;
@property (weak, nonatomic) IBOutlet UILabel *PercentResult;

@property (weak, nonatomic) IBOutlet UILabel *LongitudeResult;
@property (weak, nonatomic) IBOutlet UILabel *LatitudeResult;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)ClickButton:(id)sender;

@end
