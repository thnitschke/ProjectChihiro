//
//  ViewController.m
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 16/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "TableViewController.h"

#import "Movie.h"
#import "MovieCell.h"
#import "MovieRequest.h"
#import "MovieDetailViewController.h"


@interface TableViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating> {
    MovieRequest *request;
    
    NSMutableArray<Movie *> *popularMovies;
    NSMutableArray<Movie *> *nowPlayingMovies;

    UISearchController *searchController;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.placeholder = @"Search";
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationItem.searchController = searchController;
    self.definesPresentationContext = YES;
    
    request = [[MovieRequest alloc] init];
    [request fetchPopularMovies:^(NSArray *array){
        self->popularMovies = [NSMutableArray<Movie *> arrayWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{ [self.tableView reloadData]; });
    }];
    [request fetchNowPlayingMovies:^(NSArray *array){
        self->nowPlayingMovies = [NSMutableArray<Movie *> arrayWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{ [self.tableView reloadData]; });
    }];
}

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0: return @"Popular";
        case 1: return @"Now Playing";
        default: return @"default";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 5;
        case 1: return 5;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *) [tableView dequeueReusableCellWithIdentifier: @"movieCell"];

    Movie *currentMovie;
    
    switch (indexPath.section) {
        case 0: currentMovie = [popularMovies objectAtIndex:indexPath.row]; break;
        case 1: currentMovie = [nowPlayingMovies objectAtIndex:indexPath.row]; break;
        default: return cell;
    }
    
    cell.movieTitle.text = currentMovie.title;
    cell.movieRate.text = currentMovie.rating.stringValue;
    cell.movieDescription.text = currentMovie.overview;
    [cell.activityIndicator startAnimating];
    
    if (currentMovie.posterPath == nil) {
        [cell.activityIndicator stopAnimating];
        [cell.noImage setHidden:NO];
    } else {
        BOOL cellIsVisible = [[self.tableView indexPathsForVisibleRows] indexOfObject:indexPath] != NSNotFound;
        if (cellIsVisible) {
            [request fetchMoviePosterImage:currentMovie.posterPath callback:^(NSData *data) {
                currentMovie.image = data;
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.moviePoster.image = [UIImage imageWithData:data];
                    [cell.activityIndicator stopAnimating];
                });
            }];
        }
    }
    
    return cell;
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
//        controller.detailItem = [movies objectAtIndex:indexPath.row];
//        self.detailViewController = controller;
    }
}

@end
