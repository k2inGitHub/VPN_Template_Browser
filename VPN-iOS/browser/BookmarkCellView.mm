//
// Created by sail on 10/24/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import "BookmarkCellView.h"


@implementation BookmarkCellView {

}
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"web_bg"]];
    _title = [[UILabel alloc] initWithFrame:self.bounds];
    [_title setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_title];
//    _title.center = self.center;
  }
  return self;
}

@end