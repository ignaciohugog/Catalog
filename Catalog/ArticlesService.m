//
//  ArticlesService.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/30/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "ArticlesService.h"

#define kCLIENTID @"DAOS4SYzZzmshCAAlhNN61AZzfGrp1jZ0j8jsn7h37w3ZyaXBq"

@interface ArticlesService () {
	AFHTTPSessionManager *_manager;
}
@end

@implementation ArticlesService

- (instancetype)init{
	self = [super init];
	if (self){
		_manager = [self manager];
	}
	return self;
}

- (AFHTTPSessionManager *)manager{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[manager.requestSerializer setValue:kCLIENTID forHTTPHeaderField:@"X-Mashape-Key"];
	return manager;
}

- (void)fetchAllArticles:(void (^)(NSArray *pods))callback {
	[_manager POST:@"https://devru-instructables.p.mashape.com/list?limit=100&offset=0&sort=recent"
			parameters:nil
				progress:nil
				 success:^(NSURLSessionTask *task, id responseObject) {
					 callback(responseObject[@"items"]);
				 } failure:^(NSURLSessionTask *operation, NSError *error) {
					 callback(nil);
					 NSLog(@"Error: %@", error);
				 }];
}

@end
