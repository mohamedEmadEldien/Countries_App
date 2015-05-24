//
//  ViewController.m
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"
#import "DeatialsViewController.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)createTable
{
    
    DataBase* mgr=[[DataBase alloc]initWithDB:@"CountryDB"];
    
    [mgr fillCountries ];

    self.countries = [[NSMutableArray alloc]init];
    if(![mgr isempty]){
        self.countries = mgr.Countries ;
        
    }
    
    
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	

     DataBase* mgr=[[DataBase alloc]initWithDB:@"CountryDB"];
  
   
    mgr=[[DataBase alloc]initWithDB:@"CountryDB"];
    
    ///////////////
    NSString *query=[NSString stringWithFormat:@"create table  if not exists Country(COUNTRY_id varchar(255), name varchar(255) , lon double, lat double , Details varchar(1024) , image blob , city varchar(255), primary key (COUNTRY_id))"];//( COUNTRY_id varchar(255), name varchar(255) , lon double, lat double, Details varchar(1024) , image blob , city varchar(255), primary key id)"];
    
    char *queryChar=(char*)[query UTF8String];
    [mgr excuteQuery:queryChar isExcutable:NO];
    //////////////////
    
    //[mgr fillCountries];
    self.countries = [[NSMutableArray alloc]init];
    if(![mgr isempty]){
         self.countries = [[NSMutableArray alloc]init];
    self.countries = mgr.Countries ;
    
    }
    else{
        NSURL *url = [[NSURL alloc]initWithString:@"http://demo.pitechnologies.net/ITO_IOS/getcountries.php"];
        
        self.request = [[NSURLRequest alloc]initWithURL:url  ];
        
        NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:self.request delegate:self];
        
        [connection start];

    
    
    }

    
    
}




-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.JsonData = [[NSMutableData alloc]init];
    self.countries = [[NSMutableArray alloc]init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.JsonData appendData:data];
    
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:self.JsonData options:Nil error:nil];
    NSMutableDictionary *dictionary;
    
 
    Country *country;
     dictionary = [NSDictionary new];
    for(int i=0;i<array.count;i++){
        country=[[Country alloc]init];
    
        dictionary = [array objectAtIndex:i];
        [country setCountryid:[dictionary objectForKey:@"Countryid"]];
     
        
        [country setCountryName:[dictionary objectForKey:@"Country"]];
        [country setLon:[[dictionary objectForKey:@"Lon"] doubleValue]];
        
        [country setLat:[[dictionary objectForKey:@"Lat"] doubleValue]];
        [self.countries addObject:country];
    }
    
    
    
    
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error.description);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.tableview reloadData];
    DataBase* mgr=[[DataBase alloc]initWithDB:@"CountryDB"];
    mgr=[[DataBase alloc]initWithDB:@"CountryDB"];
    for (int i=0;i < self.countries.count; i++) {
        [mgr addCountry:[self.countries objectAtIndex:i]];
    }
    
    
    
}



//////////////////////////////////////////





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    
    NSString *name = [NSString new];
   
    
    Country *country = [[Country alloc]init];
    country = [self.countries objectAtIndex:indexPath.row];
    
    name = country.countryName;
    cell.textLabel.text= name;
    return cell;
}










-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DeatialsViewController *details = [storyboard instantiateViewControllerWithIdentifier:@"DeatialsViewController"];
    
    [details setCountry:[self.countries objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:details animated:YES];
    
    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.countries.count;
}




- (IBAction)SettingBtn:(id)sender {
    
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingViewController *settingview = [storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
    [self.navigationController pushViewController:settingview animated:YES];

    
    
}


@end
