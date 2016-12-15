//
//  QuestionSectionCell.m
//  Compere
//
//  Created by Kimi Wu on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "QuestionSectionCell.h"
#import "ViewConstants.h"
#import "MessageCollectionViewCell.h"
#import "MessageDataObject.h"

@interface QuestionSectionCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIColor *cellBackgroundColor;
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation QuestionSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpCollectionView];
    // Initialization code
}

- (void)setUpCollectionView
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:kMessageCollectionViewCellIdentifier bundle:nil] forCellWithReuseIdentifier:kMessageCollectionViewCellIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)populateCellWithDataList:(NSArray *)dataList
{
    self.dataList = dataList;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMessageCollectionViewCellIdentifier forIndexPath:indexPath];
    //TODO:
    [((MessageCollectionViewCell *)cell) populateCellWithData:self.dataList[indexPath.row]];
    if (self.cellBackgroundColor) {
        [cell setBackgroundColor:self.cellBackgroundColor];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [MessageCollectionViewCell cellDefaultSize];
    //return CGSizeZero;
}

- (void)setSectionBackgroundColor:(UIColor *)bgColor
{
    self.cellBackgroundColor = bgColor;
    self.collectionView.backgroundColor = bgColor;
    //[self.collectionView reloadData];
}


@end
