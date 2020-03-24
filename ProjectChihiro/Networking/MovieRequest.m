//
//  MovieRequest.m
//  ProjectChihiro
//
//  Created by Rovane Moura on 19/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieRequest.h"
#import "Movie.h"
#import "Parser.h"

@implementation MovieRequest

- (void)fetchPopularMovies:(void (^)(NSArray *))completionHandler {
    
    NSString *plainURL = @"https://api.themoviedb.org/3/movie/popular?api_key=79bb37b9869aa0ed97dc7a23c93d0829&language=en-US&page=1";
    NSURL *url = [NSURL URLWithString:plainURL];
    
    [[NSURLSession.sharedSession
      dataTaskWithURL:url
      completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error){
        NSError *jsonError;
        NSArray *responseJSON = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:NSJSONReadingAllowFragments
                                 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Failed to serialize into JSON: %@", jsonError);
            return;
        }
        
        //            NSLog(@"%@", [((NSDictionary *)responseJSON)[@"results"] objectAtIndex:0][@"title"] );
        
        NSMutableArray *dicts = ((NSDictionary*) responseJSON)[@"results"];
        NSMutableArray *movies = @[].mutableCopy;
        Parser *parser = [[Parser alloc] init];
        
        for (NSDictionary *dict in dicts) {
            Movie *movie = [parser parse:dict];
            [movies addObject:movie];
        }
        
        completionHandler(movies);
    }
      ] resume];
    
    
}


- (void)fetchNowPlayingMovies:(void (^)(NSArray *))completionHandler {
    
    NSString *plainURL = @"https://api.themoviedb.org/3/movie/now_playing?api_key=79bb37b9869aa0ed97dc7a23c93d0829&language=en-US&page=1";
    NSURL *url = [NSURL URLWithString:plainURL];
    
    [[NSURLSession.sharedSession
      dataTaskWithURL:url
      completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error){
        NSError *jsonError;
        NSArray *responseJSON = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:NSJSONReadingAllowFragments
                                 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Failed to serialize into JSON: %@", jsonError);
            return;
        }
        
        NSMutableArray *dicts = ((NSDictionary*) responseJSON)[@"results"];
        NSMutableArray *movies = @[].mutableCopy;
        Parser *parser = [[Parser alloc] init];
        
        for (NSDictionary *dict in dicts) {
            Movie *movie = [parser parse:dict];
            [movies addObject:movie];
        }
        
        completionHandler(movies);
    }
      ] resume];
    
}


- (void)fetchMoviePosterImage:(NSString *)path callback:(void (^)(NSData *))completionHandler {
    
    NSString *baseImageURL = @"https://image.tmdb.org/t/p/w500";
    NSURL *url = [NSURL URLWithString:[baseImageURL stringByAppendingString:path]];
    
    [[NSURLSession.sharedSession
      dataTaskWithURL:url
      completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error){
        
        if (error) {
            NSLog(@"Failed to fetch image. Error: %@", error);
            return;
        }
        
        completionHandler(data);
    }
      ] resume];
}

@end
