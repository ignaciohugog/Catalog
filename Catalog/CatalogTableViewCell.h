//
//  CatalogTableViewCell.h
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/29/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface CatalogTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;

- (void)setFontSize;

@end
