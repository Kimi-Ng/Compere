//
//  InputViewController.m
//  Compere
//
//  Created by Erin Chuang on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "InputViewController.h"
#import "SuggestionCollectionViewCell.h"
#import "DataManager.h"
#import "MessageDataObject.h"
#import "ViewConstants.h"

#define kOFFSET_FOR_KEYBOARD 270.0
static CGFloat const kCellHeight = 38.f;
static CGFloat const kHorizontalMargin = 10.f;

static NSString * const kSimilarApiUrl = @"http://localhost:8080/similar?text=%@";

@interface InputViewController ()
<
UITextFieldDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
NSURLConnectionDelegate
>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *questionPrefixes;
@property (strong, nonatomic) NSArray *suggestions;

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textField.delegate = self;
    [self setupCollectionView];
    self.questionPrefixes = @[@"what",@"why",@"how",@"when",@"who"];
    self.suggestions = @[@"suggestion 1 ", @"suggestion 2", @"suggestion 3"];
    self.session = [NSURLSession sharedSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPostTapped:(id)sender {
    NSString *text = self.textField.text;
    if (text && text.length) {
        if (self.delegate) {
            BOOL isQ = [self isAQuestion:text];
            NSString *score = isQ ? @"0":@"";
            MessageDataObject *message = [[MessageDataObject alloc] initWithAuthor:kAuthor content:text isQuestion:isQ voteScore:score textId:@"" voted:0];
            [self.delegate onUserPostMessage:message];
        }
        NSString *type = [self isAQuestion:text] ? @"q" : @"c";
        [[DataManager sharedInstance] postWithAuthor:kAuthor text:text type:type];
    }
    
    [self.collectionView setHidden:YES];
    [self.textField resignFirstResponder];
    self.textField.text = @"";
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 3) {
        if (string.length > 0 && ![string isEqualToString:@"\n"]) {
            // TODO: api call to fetch suggestions & display suggestion view
            [[DataManager sharedInstance] getSimilarWithText:textField.text completion:^(NSArray *dataArray) {
                if (!dataArray.count) {
                    self.suggestions = @[];
                    [self.collectionView setHidden:YES];
                } else {
                    self.suggestions = dataArray;
                    CGRect rect = self.collectionView.frame;
                    rect.size.height = self.suggestions.count * kCellHeight;
                    rect.origin.y = 0;//-rect.size.height;
                    self.collectionView.frame = rect;

                    CGRect inputViewFrame = self.view.frame;
                    inputViewFrame.origin.y = ([UIScreen mainScreen].bounds.size.height - kOFFSET_FOR_KEYBOARD)- kInputViewHeight - rect.size.height;
                    inputViewFrame.size.height = kInputViewHeight + rect.size.height;
                    
                    [self.view setFrame:inputViewFrame];
                    if (self.collectionView.isHidden) {
                        [self.collectionView setHidden:NO];
                    }
                    [self.collectionView reloadData];
                }
            }];
        }
        // TODO: refactor once api is ready
//        if (self.collectionView.isHidden) {
//            CGRect rect = self.collectionView.frame;
//            rect.size.height = self.suggestions.count * kCellHeight;
//            rect.origin.y = -rect.size.height;
//            self.collectionView.frame = rect;
//            [self.collectionView reloadData];
//            [self.collectionView setHidden:NO];
//        }
    } else {
        [self.collectionView setHidden:YES];
    }
    return YES;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.suggestions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SuggestionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SuggestionCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    MessageDataObject *obj = self.suggestions[indexPath.row];
    cell.suggestionLabel.text = obj.content;
    [cell setVoteButtonScore:obj.voteScore];
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds)-kHorizontalMargin*2.f, kCellHeight);
}

#pragma mark - private methods
- (void)setupCollectionView
{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0.0f;
    layout.minimumLineSpacing = 0.0f;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, 0) collectionViewLayout:layout];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, kHorizontalMargin, 0, kHorizontalMargin);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView setHidden:YES];
    
    [self.collectionView registerNib:[UINib nibWithNibName:[SuggestionCollectionViewCell cellReuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[SuggestionCollectionViewCell cellReuseIdentifier]];
    self.collectionView.userInteractionEnabled = YES;
    [self.view addSubview:self.collectionView];
}

- (BOOL)isAQuestion:(NSString*)text
{
    if ([text hasSuffix:@"?"]) {
        return YES;
    }
    __block BOOL isQuestion = NO;
    [self.questionPrefixes enumerateObjectsUsingBlock:^(NSString * _Nonnull prefix, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([text hasPrefix:prefix]) {
            isQuestion = YES;
            *stop = YES;
        }
    }];
    return isQuestion;
}

@end
