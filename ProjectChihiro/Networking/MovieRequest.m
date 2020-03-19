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

@implementation MovieRequest

- (NSString *)getDatafrom:(NSString *)dataURL {
    
    __block NSString *result;
    
    NSURL *url = [NSURL URLWithString:dataURL];
    
    NSURLSessionDataTask *downloadTask =
        [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:
         ^(NSData *data, NSURLResponse *response, NSError *error){
            result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSError *jsonError;
            NSArray *moviesJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError) {
                NSLog(@"Failed to serialize into JSON: %@", jsonError);
                return;
            }
            
            NSMutableArray *movies = NSMutableArray.new;
            for (NSDictionary *movieDict in moviesJSON) {
                NSString *title = movieDict[@"title"];
                
            }
        }];
    
    [downloadTask resume];
    
    return result;
}



@end
