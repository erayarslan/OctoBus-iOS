//
//  BusListViewController.m
//  octobus-alpha
//
//  Created by Ömer Hakan Bilici on 14.02.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "BusListViewController.h"
#import "BusDetailCell.h"
#import "Bus.h"
#define BUS_URL @"http://8cook.in/sapi/line/"

@interface BusListViewController ()

@end

@implementation BusListViewController

@synthesize selectedLineName;
@synthesize busList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = selectedLineName;
    
    
    self.busList=[self getBusListFromSAPI];
    
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSMutableArray*) getBusListFromSAPI{
    
    NSMutableArray* mutableBusList=[[NSMutableArray alloc]init];
    
    NSString *url = [NSString
                     stringWithFormat:BUS_URL"%@",[self selectedLineName]];
    
    // Async
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil && [data length]>0) {
            NSLog(@"Response code: %d", [(NSHTTPURLResponse*)response statusCode]);
            NSError *error;
            NSMutableDictionary *busDictionary = [NSJSONSerialization
                                                  JSONObjectWithData:data
                                                  options:NSJSONReadingMutableContainers
                                                  error:&error];
            
            NSArray* busTmpArray = busDictionary[@"busList"];
            
            
            for (NSDictionary *theBus in busTmpArray)
            {
                Bus *bus=[[Bus alloc]init];
                [bus setBusId:theBus[@"id"]];
                Coordinate *coor = [[Coordinate alloc]init]; //theBus[@"coordinate"];
                coor.latitude = [theBus valueForKeyPath:@"coordinate.latitude"];
                coor.longitude = [theBus valueForKeyPath:@"coordinate.longitude"];
                [bus setBusCoordinate:coor];
                [mutableBusList addObject:bus];
            }
            [self.tableView reloadData];
            
        }
        else{
            NSLog(@"Error code: %d", [connectionError code]);
        }
        
    }];
    
    return mutableBusList;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.busList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BusCell";
    BusDetailCell *busCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Bus *bus = [self.busList objectAtIndex:indexPath.row];
    
    [busCell.lblDistance setText: bus.busId];
    Coordinate *coordinate = bus.busCoordinate;
    [busCell.lblBusLocation setText: [NSString stringWithFormat:@"%@, %@", coordinate.latitude, coordinate.longitude]];
    /*
     for (Bus* bus in self.busList) {
     
     [busCell.lblDistance setText: [self.busList[indexPath.row] busId]];
     
     Coordinate *coordinate = [self.busList[indexPath.row] busCoordinate];
     NSLog(@"%@", coordinate.latitude);
     //[busCell.lblBusLocation setText: coordinate.latitude];
     
     }
     */
    return busCell;
}

// Initial line.
@end
