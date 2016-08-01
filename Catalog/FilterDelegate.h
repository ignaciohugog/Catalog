//
//  FilterDelegate.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 8/1/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <CoreData/CoreData.h>
@protocol FilterDelegate

- (void)reload;
- (NSFetchedResultsController *)fetchedResultsController;

@end