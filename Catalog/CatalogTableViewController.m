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
#import "FilterDelegate.h"

@interface CatalogTableViewController() <FetchedResultsControllerDataSourceDelegate, FilterDelegate>

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
	[self.tableView reloadData];
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
	[request setFetchBatchSize:3];
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
	[cell setFontSize];

	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:object.smallImageUrl]
																								cachePolicy:NSURLRequestReturnCacheDataElseLoad
																						timeoutInterval:60];
	[cell.articleImageView setImageWithURLRequest:imageRequest
															 placeholderImage:[UIImage imageNamed:@"placeholder"]
																				success:nil
																				failure:nil];
}

- (void)deleteObject:(id)object {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate.managedObjectContext deleteObject:object];
	[appDelegate.managedObjectContext save:nil];
}

#pragma mark FilterDelegate
- (void)reload {
	[self.tableView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsController {
	return self.dataSource.fetchedResultsController;
}



@end
