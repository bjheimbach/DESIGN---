//
//  CurveViewController.h
//  SeniorDesign
//
//  Created by Matthew Schneiderhan on 3/26/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "sqlite3.h"


@interface CurveViewController : UIViewController <CPTPlotDataSource>
{
    sqlite3 *db;
}
@property (nonatomic, strong) CPTGraphHostingView *hostView;

@property (nonatomic, retain)NSMutableArray *entries;
@property (nonatomic, retain)NSMutableArray *PEF;

-(NSString *) filePath;
-(void)openDB;


@end
