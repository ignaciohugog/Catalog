//
//  ArticlesService.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/30/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticlesService : NSObject
	// TODO: error handler
- (void)fetchAllArticles:(void (^)(NSArray *categories))callback;
@end
