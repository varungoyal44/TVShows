//
//  TVSShowBlockView.h
//  TVShows
//
//  Created by Varun Goyal on 5/6/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVSShowModel.h"

@interface TVSShowBlockView : UIView
- (id)initWithPosition:(CGPoint) position
         WithShowModel:(TVSShowModel *) thisShow;

@end
