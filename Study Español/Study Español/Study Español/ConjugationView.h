//
//  ConjugationView.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConjugationView : UIView
{
    UILabel *title;
}
@property (nonatomic, readwrite) NSMutableArray *inputs;
@property (nonatomic, readwrite) NSMutableArray *labels;
@property (nonatomic, readwrite) UILabel *background;
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title;

@end
