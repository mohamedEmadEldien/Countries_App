//
//  ViewController.h
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import "DataBase.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDataSource , NSURLConnectionDataDelegate>
@property NSMutableArray * countries;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property NSURLRequest * request;
@property NSMutableData *JsonData;





@end
