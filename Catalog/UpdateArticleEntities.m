//
//  UpdateArticleEntities.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 8/2/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "UpdateArticleEntities.h"
#import "Article.h"

@implementation UpdateArticleEntities

+ (void)findOrCreateArticles:(NSArray *)articlesDictionary inContext:(NSManagedObjectContext *)context {
		// filter articles removed
	NSArray *articles = [self filterRemoved:articlesDictionary];
		// order articles dictionary by id
	NSArray *sortedArticlesDictionaries = [self orderDictionaryArticlesByID:articles];
		// get articles ID sorted
	NSArray *articlesIDSorted = [self articlesID:articles];
		// get matching articles
	NSArray *articlesMatching = [self matchingArticles:articlesIDSorted inContext:context];

	int i = 0; // articlesIds array index
	int j = 0; // matchingArticles array index

	while ((i < [articlesIDSorted count]) && (j <= [articlesMatching count])) {
		NSString *articleId = articlesIDSorted[i];
		Article *article = [articlesMatching count]!=0 ? articlesMatching[j] : nil;
  if (![articleId isEqualToString:article.identifier]) {
		article = [Article insertNewObjectIntoContext:context];
	} else {
		j++; // check the next Article object
	}
		[article loadFromDictionary:sortedArticlesDictionaries[i]];
  i++;
	}
}

+ (NSArray *)orderDictionaryArticlesByID:(NSArray *)articles {
	NSSortDescriptor *idDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
	NSArray *descriptors = [NSArray arrayWithObjects:idDescriptor, nil];
	return [articles sortedArrayUsingDescriptors:descriptors];
}

+ (NSArray *)articlesID:(NSArray *)articles {
	NSDictionary *articlesID = [NSDictionary dictionaryWithObjects:articles forKeys:[articles valueForKey:@"id"]];
	return [articlesID.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

+ (NSArray *)matchingArticles:(NSArray *)articlesIdSorted inContext:(NSManagedObjectContext *)context {
	NSFetchRequest *fetchRequest = [NSFetchRequest new];
	[fetchRequest setEntity: [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context]];
	[fetchRequest setPredicate: [NSPredicate predicateWithFormat: @"(identifier IN %@)", articlesIdSorted]];
	[fetchRequest setSortDescriptors: [NSArray arrayWithObject: [[NSSortDescriptor alloc] initWithKey: @"identifier" ascending:YES]]];
	return [context executeFetchRequest:fetchRequest error:nil];
}

+ (NSArray *)filterRemoved:(NSArray *)articles {
	NSMutableArray* filteredArray = [NSMutableArray new];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSArray* deletedArticles = [userDefaults objectForKey:@"deletedArticles"];

	for (NSDictionary* dic in articles) {
		if (![deletedArticles containsObject:dic[@"id"]]) {
			[filteredArray addObject:dic];
		}
	}
	return filteredArray;
}

@end
