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


@interface CatalogCollectionViewController () <FetchedResultsControllerDataSourceDelegate>
@property (nonatomic, strong) FetchedResultsCollectionDataSource *dataSource;
@end

@implementation CatalogCollectionViewController

static NSString * const reuseIdentifier = @"CatalogCollectionViewCell";

- (void)viewDidLoad {
	[super viewDidLoad];
	[self registerCell];
	[self setupDataSource];
}

- (void)registerCell {
	UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
	[self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)setupDataSource {
	self.dataSource = [[FetchedResultsCollectionDataSource alloc] initWithTableView:self.collectionView];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"detail" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	ArticleDetailViewController *detailViewController = segue.destinationViewController;
	detailViewController.article = self.dataSource.selectedItem;
}

#pragma mark FetchedResultsControllerDataSourceDelegate

- (void)configureCell:(CatalogCollectionViewCell *)cell withObject:(Article*)object {
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

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {

}
*/



@end
