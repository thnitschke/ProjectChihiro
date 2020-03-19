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

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating> {
    NSMutableArray *movieTitles;
    
    UISearchController *searchController;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    movieTitles = [NSMutableArray arrayWithArray: @[@"a",@"b",@"c"]];
    
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.placeholder = @"Search";
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationItem.searchController = searchController;
    self.definesPresentationContext = YES;
}

#pragma mark - UITableView DataSource Methods
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

#pragma mark - Search Methods

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // TODO
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"movieDetails"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        MovieDetailViewController *controller = (MovieDetailViewController *)[[segue destinationViewController] topViewController];
////        controller.detailItem = object;
//        self.detailViewController = controller;
    }
}

@end
