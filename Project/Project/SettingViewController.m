//
//  SettingViewController.m
//  Project
//
//  Created by PiTechnologies on 5/11/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize mgr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)ClearCash:(id)sender {

    [mgr ClearDB];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	 mgr=[[DataBase alloc]initWithDB:@"CountryDB"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
