//
//  FetchedResultsControllerDataSource.h
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
@interface FetchedResultsTableDataSource : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, weak) id<FetchedResultsControllerDataSourceDelegate> delegate;
@property (nonatomic, copy) NSString* reuseIdentifier;
@property (nonatomic) BOOL paused;

- (id)initWithTableView:(UITableView*)tableView;
- (id)objectAtIndexPath:(NSIndexPath*)indexPath;
- (id)selectedItem;

@end
