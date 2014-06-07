//
//  AddEditView.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"

@interface AddEditView : BaseView <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
{
    CGRect startRect;
    NSMutableArray *tags;
}
@property (nonatomic, readwrite) bool editingWord;
- (void)isEditingWord;

@end
