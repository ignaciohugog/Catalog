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

@interface CatalogTableViewController() <FetchedResultsControllerDataSourceDelegate, FilterDelegate, DetailDelegate>
@property (nonatomic, strong) FetchedResultsTableDataSource *dataSource;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation CatalogTableViewController

static NSString * const reuseIdentifier = @"CatalogTableViewCell";

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		self.managedObjectContext = appDelegate.managedObjectContext;
	}
	return self;
}

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
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:YES]];
	[request setFetchBatchSize:50];
	return [[NSFetchedResultsController alloc] initWithFetchRequest:request
																						 managedObjectContext:self.managedObjectContext
																							 sectionNameKeyPath:nil
																												cacheName:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"detail" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	ArticleDetailViewController *detailViewController = segue.destinationViewController;
	detailViewController.delegate = self;
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

- (void)deleteObject:(Article *)object {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableArray *deletedArticles = [[NSMutableArray alloc] initWithArray:
																		 [userDefaults objectForKey:@"deletedArticles"]];
	[deletedArticles addObject:object.identifier];
	[userDefaults setObject:deletedArticles forKey:@"deletedArticles"];
	[userDefaults synchronize];

	[self.managedObjectContext deleteObject:object];
	[self.managedObjectContext save:nil];
}

#pragma mark FilterDelegate
- (void)reload {
	[self.tableView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsController {
	return self.dataSource.fetchedResultsController;
}



@end
