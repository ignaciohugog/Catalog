//
//  FetchedResultsControllerDataSourceDelegate.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/31/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

@protocol FetchedResultsControllerDataSourceDelegate

- (void)configureCell:(id)cell withObject:(id)object;
- (void)deleteObject:(id)object;

@end
