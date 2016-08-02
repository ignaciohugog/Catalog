//
//  FetchedResultsTableDataSource.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/31/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "FetchedResultsTableDataSource.h"

@interface FetchedResultsTableDataSource ()
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation FetchedResultsTableDataSource

- (id)initWithTableView:(UITableView*)tableView {
	self = [super init];
	if (self) {
		self.tableView = tableView;
		self.tableView.dataSource = self;
	}
	return self;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return [self rowsInSection:section];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
	id object = [self objectAtIndexPath:indexPath];
	id cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
	[self.delegate configureCell:cell withObject:object];
	return cell;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self.delegate deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
	}
}

- (id)selectedItem {
	NSIndexPath* path = self.tableView.indexPathForSelectedRow;
	return path ? [self.fetchedResultsController objectAtIndexPath:path] : nil;
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller {
	[self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller {
	[self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject
			 atIndexPath:(NSIndexPath*)indexPath
		 forChangeType:(NSFetchedResultsChangeType)type
			newIndexPath:(NSIndexPath*)newIndexPath {
	if (type == NSFetchedResultsChangeInsert) {
		[self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	} else if (type == NSFetchedResultsChangeMove) {
		[self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
	} else if (type == NSFetchedResultsChangeDelete) {
		[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	} else if (type == NSFetchedResultsChangeUpdate) {
		if ([self.tableView.indexPathsForVisibleRows containsObject:indexPath]) {
			[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
		}
	} else {
		NSAssert(NO,@"");
	}
}


@end
