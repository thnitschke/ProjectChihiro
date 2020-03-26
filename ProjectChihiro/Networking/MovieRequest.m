//
//  MovieRequest.m
//  ProjectChihiro
//
//  Created by Rovane Moura on 19/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "MovieRequest.h"
#import "Parser.h"

@implementation MovieRequest

NSString *baseURL = @"https://api.themoviedb.org/3/";
NSString *apiKey = @"79bb37b9869aa0ed97dc7a23c93d0829";
NSString *language = @"en-US";

+ (void)fetchPopularMovies:(void (^)(NSArray *))completionHandler {
    
    NSString *popularMoviesURL = @"movie/popular";
    NSString *plainURL = [baseURL stringByAppendingFormat:@"%@?api_key=%@&language=%@&page=%d",
                          popularMoviesURL,
                          apiKey,
                          language,
                          1];
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
        
        for (NSDictionary *dict in dicts) {
            Movie *movie = [Parser parseMovieWithDict:dict];
            [movies addObject:movie];
        }
        
        completionHandler(movies);
    }
      ] resume];
    
    
}


+ (void)fetchNowPlayingMovies:(void (^)(NSArray *))completionHandler {
    
    NSString *nowPlayingURL = @"movie/now_playing";
    NSString *plainURL = [baseURL stringByAppendingFormat:@"%@?api_key=%@&language=%@&page=%d",
                          nowPlayingURL,
                          apiKey,
                          language,
                          1];
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
        
        for (NSDictionary *dict in dicts) {
            Movie *movie = [Parser parseMovieWithDict:dict];
            [movies addObject:movie];
        }
        
        completionHandler(movies);
    }
      ] resume];
    
}

+ (void)fetchSearchResults:(NSString *)query callback:(void (^)(NSArray *))completionHandler {
    
    NSString *searchMovieURL = @"search/movie";
    NSString *plainURL = [baseURL stringByAppendingFormat:@"%@?api_key=%@&query=%@&language=%@&page=%d",
                          searchMovieURL,
                          apiKey,
                          query,
                          language,
                          1];
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
        
        for (NSDictionary *dict in dicts) {
            Movie *movie = [Parser parseMovieWithDict:dict];
            [movies addObject:movie];
        }
        
        completionHandler(movies);
    }
      ] resume];
    
}

+ (void)fetchMoviePosterImage:(NSString *)path callback:(void (^)(NSData *))completionHandler {
    if (path == nil)
        return;
    
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

+ (void)fetchMovieGenres:(void (^)(NSDictionary *))completionHandler {
    
    NSString *movieGenresURL = @"genre/movie/list";
    NSString *plainURL = [baseURL stringByAppendingFormat:@"%@?api_key=%@&language=%@&page=%d",
                          movieGenresURL,
                          apiKey,
                          language,
                          1];
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
        
        NSArray *genreArray = ((NSDictionary*) responseJSON)[@"genres"];
        NSMutableDictionary *genreDict = [[NSMutableDictionary alloc] init];
        for (NSDictionary *item in genreArray) {
            [genreDict setObject:[item valueForKey:@"name"] forKey:[item valueForKey:@"id"]];
        }
        
        completionHandler(genreDict);
    }
      ] resume];
    
}

@end
