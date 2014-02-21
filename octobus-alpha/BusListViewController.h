//
//  BusListViewController.h
//  octobus-alpha
//
//  Created by Ömer Hakan Bilici on 14.02.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusListViewController : UITableViewController

@property(nonatomic, strong) NSString *selectedLineName;
@property(nonatomic, strong) NSMutableArray *busList;

@end
