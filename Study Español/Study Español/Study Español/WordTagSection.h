//
//  WordTagSection.h
//  Study Español
//
//  Created by Evan on 4/20/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchView, TextView;

@interface WordTagSection : NSObject <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tagTable;
    SearchView *aView;
    TextView *tagInput;
}
-(void)CreateSearchSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout;
-(void)CreateAddEditSection:(UIView*)view SuperView:(UIViewController*)superView Layout:(int)layout;

@end
