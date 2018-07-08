//
//  ReviewViewContoller.m
//  MoviesProject
//
//  Created by ahme on 5/16/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import "ReviewViewContoller.h"

@implementation ReviewViewContoller

-(void)viewDidLoad{
    
    _moviesReview=[NSMutableData data];
    _moviesResult=[NSMutableData data];
    reviewAuthor=[NSMutableArray new];
    reviewURL=[NSMutableArray new];
   
    
    NSString *urlString=@"http://api.themoviedb.org/3/movie/";
    NSString* TrailerURL=[urlString stringByAppendingFormat:@"%@",_myMovie.movie_id];
    NSString* TrailerURL2=[TrailerURL stringByAppendingString:@"?api_key=3928533fdaf13e3ea57c0ccb6b78eb33&append_to_response=reviews"];
    
    NSURL *url=[NSURL URLWithString:TrailerURL2];
    NSURLRequest *req2=[NSURLRequest requestWithURL:url];
    NSURLConnection *connection2=[[NSURLConnection alloc]initWithRequest:req2 delegate:self];
    [connection2 start];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.moviesReview appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSError *myError = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:self.moviesReview options:NSJSONReadingMutableLeaves error:&myError];
    
    
    id review = [result objectForKey:@"reviews"];
    id result2 = [review objectForKey:@"results"];
    
    NSMutableArray* resArray=[NSMutableArray new];
    resArray=result2;
    
    for(int i=0;i<resArray.count;i++)
    {
        id value=[result2 objectAtIndex:i];
        id author=[value objectForKey:@"author"];
        id url=[value objectForKey:@"url"];
        [reviewAuthor addObject:author];
       [reviewURL addObject:url];
    }
    
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([reviewAuthor count]>0)
    {
    return [reviewAuthor count];
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ReviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if([reviewAuthor count]==0)
    {
    cell.textLabel.text=@"No reviews";
    }
    else{
    cell.textLabel.text=reviewAuthor[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:@"review.png"];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL[indexPath.row]]];

    
}


@end
