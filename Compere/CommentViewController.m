//
//  CommentViewController.m
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "CommentViewController.h"
#import "MessageCollectionViewCell.h"
#import "ViewConstants.h"
#import "DataManager.h"

@interface CommentViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *commentDataArray;
@property (nonatomic) NSUInteger currentCount;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpCollectionView];
    //[[DataManager sharedInstance] applyMockData];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(regularIntervalReload)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)setUpCollectionView
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:kMessageCollectionViewCellIdentifier bundle:nil] forCellWithReuseIdentifier:kMessageCollectionViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [DataManager sharedInstance].allContentMockDataList.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMessageCollectionViewCellIdentifier forIndexPath:indexPath];
    [((MessageCollectionViewCell *)cell) populateCellWithData:[DataManager sharedInstance].allContentMockDataList[indexPath.row]];
    if (((MessageDataObject *)[DataManager sharedInstance].allContentMockDataList[indexPath.row]).isQuestion) {
            [(MessageCollectionViewCell *)cell setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    } else {
        [(MessageCollectionViewCell *)cell setBackgroundColor:[UIColor whiteColor]];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [MessageCollectionViewCell cellDefaultSize];
    //return CGSizeZero;
}

- (void)refreshContentWithReload:(BOOL)reload
{
    if (reload) {
        [[DataManager sharedInstance] getCommentsWithAuthor:kAuthor completion:^(NSArray *dataArray) {
            if (self.currentCount != dataArray.count) {
                [self.collectionView reloadData];
            }
        }];
    } else {
        [self.collectionView reloadData];
    }
}

- (void)regularIntervalReload
{
    self.currentCount = [DataManager sharedInstance].allContentMockDataList.count;
    [self refreshContentWithReload:YES];
}

@end
