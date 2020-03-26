//
//  MovieDetailViewController.m
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 17/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController () {
    NSNumberFormatter *formatter;
}
@end

@implementation MovieDetailViewController

@synthesize detailItem = _detailItem;
@synthesize image = _image;
@synthesize noImage = _noImage;
@synthesize movieTitle = _movieTitle;
@synthesize genres = _genres;
@synthesize numberOfStars = _numberOfStars;
@synthesize overviewText = _overviewText;

- (void)configureView {
    // Update the user interface for the detail item.
    
    if (_detailItem.image) {
        [_noImage setHidden:YES];
        _image.image = [UIImage imageWithData: _detailItem.image];
    } else {
        [_noImage setHidden:NO];
    }
    _image.layer.cornerRadius = 10.0;
    _movieTitle.text = _detailItem.title;
    _genres.text = _detailItem.genres;
    _numberOfStars.text = [formatter stringFromNumber:_detailItem.rating];
    _overviewText.text = [_detailItem.overview isEqualToString:@""] ? @"No overview provided." : _detailItem.overview;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundHalfEven];
    [self configureView];
    
    self.navigationItem.backBarButtonItem.title = @"";
}

@end
