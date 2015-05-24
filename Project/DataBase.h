//
//  DataBase.h
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Country.h"
@interface DataBase : NSObject

@property (strong,nonatomic) NSString *DBBundelBath;
@property (strong ,nonatomic)NSString *Documenpath;
@property NSMutableArray* Countries;
@property sqlite3 *database;
-(instancetype)initWithDB:(NSString *)fileName;
-(void)copyDbfileToDocumentpath ;
-(void)fillCountries;
-(BOOL)isempty;
-(void)ClearDB;
-(BOOL)addCountry:(Country *)country;
-(bool)excuteQuery:(char *)query isExcutable:(BOOL)excutable;
-(bool)adddetails:(Country *)country;
-(bool)addimg:(Country *)country;
-(Country *)loadcountry:(Country *)country;
@end
