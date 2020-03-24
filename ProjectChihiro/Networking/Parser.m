//
//  Parser.m
//  ProjectChihiro
//
//  Created by Rovane Moura on 23/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
#import "Movie.h"

@implementation Parser

- (Movie *)parse:(NSDictionary *)dict {
    Movie *movie = [[Movie alloc] init];
    movie.title = [dict valueForKey:@"title"];
    movie.overview = [dict valueForKey:@"overview"];
    movie.rating = [dict valueForKey:@"vote_average"];
    return movie;
}

//id,
//"vote_average",
//"genre_ids",
//"original_title",
//"backdrop_path",
//adult,
//popularity,
//"poster_path",
//title,
//overview,
//"original_language",
//"vote_count",
//"release_date",
//video

@end
