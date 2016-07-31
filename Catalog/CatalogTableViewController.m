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

@interface CatalogTableViewController() <FetchedResultsControllerDataSourceDelegate>

@property (nonatomic, strong) FetchedResultsTableDataSource *dataSource;

@end

@implementation CatalogTableViewController

static NSString * const reuseIdentifier = @"CatalogTableViewCell";

- (void)viewDidLoad {
	[super viewDidLoad];
	[self registerCell];
	[self setupDataSource];
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

#pragma mark FetchedResultsControllerDataSourceDelegate

- (void)configureCell:(CatalogTableViewCell *)cell withObject:(Article*)object {
	cell.subtitle.text = object.author;
	cell.nameLabel.text = object.title;

	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:object.imageUrl]
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
