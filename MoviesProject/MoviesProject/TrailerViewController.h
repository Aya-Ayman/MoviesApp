//
//  TrailerViewController.h
//  MoviesProject
//
//  Created by ahme on 5/16/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@interface TrailerViewController : UITableViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

{
    NSString* trailerURL;
    NSMutableArray* trailerArray;
    NSMutableArray* trailerName;
}

@property Movie *myMovie;
@property NSMutableData *moviesTrailer;
@property NSMutableData *moviesResult;

@end
