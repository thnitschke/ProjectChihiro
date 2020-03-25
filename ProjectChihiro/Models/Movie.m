//
//  Movie.m
//  ProjectChihiro
//
//  Created by Rovane Moura on 19/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@implementation Movie : NSObject

- (void)genresFromIds:(NSDictionary *)genresDict {
    if (_genres == nil) {
        NSMutableArray<NSString *> *genresArray = @[].mutableCopy;
        
        for (NSNumber *genreId in _genreIds) {
            [genresArray addObject:genresDict[genreId]];
        }
        
        _genres = [genresArray componentsJoinedByString:@", "];
    }
}

@end
