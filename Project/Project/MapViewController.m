//
//  MapViewController.m
//  Project
//
//  Created by PiTechnologies on 5/12/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize country;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = country.countryName ;
    MKPointAnnotation *city = [MKPointAnnotation new];
    
    [city setCoordinate:CLLocationCoordinate2DMake(country.lat , country.lon)];
    //NSLog(@"longtitude %f \n",city.coordinate);
    //[city setTitle:self.cityname];
    [self.Mapview addAnnotation:city];
    
    
    [self.Mapview setCenterCoordinate:CLLocationCoordinate2DMake(country.lon, country.lat)];
    

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
