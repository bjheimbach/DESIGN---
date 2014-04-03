//
//  MapViewController.m
//  SeniorDesign
//
//  Created by Matthew Schneiderhan on 3/26/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import "MapViewController.h"
#import "MapPin.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView;

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
    [super viewDidLoad];
    
    [self openDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM summary"];
    sqlite3_stmt *statement;
    
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement,nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *field1 = (char *) sqlite3_column_text(statement, 0);
            NSString *field1Str = [[NSString alloc]initWithUTF8String:field1];
            
            char *field2 = (char *) sqlite3_column_text(statement, 1);
            NSString *field2Str = [[NSString alloc]initWithUTF8String:field2];
            
            char *field3 = (char *) sqlite3_column_text(statement, 2);
            NSString *field3Str = [[NSString alloc]initWithUTF8String:field3];
            
            char *field4 = (char *) sqlite3_column_text(statement, 3);
            NSString *field4Str = [[NSString alloc]initWithUTF8String:field4];
            
            char *field5 = (char *) sqlite3_column_text(statement, 4);
            NSString *field5Str = [[NSString alloc]initWithUTF8String:field5];
            
        MapPin *ann = [[MapPin alloc] init];
        ann.title = field4Str;
        ann.subtitle = field5Str;
        ann.coordinate = CLLocationCoordinate2DMake(field3Str.doubleValue,field2Str.doubleValue);
        [mapView addAnnotation:ann];
    
        }
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
