//
//  CatalogTableViewController.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/29/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "CatalogTableViewController.h"
#import <CoreData/CoreData.h>
#import "PersistentStack.h"
#import "AppDelegate.h"
#import "Article.h"
#import "CatalogTableViewCell.h"

@interface CatalogTableViewController()
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@end

@implementation CatalogTableViewController


- (void)viewDidLoad {
	[super viewDidLoad];

	UINib *cellNib = [UINib nibWithNibName:@"CatalogTableViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"CatalogTableViewCell"];

	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Article"];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:NO]];
	AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];


	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
																																			managedObjectContext:appDelegate.persistentStack.managedObjectContext
																																				sectionNameKeyPath:nil
																																								 cacheName:nil];



		// Uncomment the following line to preserve selection between presentations.
		// self.clearsSelectionOnViewWillAppear = NO;

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
	self.tableView.estimatedRowHeight = 150;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
	id<NSFetchedResultsSectionInfo> section = self.fetchedResultsController.sections[sectionIndex];
	return section.numberOfObjects;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	 Article * object = [self.fetchedResultsController objectAtIndexPath:indexPath];
	 CatalogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatalogTableViewCell" forIndexPath:indexPath];
	 cell.subtitle.text = object.author;
	 cell.nameLabel.text = object.title;

	 return cell;
 }

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
	[self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller
{
	[self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath*)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath*)newIndexPath
{
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

- (void)setFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController
{
	NSAssert(_fetchedResultsController == nil, @"TODO: you can currently only assign this property once");
	_fetchedResultsController = fetchedResultsController;
	fetchedResultsController.delegate = self;
	[fetchedResultsController performFetch:NULL];
}


- (id)selectedItem
{
	NSIndexPath* path = self.tableView.indexPathForSelectedRow;
	return path ? [self.fetchedResultsController objectAtIndexPath:path] : nil;
}


//- (void)setPaused:(BOOL)paused
//{
//	_paused = paused;
//	if (paused) {
//		self.fetchedResultsController.delegate = nil;
//	} else {
//		self.fetchedResultsController.delegate = self;
//		[self.fetchedResultsController performFetch:NULL];
//		[self.tableView reloadData];
//	}
//}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
