//
//  CatalogCollectionViewController.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/29/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "CatalogCollectionViewController.h"
#import "CatalogCollectionViewCell.h"
#import "FetchedResultsControllerDataSourceDelegate.h"
#import "FetchedResultsCollectionDataSource.h"
#import "AppDelegate.h"
#import "Article.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ArticleDetailViewController.h"
#import "FilterDelegate.h"

@interface CatalogCollectionViewController () <FetchedResultsControllerDataSourceDelegate, FilterDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) FetchedResultsCollectionDataSource *dataSource;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation CatalogCollectionViewController

static NSString * const reuseIdentifier = @"CatalogCollectionViewCell";

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
	self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)registerCell {
	UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
	[self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)setupDataSource {
	self.dataSource = [[FetchedResultsCollectionDataSource alloc] initWithCollectionView:self.collectionView];
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	ArticleDetailViewController *detailViewController = segue.destinationViewController;
	detailViewController.article = self.dataSource.selectedItem;
}

#pragma mark FetchedResultsControllerDataSourceDelegate

- (void)configureCell:(CatalogCollectionViewCell *)cell withObject:(Article*)object {
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

- (CGSize)collectionView:(UICollectionView *)collectionView
									layout:(UICollectionViewLayout *)collectionViewLayout
	sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat padding = 15;
	CGFloat cellSize = collectionView.frame.size.width - padding;

	return CGSizeMake(cellSize / 2, cellSize / 1.5);


}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.collectionView reloadData];
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"detail" sender:nil];
}

#pragma mark FilterDelegate

- (void)reload {
	[self.collectionView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsController {
	return self.dataSource.fetchedResultsController;
}

@end
