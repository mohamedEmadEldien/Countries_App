//
//  SettingViewController.h
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import "ViewController.h"
#import "DataBase.h"
@interface SettingViewController : ViewController
@property DataBase* mgr;
@property NSURLRequest * request;
@property NSMutableData *JsonData;
@end
