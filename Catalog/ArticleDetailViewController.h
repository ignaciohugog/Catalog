//
//  ArticleDetailViewController.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/31/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@protocol DetailDelegate
@optional
- (void)deleteObject:(Article *)object;
@end

@interface ArticleDetailViewController : UIViewController

@property (nonatomic) Article *article;
@property (nonatomic, weak) id <DetailDelegate> delegate;

@end
