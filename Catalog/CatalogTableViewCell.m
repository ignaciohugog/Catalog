//
//  CatalogTableViewCell.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/29/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "CatalogTableViewCell.h"

@implementation CatalogTableViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)setFontSize {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSInteger fontSize = [[defaults objectForKey:@"font_size"] integerValue];
	self.nameLabel.font = [UIFont fontWithName:self.nameLabel.font.fontName size:fontSize];
	self.subtitle.font = [UIFont fontWithName:self.subtitle.font.fontName size:fontSize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
