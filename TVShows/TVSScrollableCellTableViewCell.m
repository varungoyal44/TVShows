//
//  TVSScrollableCellTableViewCell.m
//  TVShows
//
//  Created by Varun Goyal on 5/7/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "TVSScrollableCellTableViewCell.h"

@implementation TVSScrollableCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
