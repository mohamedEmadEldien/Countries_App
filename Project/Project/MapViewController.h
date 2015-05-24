//
//  MapViewController.h
//  Project
//
//  Created by PiTechnologies on 5/12/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import "ViewController.h"
#import "Country.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : ViewController< MKMapViewDelegate,CLLocationManagerDelegate>
@property Country * country;
@property (strong, nonatomic) IBOutlet MKMapView *Mapview;

@end
