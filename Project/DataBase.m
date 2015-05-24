//
//  DataBase.m
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import "DataBase.h"


@implementation DataBase
@synthesize Countries;
-(instancetype)initWithDB:(NSString *)fileName{
    self = [super init];
    
    if(self){
        self.DBBundelBath = [[NSBundle mainBundle ]pathForResource:fileName ofType:@"sqlite"] ;
        [self copyDbfileToDocumentpath];
        Countries = [[NSMutableArray alloc]init];
        
    }
    return self;
    
}

-(void)copyDbfileToDocumentpath{
    NSArray *docs =NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    NSString *docDir = [docs objectAtIndex:0];
    self.Documenpath = [docDir stringByAppendingString:@"CountryDB.sqlite"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:self.DBBundelBath]) {
        NSError *err;
        [[NSFileManager defaultManager ]copyItemAtPath:self.DBBundelBath toPath:self.Documenpath error:&err];
        
    }
    
}








-(bool)excuteQuery:(char *)query isExcutable:(BOOL)excutable
{
    
    sqlite3 *database;
    
    BOOL isOpend=sqlite3_open([ self.Documenpath UTF8String], &database);
    if (isOpend == SQLITE_OK) {
        sqlite3_stmt *compiledStatment;
        BOOL isDone= sqlite3_prepare_v2(database, query, -1, &compiledStatment, NULL);
        
        if (isDone == SQLITE_OK) {
            Country *country;
            if (!excutable) {
                while (sqlite3_step(compiledStatment)==SQLITE_ROW)
                {
                    country = [[Country alloc]init];
                    char *name=(char*)sqlite3_column_text(compiledStatment, 0);
                    
                    [country setCountryid:[NSString stringWithFormat:@"%s",name]];
                    
                    [country setCountryName:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(compiledStatment, 1)]];
                    
                    [country setLon:sqlite3_column_double(compiledStatment, 2)];
                    [country setLat:sqlite3_column_double(compiledStatment, 3)];
                    
                    [country setDetails:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(compiledStatment, 4)]];
                    
                    int length = sqlite3_column_bytes(compiledStatment, 5);
                    [country setImaData:[NSData dataWithBytes:sqlite3_column_blob(compiledStatment, 5) length:length]];
                    [country setCity:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(compiledStatment, 6)]];

                    
                    
                    [self.Countries addObject:country];
                    
                    
                }
                return true;
            }
            else
            {
                if (sqlite3_step(compiledStatment) == SQLITE_DONE)
                {
                    NSLog(@"One Row Insertd");
                    return true;
                }
                else
                {
                    NSLog(@"%s",sqlite3_errmsg(database));
                    return false;
                }
            }
            
        }
        else
        {
            NSLog(@"%s",sqlite3_errmsg(database));
            return false;
        }
    }
    else
    {
        NSLog(@"%s",sqlite3_errmsg(database));
        return false;
    }
    
    return false;
    
}


-(BOOL)addCountry:(Country *)country{
    NSString *query=[NSString stringWithFormat:@"insert into  Country values('"];
    query = [query stringByAppendingString:country.Countryid];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:country.countryName];
    query = [query stringByAppendingString:@"',"];
    query = [query stringByAppendingString:[NSString stringWithFormat:@"%f",country.lon]];
    query = [query stringByAppendingString:@","];
     query = [query stringByAppendingString:[NSString stringWithFormat:@"%f",country.lat]];
    query = [query stringByAppendingString:@",null,null,null"];
    
    query = [query stringByAppendingString:@")"];
    //DataBase *mgr=[[DataBase alloc]initWithDB:@"Stuff"];
    char *queryChar=(char*)[query UTF8String];
    if([self excuteQuery:queryChar isExcutable:YES]){
        return true;
    }
    return false;




}


-(void)ClearDB{
NSString *query=[NSString stringWithFormat:@"delete from Country"];
   char *queryChar=(char*)[query UTF8String];
   [self excuteQuery:queryChar isExcutable:NO];
}

-(BOOL)isempty{
    [self fillCountries];
    if([self.Countries count] > 0 ){
        return false;
    }
    return true;
}

-(void)fillCountries{
    NSString *query=[NSString stringWithFormat:@"select * from Country"];
    
    char *queryChar=(char*)[query UTF8String];
    [self excuteQuery:queryChar isExcutable:NO];


}







-(bool)adddetails:(Country *)country{
    NSString *query=[NSString stringWithFormat:@"update  Country set Details ='"];// city) values ('"];
    query = [query stringByAppendingString:country.details];
    query = [query stringByAppendingString:@"',"];
    query = [query stringByAppendingString:@"city ='"];
    query = [query stringByAppendingString:country.city];
    query = [query stringByAppendingString:@"' where COUNTRY_id = '"];
    query = [query stringByAppendingString:country.Countryid];
 query = [query stringByAppendingString:@"'"];
    char *queryChar=(char*)[query UTF8String];
    if([self excuteQuery:queryChar isExcutable:YES]){
       
        return true;
    }
     NSLog(@"erroeeeeee");//(@"done");
    return false;

}


-(bool)addimg:(Country *)country{
    NSString *query = [NSString stringWithFormat:@"update Country set image = ? where COUNTRY_id = "];
    query = [query stringByAppendingString:country.Countryid];
    
const char * sqlitequery = (char *)[query UTF8String];
    sqlite3 *database;
    sqlite3_stmt * stament;
    BOOL isOpend=sqlite3_open([ self.Documenpath UTF8String], &database);
    if (isOpend == SQLITE_OK)
    {

    if (sqlite3_prepare_v2(database, sqlitequery, -1, &stament, NULL) == SQLITE_OK) {
        sqlite3_bind_blob(stament, 2, [country.imaData bytes], [country.imaData length], SQLITE_TRANSIENT);
        sqlite3_step(stament);
    }
    else{
        NSLog(@"can't save image");
        return false;
    }}
    sqlite3_finalize(stament);
    return true;

}



-(Country *)loadcountry:(Country *)country{
    NSString *query =[NSString stringWithFormat:@"select * from Country where COUNTRY_id ="];
    query = [query stringByAppendingString:country.Countryid];
    const char * sqlitequery = (char *)[query UTF8String];
    sqlite3 *database;
    Country *country2;
    sqlite3_stmt * stament;
    BOOL isOpend=sqlite3_open([ self.Documenpath UTF8String], &database);
   // if (isOpend == SQLITE_OK) {
        if (sqlite3_prepare_v2(database, sqlitequery, -1, &stament, NULL) == SQLITE_OK) {
            if (sqlite3_step(stament) == SQLITE_ROW) {
                char *name=(char*)sqlite3_column_text(stament, 0);
                country2 = [[Country alloc]init];
                [country2 setCountryid:[NSString stringWithFormat:@"%s",name]];
                
                [country2 setCountryName:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(stament, 1)]];
                
                [country2 setLon:sqlite3_column_double(stament, 2)];
                [country2 setLat:sqlite3_column_double(stament, 3)];
                
                [country2 setDetails:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(stament, 4)]];
                int length = sqlite3_column_bytes(stament, 5);
                [country2 setImaData:[NSData dataWithBytes:sqlite3_column_blob(stament, 5) length:length]];
                [country2 setCity:[NSString stringWithFormat:@"%s",(char*)sqlite3_column_text(stament, 6)]];
                
            }
                
                
            }
    
    sqlite3_finalize(stament);
            return country2;
}



    


@end
