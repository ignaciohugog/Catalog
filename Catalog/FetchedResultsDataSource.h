//
//  FetchedResultsDataSource.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 8/1/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FetchedResultsControllerDataSourceDelegate.h"

@interface FetchedResultsDataSource : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, weak) id<FetchedResultsControllerDataSourceDelegate> delegate;
@property (nonatomic, copy) NSString* reuseIdentifier;

- (NSInteger)rowsInSection:(NSInteger)sectionIndex;
- (id)objectAtIndexPath:(NSIndexPath*)indexPath;
- (id)selectedItem;

@end
