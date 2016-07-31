//
//  FetchedResultsCollectionDataSource.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/31/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "FetchedResultsCollectionDataSource.h"
#import "UICollectionView+NSFetchedResultsController.h"

@interface FetchedResultsCollectionDataSource ()

@property (nonatomic, strong) UICollectionView* collectionView;

@end

@implementation FetchedResultsCollectionDataSource

- (id)initWithTableView:(UICollectionView*)collectionView {
	self = [super init];
	if (self) {
		self.collectionView = collectionView;
		self.collectionView.dataSource = self;
	}
	return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectionIndex {
	id<NSFetchedResultsSectionInfo> section = self.fetchedResultsController.sections[sectionIndex];
	return section.numberOfObjects;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	id object = [self objectAtIndexPath:indexPath];
	id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier forIndexPath:indexPath];
	[self.delegate configureCell:cell withObject:object];
	return cell;
}

- (id)objectAtIndexPath:(NSIndexPath*)indexPath {
	return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (id)selectedItem
{
		//NSIndexPath* path = self.collectionView.indexPathForSelectedRow;
		//return path ? [self.fetchedResultsController objectAtIndexPath:path] : nil;
	return nil;
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
					 atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	[self.collectionView addChangeForSection:sectionInfo atIndex:sectionIndex forChangeType:type];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
			 atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
			newIndexPath:(NSIndexPath *)newIndexPath {
	[self.collectionView addChangeForObjectAtIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.collectionView commitChanges];
}

- (void)setFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController {
	_fetchedResultsController = fetchedResultsController;
	fetchedResultsController.delegate = self;
	[fetchedResultsController performFetch:NULL];
}

@end
