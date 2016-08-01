//
//  ArticleDetailViewController.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/31/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "Article.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"

@interface ArticleDetailViewController()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articleImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = self.article.title;
	self.publishDateLabel.text = self.article.publishDate;
	self.categoryLabel.text = self.article.category;
	self.channelLabel.text = self.article.channel;
	self.authorLabel.text = self.article.author;

	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.article.smallImageUrl]
																								cachePolicy:NSURLRequestReturnCacheDataElseLoad
																						timeoutInterval:60];
	[self.articleImage setImageWithURLRequest:imageRequest
															 placeholderImage:[UIImage imageNamed:@"placeholder"]
																				success:nil
																				failure:nil];

	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain
																																	 target:self action:@selector(deleteArticle)];
	self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)deleteArticle {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate.managedObjectContext deleteObject:self.article];
	[appDelegate.managedObjectContext save:nil];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)articleImageClicked:(id)sender {
	self.contentViewHeight.constant -= self.articleImageHeight.constant;
	self.articleImageHeight.constant = 0;
	[UIView animateWithDuration:0.35
									 animations:^{
										 [self.view layoutIfNeeded];
									 }];
}

@end
