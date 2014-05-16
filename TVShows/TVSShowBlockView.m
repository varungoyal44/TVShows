//
//  TVSShowBlockView.m
//  TVShows
//
//  Created by Varun Goyal on 5/6/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "TVSShowBlockView.h"
#import "UIImageView+AFNetworking.h"
#import "TVSShowModel.h"

@implementation TVSShowBlockView

- (id)initWithPosition:(CGPoint) position
         WithShowModel:(TVSShowModel *) thisShow
{
    CGRect viewFrame = CGRectMake(position.x, position.y, 110, 132);
    
    self = [super initWithFrame:viewFrame];
    if (self)
    {
        // To set view properties
        [self setBackgroundColor:[UIColor clearColor]];
        
        // To set show image background view
        UIImageView *iv_tvShowImageBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 90, 111)];
        [iv_tvShowImageBackground setImage:[UIImage imageNamed:@"Show_Tile_Background"]];
        [self addSubview:iv_tvShowImageBackground];
        
        // To set show image view
        UIImageView *iv_tvShowImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 90, 106)];
        if(thisShow.imageURLstring)
        {
            NSURL *url = [NSURL URLWithString:thisShow.imageURLstring];
            [iv_tvShowImage setImageWithURL:url];
        }
        else
        {
            [iv_tvShowImage setImage:[UIImage imageNamed:@"no_image_available"]];
        }
        [self addSubview:iv_tvShowImage];
        
        // To set show title
        UILabel *lb_tvShowTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 111, 90, 21)];
        [lb_tvShowTitle setText:thisShow.title];
        [lb_tvShowTitle setFont:[UIFont systemFontOfSize:12]];
        [lb_tvShowTitle setTextColor:[UIColor whiteColor]];
        [lb_tvShowTitle setAdjustsFontSizeToFitWidth:YES];
        [lb_tvShowTitle setMinimumScaleFactor:7.0];
        [lb_tvShowTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lb_tvShowTitle];
    }
    return self;
}

@end
