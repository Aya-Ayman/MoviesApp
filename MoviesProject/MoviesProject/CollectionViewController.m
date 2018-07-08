//
//  CollectionViewController.m
//  MoviesProject
//
//  Created by ahme on 5/16/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import "CollectionViewController.h"
#import "Movie.h"
#import "DetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DBManager.h"

@interface CollectionViewController (){
   NSMutableArray * DBMovies;
    Movie *myMovie;
   DBManager * DBObject1;
}
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _movies=[NSMutableData data];
    _moviesList=[NSMutableArray new];
    DBObject1=[DBManager getInstance];
    [DBObject1 initDB];
    DBMovies=[DBObject1 loadData];
    

    NSString *urlString=@"http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=3928533fdaf13e3ea57c0ccb6b78eb33";
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:req delegate:self];
    [connection start];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.movies appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSError *myError = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:self.movies options:NSJSONReadingMutableLeaves error:&myError];
    
    
    NSMutableArray* res = [result objectForKey:@"results"];
    
    for(int i=0;i<res.count;i++)
    {
        id value=[res objectAtIndex:i];
        myMovie=[Movie new];
        id poster=[value objectForKey:@"poster_path"];
        id title=[value objectForKey:@"title"];
        id vote=[value objectForKey:@"vote_average"];
        id overview=[value objectForKey:@"overview"];
        id movie_id=[value objectForKey:@"id"];
        id date=[value objectForKey:@"release_date"];
        id popularity=[value objectForKey:@"popularity"];
        
        NSLog(@"%@",poster);
        NSLog(@"%@",title);
        NSLog(@"voteeee %@",vote);
        NSLog(@"%@",movie_id);
        NSLog(@"%@",date);
        NSLog(@"popularity %@",popularity);
     
        myMovie.title=title;
        myMovie.vote_average=vote;
        myMovie.release_date=date;
        myMovie.overview=overview;
        myMovie.poster_path=poster;
        myMovie.movie_id=movie_id;
        myMovie.popularity=popularity;
        [_moviesList addObject:myMovie];
        
        if([DBMovies count]==0)
        {
        
        [DBObject1 addMovie:myMovie];
        }
       
    }
    
    if([_moviesList count] ==0)
    {
        _moviesList=DBMovies;
    }
    [_myCollection reloadData];
    
}


-(IBAction)sort:(id)sender{
    if (self.segmentControll.selectedSegmentIndex==0)
    {
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc]initWithKey:@"popularity" ascending:NO];
        NSArray * sortedMovies=[_moviesList sortedArrayUsingDescriptors:@[descriptor]];
        _moviesList=[NSMutableArray new];
        _moviesList=(NSMutableArray*)sortedMovies;
        [self.myCollection reloadData];
        
    }
    if(self.segmentControll.selectedSegmentIndex==1)
    {
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc]initWithKey:@"vote_average" ascending:NO];
        NSArray * sortedMovies=[_moviesList sortedArrayUsingDescriptors:@[descriptor]];
        _moviesList=[NSMutableArray new];
        _moviesList=(NSMutableArray*)sortedMovies;
        [self.myCollection reloadData];
        
    }
    
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
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *posterImage=(UIImageView*)[cell viewWithTag:1];
    _baseImageUrl=@"http://image.tmdb.org/t/p/w185/";
    Movie * movie=[Movie new];
    movie=_moviesList[indexPath.row];
    NSString* posterURL=[self.baseImageUrl stringByAppendingString:movie.poster_path ];
    [posterImage sd_setImageWithURL:[NSURL URLWithString:posterURL]];
    return cell;
}



#pragma mark <UICollectionViewDelegate>


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *details=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsVC"];
    myMovie=[_moviesList objectAtIndex:indexPath.row ];
    [details setMovie:myMovie];
    [self.navigationController pushViewController:details animated:YES];
}


@end
