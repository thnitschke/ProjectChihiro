//
//  MovieDetailViewController.h
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 17/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController

@property (strong, nonatomic) Movie *detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *genres;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStars;
@property (weak, nonatomic) IBOutlet UILabel *overviewText;

@end
