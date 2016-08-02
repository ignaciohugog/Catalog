//
//  FetchedResultsDataSource.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 8/1/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "FetchedResultsDataSource.h"

@implementation FetchedResultsDataSource

- (NSInteger)rowsInSection:(NSInteger)sectionIndex {
	id<NSFetchedResultsSectionInfo> section = self.fetchedResultsController.sections[sectionIndex];
	return section.numberOfObjects;
}

- (id)objectAtIndexPath:(NSIndexPath*)indexPath {
	return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (void)setFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController {
	_fetchedResultsController = fetchedResultsController;
	fetchedResultsController.delegate = self;
	[fetchedResultsController performFetch:NULL];
}

- (id)selectedItem {
	return nil;
}

@end
