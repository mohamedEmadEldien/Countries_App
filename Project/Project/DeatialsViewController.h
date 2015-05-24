//
//  DeatialsViewController.h
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import "ViewController.h"
//#import <MobileCoreServices/MobileCoreServices.h>
#import "Country.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "MapViewController.h"

@interface DeatialsViewController : ViewController <CLLocationManagerDelegate , NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UILabel *LDistance;
@property (strong, nonatomic) IBOutlet UIImageView *Image;
@property Country* country;
@property NSString* details;
@property NSString * img;
@property NSString * city;
@property (strong , nonatomic)CLLocation * currentlocation;
@property (strong , nonatomic)CLLocationManager * locationmanger;
@property (strong, nonatomic) IBOutlet UILabel *LCity;
@property (strong, nonatomic) IBOutlet UITextView *Ldetails;

@property DataBase* mgr;
@property bool isconection1;

@end
