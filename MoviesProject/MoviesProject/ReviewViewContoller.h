//
//  ReviewViewContoller.h
//  MoviesProject
//
//  Created by ahme on 5/16/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface ReviewViewContoller : UITableViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

{

    NSMutableArray* reviewAuthor;
     NSMutableArray* reviewURL;
}
@property Movie *myMovie;
@property NSMutableData *moviesReview;
@property NSMutableData *moviesResult;

@end
