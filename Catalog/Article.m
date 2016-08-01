//
//  Article.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/30/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "Article.h"

@implementation Article

@dynamic identifier;
@dynamic title;
@dynamic category;
@dynamic channel;
@dynamic author;
@dynamic publishDate;
@dynamic smallImageUrl;
@dynamic bigImageUrl;

- (void)loadFromDictionary:(NSDictionary *)dictionary {
	self.identifier = dictionary[@"id"];
	self.title = dictionary[@"title"];
	self.category = dictionary[@"category"];
	self.channel = dictionary[@"channel"];
	self.author = dictionary[@"author"];
	self.publishDate = dictionary[@"publishDate"];
	self.smallImageUrl = dictionary[@"imageUrl"];
	self.bigImageUrl = dictionary[@"square3Url"];
}

+ (Article *)findOrCreatePodWithIdentifier:(NSString *)identifier inContext:(NSManagedObjectContext *)context {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
	NSError *error = nil;
	NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
	if (error) {
		NSLog(@"error: %@", error.localizedDescription);
	}
	if (result.lastObject) {
		return result.lastObject;
	} else {
		Article *article = [self insertNewObjectIntoContext:context];
		article.identifier = identifier;
		return article;
	}
}
@end
