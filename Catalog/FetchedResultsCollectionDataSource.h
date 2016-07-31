//
//  FetchedResultsCollectionDataSource.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/31/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "FetchedResultsControllerDataSourceDelegate.h"

@class NSFetchedResultsController;

@interface FetchedResultsCollectionDataSource : NSObject <UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, weak) id<FetchedResultsControllerDataSourceDelegate> delegate;
@property (nonatomic, copy) NSString* reuseIdentifier;
@property (nonatomic) BOOL paused;

- (id)initWithTableView:(UICollectionView*)collectionView;
- (id)objectAtIndexPath:(NSIndexPath*)indexPath;
- (id)selectedItem;

@end
