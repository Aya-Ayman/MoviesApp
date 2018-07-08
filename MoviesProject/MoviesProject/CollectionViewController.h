//
//  CollectionViewController.h
//  MoviesProject
//
//  Created by ahme on 5/16/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *myCollection;

@property NSMutableArray *moviesList;
@property NSMutableData *movies;
@property NSString *baseImageUrl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControll;

- (IBAction)sort:(id)sender;

@end
