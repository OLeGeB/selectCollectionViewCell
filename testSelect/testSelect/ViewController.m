//
//  ViewController.m
//  testSelect
//
//  Created by 李江波 on 2019/4/22.
//  Copyright © 2019年 jinxiaofu. All rights reserved.
//

#import "ViewController.h"
#import "LBCollectionViewCell.h"


static NSString *const cellId = @"cellId";
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArrayM;

@property (nonatomic, weak) UICollectionView *testCollectionView;

// 选中cell的indexPath
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

// 取消选中的cell，防止由于重用，在取消选中的代理方法中没有设置
@property (nonatomic, strong) NSIndexPath *DeselectIndexpath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self setupUICollectionView];
    
    // 设置collectionView的数据
    [self setupCollectionViewData];
}

#pragma mark - private Method
#pragma mark 设置collectionView的数据
- (void)setupCollectionViewData {
    
    for (int i = 0; i < 20; i++) {
        [self.dataArrayM addObject:[NSString stringWithFormat:@"第%d个cell",i]];
    }
    
    [self.testCollectionView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.testCollectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:self.testCollectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark - setupUI
#pragma mark setupUICollectionView
- (void)setupUICollectionView {
    // 设置uicollectionView样式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *testCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [testCollectionView registerClass:[LBCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    testCollectionView.delegate = self;
    testCollectionView.dataSource = self;
    [testCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:testCollectionView];
    self.testCollectionView = testCollectionView;
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArrayM count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell.nameLabel setText:self.dataArrayM[indexPath.row]];
    
    if ([self.selectIndexPath isEqual:indexPath]) {
        [cell setBackgroundColor:[UIColor greenColor]];
        [cell.nameLabel setTextColor:[UIColor redColor]];
    } else {
        [cell setBackgroundColor:[UIColor grayColor]];
        [cell.nameLabel setTextColor:[UIColor blackColor]];
    }
    
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (CGSize) collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
   sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndexPath = indexPath;
    LBCollectionViewCell *cell = (LBCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor greenColor]];
    [cell.nameLabel setTextColor:[UIColor redColor]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.DeselectIndexpath = indexPath;
    LBCollectionViewCell *cell = (LBCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) { // 如果重用之后拿不到cell,就直接返回
        return;
    }
    [cell setBackgroundColor:[UIColor grayColor]];
    [cell.nameLabel setTextColor:[UIColor blackColor]];
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    LBCollectionViewCell *LBcell = (LBCollectionViewCell *)cell;
    if (self.DeselectIndexpath && [self.DeselectIndexpath isEqual:indexPath]) {
        
        [LBcell setBackgroundColor:[UIColor grayColor]];
        [LBcell.nameLabel setTextColor:[UIColor blackColor]];
    }
    
    if ([self.selectIndexPath isEqual:indexPath]) {
        [LBcell setBackgroundColor:[UIColor greenColor]];
        [LBcell.nameLabel setTextColor:[UIColor redColor]];
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArrayM {
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}

@end
