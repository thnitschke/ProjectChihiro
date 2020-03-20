//
//  APIResponse.h
//  ProjectChihiro
//
//  Created by Rovane Moura on 20/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "Movie.h"

@interface APIResponse : NSObject

@property NSInteger *page;
@property NSInteger *total_results;
@property NSInteger *total_pages;
@property NSMutableArray<Movie *> *results;

@end
