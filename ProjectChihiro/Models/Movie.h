//
//  Movie.h
//  ProjectChihiro
//
//  Created by Rovane Moura on 19/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonnull, strong, nonatomic) NSString *title;
@property (nonnull, strong, nonatomic) NSNumber *rating;
@property (nonnull, strong, nonatomic) NSString *overview;
@property (nullable ,strong, nonatomic) NSString *posterPath;
@property (nullable, strong, nonatomic) NSData *image;
@property (nonnull, strong, nonatomic) NSArray<NSNumber *> *genreIds;
@property (nullable, strong, nonatomic) NSString *genres;

- (void)genresFromIds:(NSDictionary *_Nonnull)genresDict;

@end
