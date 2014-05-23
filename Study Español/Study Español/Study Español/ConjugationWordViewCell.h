//
//  TableViewCell.h
//  Study Español
//
//  Created by Evan Combs on 5/22/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConjugationWordViewCell : UITableViewCell
{
}
@property (nonatomic, readwrite) UILabel *tense;
@property (nonatomic, readwrite) UILabel *yo;
@property (nonatomic, readwrite) UILabel *tu;
@property (nonatomic, readwrite) UILabel *el;
@property (nonatomic, readwrite) UILabel *nos;
@property (nonatomic, readwrite) UILabel *vos;
@property (nonatomic, readwrite) UILabel *ellos;

@end
