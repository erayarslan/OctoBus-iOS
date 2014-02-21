//
//  BusDetailCell.h
//  octobus-alpha
//
//  Created by Ömer Hakan Bilici on 14.02.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblBusLocation;

@end
