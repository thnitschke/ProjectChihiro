//
//  TableViewCell.m
//  ProjectChihiro
//
//  Created by Rovane Moura on 17/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

@synthesize movieRate = _movieRate;
@synthesize movieTitle = _movieTitle;
@synthesize moviePoster = _moviePoster;
@synthesize movieDescription = _movieDescription;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
