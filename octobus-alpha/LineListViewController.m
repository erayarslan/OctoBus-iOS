//
//  LineListViewController.m
//  octobus-alpha
//
//  Created by Ömer Hakan Bilici on 6.02.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "LineListViewController.h"
#import "BusListViewController.h"
#import "Line.h"
#define LINE_URL @"http://8cook.in/sapi/lines"

@implementation LineListViewController

@synthesize lineList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    set tableview background color
    //    UITableView *tableView = (UITableView *)[self.view viewWithTag:8888];
    //    tableView.backgroundColor = [UIColor blueColor];
    
    //assign navigation bar color to 8cookin default color
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.25390625 green:0.61328125 blue:0.22265625 alpha:1.0];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.25390625 green:0.61328125 blue:0.22265625 alpha:1.0];
    }
    
    self.lineList = [self getLinesFromSAPI];
    
}

-(NSMutableArray*) getLinesFromSAPI{
    NSMutableArray* lineMutableArray=[[NSMutableArray alloc]init];
    
    // Async
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:LINE_URL]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil && [data length]>0) {
            NSLog(@"Response code: %d", [(NSHTTPURLResponse*)response statusCode]);
            NSError *error;
            NSArray *lineTmpArray = [NSJSONSerialization
                                                   JSONObjectWithData:data
                                                   options:NSJSONReadingMutableContainers
                                                   error:&error];
            
            for (NSString *theLine in lineTmpArray )
            {
                Line *line=[[Line alloc]init];
                [line setLineName:theLine];
                [lineMutableArray addObject:line];
            }
            [self.tableView reloadData];
            
        }
        else{
            NSLog(@"Error code: %d", [connectionError code]);
        }
        
    }];
    
    return lineMutableArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lineList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self sectorForRow:indexPath.row];
    
    return cell;
}

- (NSString *)sectorForRow:(NSUInteger)row
{
    return [[self.lineList[row] lineName] description];
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.lineList = nil;
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"busSegue"])
    {
        BusListViewController *blvc = [segue destinationViewController];
        
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        Line* selectedLine=[self.lineList objectAtIndex:path.row] ;
        [blvc setSelectedLineName:[selectedLine lineName]];
    }}


@end
