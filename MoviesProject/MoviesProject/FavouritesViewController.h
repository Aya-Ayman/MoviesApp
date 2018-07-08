//
//  FavouritesViewController.h
//  MoviesProject
//
//  Created by ahme on 5/17/18.
//  Copyright © 2018 aya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavouritesViewController : UICollectionViewController

@property NSMutableArray *moviesList;
@property (strong, nonatomic) IBOutlet UICollectionView *favouriteCollection;

@end
