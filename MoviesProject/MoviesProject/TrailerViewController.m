//
//  TrailerViewController.m
//  MoviesProject
//
//  Created by ahme on 5/16/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import "TrailerViewController.h"

@implementation TrailerViewController


-(void)viewDidLoad{
    
    
    _moviesTrailer=[NSMutableData data];
    _moviesResult=[NSMutableData data];
    trailerArray=[NSMutableArray new];
    trailerName=[NSMutableArray new];

    
    NSString *urlString=@"http://api.themoviedb.org/3/movie/";
    
    NSString* TrailerURL=[urlString stringByAppendingFormat:@"%@",_myMovie.movie_id];
    NSString* TrailerURL2=[TrailerURL stringByAppendingString:@"?api_key=3928533fdaf13e3ea57c0ccb6b78eb33&append_to_response=videos"];
    
    NSURL *url=[NSURL URLWithString:TrailerURL2];
    NSURLRequest *req2=[NSURLRequest requestWithURL:url];
    NSURLConnection *connection2=[[NSURLConnection alloc]initWithRequest:req2 delegate:self];
    [connection2 start];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.moviesTrailer appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSError *myError = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:self.moviesTrailer options:NSJSONReadingMutableLeaves error:&myError];
    
    
    id video = [result objectForKey:@"videos"];
    id result2 = [video objectForKey:@"results"];
   
    NSMutableArray* resArray=[NSMutableArray new];
    resArray=result2;
   
    
    for(int i=0;i<resArray.count;i++)
    {
        id value=[result2 objectAtIndex:i];
        id key=[value objectForKey:@"key"];
        id name=[value objectForKey:@"name"];
        [trailerArray addObject:key];
         [trailerName addObject:name];

        
        NSLog(@"%@",key);
        
    }
    
    [self.tableView reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([trailerArray count]>0)
    {
        return [trailerArray count];
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"TrailerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if([trailerArray count]==0)
    {
        cell.textLabel.text=@"No videos";
    }
    else{
    cell.textLabel.text=trailerName[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"play.png"];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString * baseURL=@"https://www.youtube.com/watch?v=";
    NSString* TrailerURL=[baseURL stringByAppendingFormat:@"%@",trailerArray[indexPath.row]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TrailerURL]];
}

@end
