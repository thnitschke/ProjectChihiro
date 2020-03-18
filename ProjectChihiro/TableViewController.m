//
//  ViewController.m
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 16/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "MovieDetailViewController.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *movieTitles;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    movieTitles = [NSMutableArray arrayWithArray: @[@"a",@"b",@"c"]];
}

#pragma MARK - UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return movieTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell *) [tableView dequeueReusableCellWithIdentifier: @"movieCell"];
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell withMovie:(NSObject *)movie {
//    cell.textLabel.text = event.timestamp.description;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
//    return [sectionInfo numberOfObjects];
    return (NSInteger) 1;
}

@end

