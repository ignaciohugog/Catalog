//
//  FilterViewController.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 8/1/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterDelegate.h"

@interface FilterViewController () <UISearchBarDelegate>
@property (nonatomic) id container;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@end

@implementation FilterViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithTitle:@"Sort by name"
																																		style:UIBarButtonItemStylePlain
																																	 target:self action:@selector(sortByName)];
	self.navigationItem.rightBarButtonItem = sortButton;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	self.container = segue.destinationViewController;
}

- (IBAction)dismissKeyboard:(id)sender {
	[self.view endEditing:YES];
}

#pragma mark filters

- (void)filterByname:(NSString *) searchText {
	if ([self.container conformsToProtocol:@protocol(FilterDelegate)]) {
		NSPredicate *fetchPredicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",
																	 searchText];

		NSFetchedResultsController* fetchedResultsController = [self.container fetchedResultsController];
		[[fetchedResultsController fetchRequest] setPredicate:fetchPredicate];
		[self performFetch:fetchedResultsController];
	}
}
- (void)removeFilter {
	if ([self.container conformsToProtocol:@protocol(FilterDelegate)]) {
		NSFetchedResultsController* fetchedResultsController = [self.container fetchedResultsController];
		[[fetchedResultsController fetchRequest] setPredicate:nil];
		[self performFetch:fetchedResultsController];
	}
}

- (void)sortByName {
	if ([self.container conformsToProtocol:@protocol(FilterDelegate)]) {
		NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
		NSFetchedResultsController* fetchedResultsController = [self.container fetchedResultsController];
		[[fetchedResultsController fetchRequest] setSortDescriptors:sortDescriptors];
		[self performFetch:fetchedResultsController];
	}
}

- (void)performFetch:(NSFetchedResultsController *) fetchController {
	NSError *error;
	if ([fetchController performFetch:&error]) {
		[self.container reload];
	} else {
			//TODO: handle error
	}
}

#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[searchText isEqualToString:@""] ? ([self removeFilter]):([self filterByname:searchText]);
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	self.tapGesture.enabled = YES;
	return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
	self.tapGesture.enabled = NO;
	return YES;
}

@end
