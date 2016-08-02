//
//  FetchedResultsTableDataSource.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/31/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchedResultsDataSource.h"

@class NSFetchedResultsController;
@interface FetchedResultsTableDataSource : FetchedResultsDataSource <UITableViewDataSource>

- (id)initWithTableView:(UITableView*)tableView;

@end
