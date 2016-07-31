//
//  Importer.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/30/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ArticlesService.h"

@interface Importer : NSObject
- (id)initWithContext:(NSManagedObjectContext *)context webservice:(ArticlesService *)webservice;
- (void)import;
@end
