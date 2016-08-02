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
	self.title = dictionary[@"title"] ? dictionary[@"title"]:@"-";
	self.category = dictionary[@"category"];
	self.channel = dictionary[@"channel"];
	self.author = dictionary[@"author"];
	self.publishDate = dictionary[@"publishDate"];
	self.smallImageUrl = dictionary[@"imageUrl"];
	self.bigImageUrl = dictionary[@"square3Url"];
}

@end
