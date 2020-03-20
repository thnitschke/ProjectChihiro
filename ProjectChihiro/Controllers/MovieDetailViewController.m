//
//  MovieDetailViewController.m
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 17/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController () {
    
    NSString *movieTitleT;
    NSString *genresT;
    NSNumber *numberOfStarsT;
    NSString *overviewTextT;

}

@end

@implementation MovieDetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = self.detailItem.timestamp.description;
//    }
    movieTitleT = @"The Lion King";
    genresT = @"Adventure, Animation, Family, Drama, Action";
    numberOfStarsT = [[NSNumber alloc] initWithFloat:7.1];
    overviewTextT = @"Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. \n\nWith help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother—and former heir to the throne—has plans of his own. \n\nThe battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his. \n\nSimba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.";
    
    self.movieTitle.text = movieTitleT;
    self.genres.text = genresT;
    self.numberOfStars.text = numberOfStarsT.stringValue;
    self.overviewText.text = overviewTextT;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    
    self.navigationItem.backBarButtonItem.title = @"";
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSObject *)newDetailItem {
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        
//        // Update the view.
//        [self configureView];
//    }
}


@end
