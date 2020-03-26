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

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating> {
    
    NSArray<Movie *> *popularMovies;
    NSArray<Movie *> *nowPlayingMovies;
    NSDictionary *globalGenres;
    
    NSArray<Movie *> *searchResultMovies;
    UISearchController *searchController;
    NSNumberFormatter *formatter;
    
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchBar.placeholder = @"Search for movies";
    searchController.obscuresBackgroundDuringPresentation = NO;
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationItem.searchController = searchController;
    self.definesPresentationContext = YES;
    self.tableView.sectionHeaderHeight = 35.0;
    
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
    self->searchResultMovies = @[];
    
    formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundHalfEven];
}

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self isFiltering]) {
        return 1;
    }
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self isFiltering]) {
        return [NSString stringWithFormat:@"%lu match%@ found", self->searchResultMovies.count, self->searchResultMovies.count == 1 ? @"" : @"es"];
    }
    switch (section) {
        case PopularMovies: return @"Popular";
        default: return @"Now Playing";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self isFiltering]) {
        return self->searchResultMovies.count;
    }
    switch (section) {
        case PopularMovies: return 2;
        default: return self->nowPlayingMovies.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *) [tableView dequeueReusableCellWithIdentifier: @"movieCell"];
    
    Movie *currentMovie;
    
    if ([self isFiltering]) {
        currentMovie = [self->searchResultMovies objectAtIndex:indexPath.row];
    } else {
        switch (indexPath.section) {
            case PopularMovies: currentMovie = [popularMovies objectAtIndex:indexPath.row]; break;
            case NowPlaying: currentMovie = [nowPlayingMovies objectAtIndex:indexPath.row]; break;
            default: return cell;
        }
    }
    
    cell.movieTitle.text = currentMovie.title;
    cell.movieRate.text = [formatter stringFromNumber:currentMovie.rating];
    cell.movieDescription.text = [currentMovie.overview isEqualToString:@""] ? @"No overview provided." : currentMovie.overview;
    cell.moviePoster.image = nil;
    [cell.activityIndicator startAnimating];
    
    if (currentMovie.posterPath == NSNull.null) {
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
                    [cell.noImage setHidden:YES];
                });
            }];
        }
    }
    
    return cell;
}

#pragma mark - Search Methods

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if ([self isSearchBarEmpty]) {
        return;
    } else {
        [self fetchContentForSearchText:searchController.searchBar.text];
    }
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    [self.tableView reloadData];
}

- (BOOL)isSearchBarEmpty {
    NSString * text = searchController.searchBar.text;
    NSString *searchText = text == nil ? @"": text;
    if ([searchText length] >= 2) {
        return NO;
    } else {
        return YES;
    }
}

- (void)fetchContentForSearchText:(NSString *)searchText {
    NSString *queryString = [searchText stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    [MovieRequest fetchSearchResults:queryString callback:^(NSArray *array) {
        self->searchResultMovies = array;
        dispatch_async(dispatch_get_main_queue(), ^{ [self.tableView reloadData]; });
    }];
}

- (BOOL)isFiltering {
    return searchController.isActive && ![self isSearchBarEmpty];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"movieDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MovieDetailViewController *controller = (MovieDetailViewController *)[segue destinationViewController];
        
        if ([self isFiltering]) {
            controller.detailItem = [self->searchResultMovies objectAtIndex:indexPath.row];
        } else {
            controller.detailItem = indexPath.section == PopularMovies ? [popularMovies  objectAtIndex:indexPath.row] : [nowPlayingMovies objectAtIndex:indexPath.row];
        }
        [controller.detailItem genresFromIds:self->globalGenres];
    }
}

@end
