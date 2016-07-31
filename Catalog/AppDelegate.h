//
//  AppDelegate.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/29/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersistentStack;
@class ArticlesService;
@class Importer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) ArticlesService *webservice;

@end
