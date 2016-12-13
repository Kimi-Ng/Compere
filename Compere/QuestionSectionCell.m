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

@interface QuestionSectionCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIColor *cellBackgroundColor;
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;//self.commentDataArray.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMessageCollectionViewCellIdentifier forIndexPath:indexPath];
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
