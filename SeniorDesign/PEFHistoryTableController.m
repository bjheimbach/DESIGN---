//
//  PEFHistoryTableController.m
//  SeniorDesign
//
//  Created by Cheng Yang on 2/28/14.
//  Copyright (c) 2014 Cheng Yang. All rights reserved.
//

#import "PEFHistoryTableController.h"

@interface PEFHistoryTableController ()

@end

@implementation PEFHistoryTableController

@synthesize entries;


- (void)viewDidLoad
{
    entries = [[NSMutableArray alloc] init];
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
            
            NSString *str = [[NSString alloc]initWithFormat:@"%@ - %@",field4Str,field5Str];
            [entries addObject:str];
        }
        
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [entries count];
    NSLog(@"%d",[entries count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test");
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.entries objectAtIndex:indexPath.row];
    return cell;
}













@end
