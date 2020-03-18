//
//  TableViewCell.h
//  ProjectChihiro
//
//  Created by Rovane Moura on 17/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *movieTitle;
@property (nonatomic, weak) IBOutlet UILabel *movieDescription;
@property (nonatomic, weak) IBOutlet UILabel *movieRate;

@property (nonatomic, weak) IBOutlet UIImageView *moviePoster;


@end

NS_ASSUME_NONNULL_END
