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

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource> {
    Movie *movie;
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
}

#pragma MARK - UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return movies.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *) [tableView dequeueReusableCellWithIdentifier: @"movieCell"];

    NSLog(movie.title);
    cell.movieTitle.text = movie.title;
    cell.movieRate.text = movie.rating;
    cell.movieDescription.text = movie.overview;
    
    return cell;
}

@end

