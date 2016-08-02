//
//  UpdateArticleEntities.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 8/2/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface UpdateArticleEntities : NSObject
+ (void)findOrCreateArticles:(NSArray *)articles inContext:(NSManagedObjectContext *)context;
@end
