//
//  ArticlesService.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/30/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "ArticlesService.h"

@implementation ArticlesService

- (void)fetchAllArticles:(void (^)(NSArray *pods))callback {
	[self fetchArticles:callback page:0];
}

- (void)fetchArticles:(void (^)(NSArray *pods))callback page:(NSUInteger)page {

		// TODO: create singleton
		// TODO: dictionary for parameters
		// TODO: fix harcoded number of pages
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[manager.requestSerializer setValue:@"DAOS4SYzZzmshCAAlhNN61AZzfGrp1jZ0j8jsn7h37w3ZyaXBq" forHTTPHeaderField:@"X-Mashape-Key"];
	[manager POST:@"https://devru-instructables.p.mashape.com/list?limit=1000&offset=0&sort=recent&type=id" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
		callback(responseObject[@"items"]);
		if (page + 1 < 10) {
				//	[self fetchArticles:callback page:page + 1];
		}
	} failure:^(NSURLSessionTask *operation, NSError *error) {
		callback(nil);
		NSLog(@"Error: %@", error);
	}];
}

@end
