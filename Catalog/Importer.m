//
//  Importer.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/30/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "Importer.h"
#import "UpdateArticleEntities.h"

@interface Importer ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) ArticlesService *webservice;

@end

@implementation Importer

- (id)initWithContext:(NSManagedObjectContext *)context webservice:(ArticlesService *)webservice {
	self = [super init];
	if (self) {
		self.context = context;
		self.webservice = webservice;
	}
	return self;
}

- (void)import {
	[self.webservice fetchAllArticles:^(NSArray *articles) {
		[self.context performBlock:^ {
			[UpdateArticleEntities findOrCreateArticles:articles inContext:self.context];
			NSError *error = nil;
			[self.context save:&error];
			if (error) {
				NSLog(@"Error: %@", error.localizedDescription);					
			}
		}];
	}];
}

@end
