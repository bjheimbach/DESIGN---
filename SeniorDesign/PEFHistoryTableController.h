//
//  PEFHistoryTableController.h
//  SeniorDesign
//
//  Created by Cheng Yang on 2/28/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface PEFHistoryTableController : UITableViewController
{
    sqlite3 *db;
}
@property (nonatomic, retain)NSMutableArray *entries;

-(NSString *) filePath;
-(void)openDB;
@end
