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

typedef enum MovieSection : NSUInteger { PopularMovies, NowPlaying } MovieSection;

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating> {
    
    NSArray<Movie *> *popularMovies;
    NSArray<Movie *> *nowPlayingMovies;
    NSDictionary *globalGenres;

    UISearchController *searchController;
    NSNumberFormatter *formatter;
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
    
    [MovieRequest fetchPopularMovies:^(NSArray *array){
        self->popularMovies = array;
        dispatch_async(dispatch_get_main_queue(), ^{ [self.tableView reloadData]; });
    }];
    [MovieRequest fetchNowPlayingMovies:^(NSArray *array){
        self->nowPlayingMovies = array;
        dispatch_async(dispatch_get_main_queue(), ^{ [self.tableView reloadData]; });
    }];
    [MovieRequest fetchMovieGenres:^(NSDictionary *genres) {
        self->globalGenres = genres;
    }];
    
    formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundHalfEven];
}

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case PopularMovies: return @"Popular";
        default: return @"Now Playing";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *) [tableView dequeueReusableCellWithIdentifier: @"movieCell"];

    Movie *currentMovie;
    
    switch (indexPath.section) {
        case PopularMovies: currentMovie = [popularMovies objectAtIndex:indexPath.row]; break;
        case NowPlaying: currentMovie = [nowPlayingMovies objectAtIndex:indexPath.row]; break;
        default: return cell;
    }
    
    cell.movieTitle.text = currentMovie.title;
    cell.movieRate.text = [formatter stringFromNumber:currentMovie.rating];
    cell.movieDescription.text = currentMovie.overview;
    [cell.activityIndicator startAnimating];
    
    if (currentMovie.posterPath == nil) {
        [cell.activityIndicator stopAnimating];
        [cell.noImage setHidden:NO];
    } else {
        BOOL cellIsVisible = [[self.tableView indexPathsForVisibleRows] indexOfObject:indexPath] != NSNotFound;
        if (cellIsVisible) {
            [MovieRequest fetchMoviePosterImage:currentMovie.posterPath callback:^(NSData *data) {
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
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MovieDetailViewController *controller = (MovieDetailViewController *)[segue destinationViewController];
        controller.detailItem = indexPath.section == PopularMovies ? [popularMovies objectAtIndex:indexPath.row] : [nowPlayingMovies objectAtIndex:indexPath.row];
        [controller.detailItem genresFromIds:self->globalGenres];
    }
}

@end
