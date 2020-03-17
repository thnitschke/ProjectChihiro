//
//  ViewController.h
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 16/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieDetailViewController;

@interface TableViewController : UITableViewController

@property (strong, nonatomic) MovieDetailViewController *detailViewController;

@end

