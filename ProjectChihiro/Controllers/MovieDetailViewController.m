//
//  MovieDetailViewController.m
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 17/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController () {
    NSDictionary *partialGenres;
}
@end

@implementation MovieDetailViewController

@synthesize detailItem = _detailItem;
@synthesize image = _image;
@synthesize movieTitle = _movieTitle;
@synthesize genres = _genres;
@synthesize numberOfStars = _numberOfStars;
@synthesize overviewText = _overviewText;

- (void)configureView {
    // Update the user interface for the detail item.
    
    _image.image = [UIImage imageWithData: _detailItem.image];
    _image.layer.cornerRadius = 10.0;
    _movieTitle.text = _detailItem.title;
    _genres.text = [_detailItem.genreIds componentsJoinedByString:@", "];
    _numberOfStars.text = _detailItem.rating.stringValue;
    _overviewText.text = _detailItem.overview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    
    self.navigationItem.backBarButtonItem.title = @"";
}

@end
