//
//  Parser.h
//  ProjectChihiro
//
//  Created by Rovane Moura on 23/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface Parser : NSObject

- (Movie *)parse:(NSDictionary *)dict;

@end
