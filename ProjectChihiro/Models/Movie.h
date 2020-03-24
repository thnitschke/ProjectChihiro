//
//  Movie.h
//  ProjectChihiro
//
//  Created by Rovane Moura on 19/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *rating;
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSString *posterPath;
@property (strong, nonatomic) NSData *image;
@property (strong, nonatomic) NSArray<NSNumber *> *genreIds;

@end
