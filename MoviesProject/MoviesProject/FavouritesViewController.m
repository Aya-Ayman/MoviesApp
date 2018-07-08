//
//  FavouritesViewController.m
//  MoviesProject
//
//  Created by ahme on 5/17/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import "FavouritesViewController.h"
#import "Movie.h"
#import "DetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DBManager.h"

@interface FavouritesViewController (){
    
    DBManager * DBObject2;
    Movie* myMovie;
}
@end

@implementation FavouritesViewController
static NSString * const reuseIdentifier = @"FavouriteCell";


- (void)viewDidLoad {
    [super viewDidLoad];

    _moviesList=[NSMutableArray new];
    DBObject2=[DBManager getInstance];
    _moviesList=[DBObject2 getFavouriteMovies];
   [self.favouriteCollection reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    _moviesList=[DBObject2 getFavouriteMovies];
    [self.favouriteCollection reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([_moviesList count]>0)
    {
        return [_moviesList count];
    }
    
    else{
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    UIImageView *posterImage=(UIImageView*)[cell viewWithTag:1];
    if([_moviesList count]>0)
    {
    NSString* baseImageUrl=@"http://image.tmdb.org/t/p/w185/";
    Movie * movie=[Movie new];
    movie=_moviesList[indexPath.row];
    
        
    NSString* posterURL=[baseImageUrl stringByAppendingString:movie.poster_path ];
    
    [posterImage sd_setImageWithURL:[NSURL URLWithString:posterURL]];
    }
    
    else{
    
    [posterImage setImage:[UIImage imageNamed:@"empty.jpg"]];
    
    }
    
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailsViewController *details=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsVC"];
    myMovie=[_moviesList objectAtIndex:indexPath.row ];
    [details setMovie:myMovie];
    [self.navigationController pushViewController:details animated:YES];
}

@end
