//
//  ViewController.m
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 16/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

struct Movie {
    NSString *title;
    NSString *rating;
    NSString *description;
    NSData *image;
};

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *movies;
    struct Movie movie;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    movie.title = @"Hell, O World!";
    movie.rating = @"4.2";
    movie.description = @"welp";
//    movie.image = [NSData init];
    
//    movies = [NSMutableArray init];
}

#pragma MARK - UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return movies.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell *) [tableView dequeueReusableCellWithIdentifier: @"movieCell"];

    cell.movieTitle.text = movie.title;
    cell.movieRate.text = movie.rating;
    cell.movieDescription.text = movie.description;
    
    return cell;
}

@end

