//
//  QuizVocabCell.h
//  Study Español
//
//  Created by Evan on 4/29/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextView;

@interface QuizVocabCell : UICollectionViewCell <UITextViewDelegate>
{
    
}
@property (nonatomic, readwrite) UILabel *wordLabel;
@property (nonatomic, readwrite) UITextField *wordField;
@property (nonatomic, readwrite) id theDelagate;
-(void)CreateTextView:(TextView*)textView;

@end

@protocol QuizVocabCellDelagate<NSObject>
-(void)OnFinishAnsweringWord:(UITextField*)textField;
@end