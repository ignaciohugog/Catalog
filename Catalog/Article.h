//
//  Article.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/30/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ModelObject.h"

@interface Article : ModelObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * channel;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * publishDate;
@property (nonatomic, retain) NSString * smallImageUrl;
@property (nonatomic, retain) NSString * bigImageUrl;

- (void)loadFromDictionary:(NSDictionary *)dictionary;
+ (Article *)findOrCreatePodWithIdentifier:(NSString *)identifier inContext:(NSManagedObjectContext *)context;
@end
