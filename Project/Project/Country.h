//
//  Country.h
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject
@property NSString *Countryid;
@property NSString *countryName;
@property double lon;
@property double lat;
@property NSString* city;

@property NSString * details;
@property NSData *imaData;

@end
