//
//  ViewController.m
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 16/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "TableViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "MovieDetailViewController.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource> {
    Movie *movie;

    UISearchController *searchController;
}
@end

@implementation TableViewController

//@synthesize movie = _movie;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    movie = Movie.new;
    movie.title = @"Hell, O World!";
    movie.rating = @"4.2";
    movie.overview = @"welp";
//    movie.image = [NSData init];
    
//    movies = [NSMutableArray init];

    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.placeholder = @"Search";
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationItem.searchController = searchController;
    self.definesPresentationContext = YES;
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return movies.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *) [tableView dequeueReusableCellWithIdentifier: @"movieCell"];

    NSLog(@"%@", movie.title);
    cell.movieTitle.text = movie.title;
    cell.movieRate.text = movie.rating;
    cell.movieDescription.text = movie.overview;
    
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
