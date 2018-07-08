//
//  DetailsViewController.m
//  MoviesProject
//
//  Created by ahme on 5/16/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import "DetailsViewController.h"
#import "TrailerViewController.h"
#import "ReviewViewContoller.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DBManager.h"
@interface DetailsViewController (){
    DBManager *DBObject3;
}
@end

@implementation DetailsViewController


-(void)viewDidLoad

{
    [super viewDidLoad];
    self.trailers.layer.cornerRadius = 10;
    self.trailers.clipsToBounds = true;

    self.reviews.layer.cornerRadius = 10;
    self.reviews.clipsToBounds = true;
    
    DBObject3=[DBManager getInstance];

    NSString *baseImageUrl=@"http://image.tmdb.org/t/p/w185/";
    
    
    NSString* posterURL=[baseImageUrl stringByAppendingString:[_movie poster_path]];
    
    [_detailsPoster sd_setImageWithURL:[NSURL URLWithString:posterURL]];
    
    _detailsOverview.text=_movie.overview;
    
    _detailsTitle.text=_movie.title;
    _detailsYear.text=_movie.release_date;
    
    
    _detailsVote.text=[NSString stringWithFormat:@"%@",_movie.vote_average];
       
    if([_movie.favourite isEqual: @"YES" ])
    {
        [self.favourite setOn:YES];
    }
    
    else{
    [self.favourite setOn:NO];
    }
    
}


- (IBAction)navigateToTrailer:(id)sender {
    Movie * myMovie=[Movie new];
    TrailerViewController *trailer=[self.storyboard instantiateViewControllerWithIdentifier:@"TrailerVC"];
    myMovie=_movie;
    [trailer setMyMovie:myMovie];
    [self.navigationController pushViewController:trailer animated:YES];
}

- (IBAction)navigateToReview:(id)sender {
    
    Movie * myMovie=[Movie new];
    ReviewViewContoller *review=[self.storyboard instantiateViewControllerWithIdentifier:@"ReviewVC"];
    myMovie=_movie;
    [review setMyMovie:myMovie];
    [self.navigationController pushViewController:review animated:YES];
}
- (IBAction)favouriteBtn:(id)sender {
    
    if([self.favourite isOn])
    {
        _movie.favourite=@"YES";
        [DBObject3 updateMovie:_movie];
        NSLog(@"after update");
    }
    else{
        _movie.favourite=@"NO";
        [DBObject3 updateMovie:_movie];
        
    }
}
@end
