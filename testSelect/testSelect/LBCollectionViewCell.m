//
//  LBCollectionViewCell.m
//  testSelect
//
//  Created by 李江波 on 2019/4/22.
//  Copyright © 2019年 jinxiaofu. All rights reserved.
//

#import "LBCollectionViewCell.h"

@implementation LBCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        [self setBackgroundColor:[UIColor grayColor]];
    }
    
    return self;
}

- (void)initUI {
    
    CGFloat nameH = 20;
    CGSize cellSize = self.frame.size;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (cellSize.height - nameH) * 0.5, cellSize.width, nameH)];
    [nameLabel setFont:[UIFont systemFontOfSize:16]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
}
@end
