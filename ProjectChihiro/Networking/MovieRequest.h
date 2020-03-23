//
//  MovieRequest.h
//  ProjectChihiro
//
//  Created by Rovane Moura on 19/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieRequest : NSObject

- (void)fetchPopularMovies:(void (^)(NSArray *))completionHandler;
- (void)fetchNowPlayingMovies:(void (^)(NSArray *))completionHandler;

@end

