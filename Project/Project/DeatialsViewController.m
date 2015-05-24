//
//  DeatialsViewController.m
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import "DeatialsViewController.h"

@interface DeatialsViewController ()

@end

@implementation DeatialsViewController
@synthesize country,isconection1,mgr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)ShowMap:(id)sender {

//MapViewController
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *mapview = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    [mapview setCountry:self.country];
    [self.navigationController pushViewController:mapview animated:YES];


}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mgr=[[DataBase alloc]initWithDB:@"CountryDB"];
    
    
    mgr=[[DataBase alloc]initWithDB:@"CountryDB"];

   // Country * savedCountry = [[Country alloc] init];
    
    //savedCountry = [mgr loadcountry:country];
    if(country.city  != nil){
        [self.Ldetails setText:country.details];
        [self.LCity setText:country.city];
        [self.Image setImage:[UIImage imageWithData:country.imaData]];
    
    }
    else{
    
    
    isconection1 = true;
    self.title = self.country.countryName;
    self.locationmanger = [[CLLocationManager alloc]init];
    //self.locationmanger = self;
    self.locationmanger.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationmanger.distanceFilter = kCLDistanceFilterNone;
    [self.locationmanger startUpdatingLocation];
    self.currentlocation = [self.locationmanger location];
    
    CLLocation *citylocation = [[CLLocation alloc]initWithLatitude:self.country.lon longitude:self.country.lat];
    CLLocationDistance meters =[self.currentlocation distanceFromLocation:citylocation];
    
	[self.LDistance setText:[NSString stringWithFormat:@"%g meters",meters] ];
    
    NSString *urlstr = [NSString stringWithFormat:@"http://demo.pitechnologies.net/ITO_IOS/city.php?city_id=%@",self.country.Countryid];
    NSURL *url = [[NSURL alloc]initWithString:urlstr];
    
    self.request = [[NSURLRequest alloc]initWithURL:url  ];
    
    NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:self.request delegate:self];
    
    [connection start];
    ////////////////////////
   
    
    }
    
    
    
}

//////////////////////////////



-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.JsonData = [[NSMutableData alloc]init];
       
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.JsonData appendData:data];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:self.JsonData options:Nil error:nil];
    
    self.details = [dictionary objectForKey:@"holidays"];
    self.city = [dictionary objectForKey:@"city"];
    self.img = [dictionary objectForKey:@"image"];
  
    
    
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error.description);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
  
    [self.Ldetails setText:self.details];
    [self.LCity setText:self.city];
    NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:self.img]];
    
    [self.Image setImage:[UIImage imageWithData:data]];
   // DataBase* mgr=[[DataBase alloc]initWithDB:@"CountryDB"];
    
    
  //  mgr=[[DataBase alloc]initWithDB:@"CountryDB"];

    
    [country setCity:self.city];
    [country setDetails:self.details];
    [country setImaData:data];
    [mgr adddetails:country];
    [mgr addimg:country];
   
    
}






/////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
