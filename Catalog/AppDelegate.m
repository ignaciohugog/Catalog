//
//  AppDelegate.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/29/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "AppDelegate.h"
#import "PersistentStack.h"
#import "ArticlesService.h"
#import "Importer.h"

@interface AppDelegate ()
@property (nonatomic, strong) Importer *importer;
@property (nonatomic, strong) PersistentStack *persistentStack;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self setAppDefaults];
	self.persistentStack = [[PersistentStack alloc] initWithStoreURL:self.storeURL
																													modelURL:self.modelURL];
	self.webservice = [[ArticlesService alloc] init];
	self.importer = [[Importer alloc] initWithContext:self.persistentStack.backgroundManagedObjectContext
																				 webservice:self.webservice];
	[self.importer import];
	return YES;
}

- (void)setAppDefaults {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@17
																													forKey:@"font_size"];
	[defaults registerDefaults:appDefaults];
	[defaults synchronize];
}
#pragma mark - Core Data 

- (void)saveContext {
	NSError *error = nil;
	[self.persistentStack.managedObjectContext save:&error];
	if (error) {
		NSLog(@"error saving: %@", error.localizedDescription);
	}
}

- (NSURL*)storeURL {
	NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
																																		 inDomain:NSUserDomainMask
																														appropriateForURL:nil
																																			 create:YES
																																				error:NULL];
	return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

- (NSURL*)modelURL {
	return [[NSBundle mainBundle] URLForResource:@"Catalog" withExtension:@"momd"];
}

- (NSManagedObjectContext *)managedObjectContext {
	return self.persistentStack.managedObjectContext;
}

@end
