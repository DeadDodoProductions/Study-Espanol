//
//  QuizAnswerCell.h
//  Study Español
//
//  Created by Evan on 4/29/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizAnswerCell : UICollectionViewCell
{
    
}
@property (nonatomic, readwrite) UILabel *wordTitle;
@property (nonatomic, readwrite) UILabel *answerTitle;
@property (nonatomic, readwrite) UILabel *correctionTitle;
@property (nonatomic, readwrite) UILabel *wordLabel;
@property (nonatomic, readwrite) UILabel *answerLabel;
@property (nonatomic, readwrite) UILabel *correctionLabel;
@property (nonatomic, readwrite) UILabel *tenseLabel;
-(void)CreateCell:(NSString*)word Answer:(NSString*)answer Correction:(NSString*)correction;
-(void)CreateCell:(NSString*)word Tense:(NSString*)tense Answer:(NSString*)answer Correction:(NSString*)correction;

@end
