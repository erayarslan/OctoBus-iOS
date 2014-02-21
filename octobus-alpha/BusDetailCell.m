//
//  BusDetailCell.m
//  octobus-alpha
//
//  Created by Ömer Hakan Bilici on 14.02.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "BusDetailCell.h"

@implementation BusDetailCell

@synthesize lblDistance;
@synthesize lblBusLocation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
