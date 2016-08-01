//
//  CatalogTableViewController.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/29/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "FetchedResultsTableDataSource.h"
#import "CatalogTableViewController.h"
#import "CatalogTableViewCell.h"
#import "AppDelegate.h"
#import "Article.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ArticleDetailViewController.h"

@interface CatalogTableViewController() <FetchedResultsControllerDataSourceDelegate>

@property (nonatomic, strong) FetchedResultsTableDataSource *dataSource;

@end

@implementation CatalogTableViewController

static NSString * const reuseIdentifier = @"CatalogTableViewCell";

- (void)viewDidLoad {
	[super viewDidLoad];
	[self registerCell];
	[self setupDataSource];
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"filterByname" style:UIBarButtonItemStylePlain
																																	 target:self action:@selector(filterByname)];
	self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)filterByname {

 NSPredicate *fetchPredicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",
													 @"From"];



	NSFetchedResultsController* fetchedResultsController = self.dataSource.fetchedResultsController;

	[[fetchedResultsController fetchRequest] setPredicate:fetchPredicate];

	[NSFetchedResultsController deleteCacheWithName:@"Article"];

	NSError * error;
	if (![fetchedResultsController performFetch:&error]){
			//TODO:: handleerror
	}
	[self.tableView reloadData];
}

- (void)order {
	NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
	NSFetchedResultsController* fetchedResultsController = self.dataSource.fetchedResultsController;

	[[fetchedResultsController fetchRequest] setSortDescriptors:sortDescriptors];
	NSError *error;
	if (![fetchedResultsController performFetch:&error]) {
			//TODO:: handleerror
	}

	[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	self.tableView.estimatedRowHeight = 150;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)registerCell {
	UINib *cellNib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:reuseIdentifier];
}

- (void)setupDataSource {
	self.dataSource = [[FetchedResultsTableDataSource alloc] initWithTableView:self.tableView];
	self.dataSource.delegate = self;
	self.dataSource.fetchedResultsController = [self createResultsController];
	self.dataSource.reuseIdentifier = reuseIdentifier;
}

- (NSFetchedResultsController *)createResultsController {
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Article"];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:YES]];
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	return [[NSFetchedResultsController alloc] initWithFetchRequest:request
																						 managedObjectContext:appDelegate.managedObjectContext
																							 sectionNameKeyPath:nil
																												cacheName:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"detail" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	ArticleDetailViewController *detailViewController = segue.destinationViewController;
	detailViewController.article = self.dataSource.selectedItem;
}


#pragma mark FetchedResultsControllerDataSourceDelegate

- (void)configureCell:(CatalogTableViewCell *)cell withObject:(Article*)object {
	cell.subtitle.text = object.author;
	cell.nameLabel.text = object.title;

	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:object.smallImageUrl]
																								cachePolicy:NSURLRequestReturnCacheDataElseLoad
																						timeoutInterval:60];
	[cell.articleImageView setImageWithURLRequest:imageRequest
															 placeholderImage:[UIImage imageNamed:@"placeholder"]
																				success:nil
																				failure:nil];
}

- (void)deleteObject:(id)object {

}



@end
