//
//  TableViewCell.m
//  ProjectChihiro
//
//  Created by Rovane Moura on 17/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

@synthesize movieTitle = _movieTitle;
@synthesize moviePoster = _moviePoster;
@synthesize movieDescription = _movieDescription;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
