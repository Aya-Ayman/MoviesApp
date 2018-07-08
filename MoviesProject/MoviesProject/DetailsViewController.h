//
//  DetailsViewController.h
//  MoviesProject
//
//  Created by ahme on 5/16/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *favourite;
- (IBAction)favouriteBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *trailers;
@property (weak, nonatomic) IBOutlet UIButton *reviews;

@property Movie *movie;
@property (weak, nonatomic) IBOutlet UILabel *detailsTitle;

@property (weak, nonatomic) IBOutlet UILabel *detailsVote;

@property (weak, nonatomic) IBOutlet UILabel *detailsYear;

@property (weak, nonatomic) IBOutlet UIImageView *detailsPoster;

@property (weak, nonatomic) IBOutlet UITextView *detailsOverview;
- (IBAction)navigateToTrailer:(id)sender;

- (IBAction)navigateToReview:(id)sender;



@end
