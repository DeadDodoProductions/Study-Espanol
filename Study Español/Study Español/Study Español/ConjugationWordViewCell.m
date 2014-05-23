//
//  TableViewCell.m
//  Study Español
//
//  Created by Evan Combs on 5/22/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "ConjugationWordViewCell.h"

@implementation ConjugationWordViewCell
@synthesize tense, yo, tu, el, nos, vos, ellos;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        tense = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, 25)];
        [self addSubview:tense];
        yo = [[UILabel alloc]initWithFrame:CGRectMake(2, 29, (self.frame.size.width - 4) * .5, 25)];
        [self addSubview:yo];
        tu = [[UILabel alloc]initWithFrame:CGRectMake(2, 56, (self.frame.size.width - 4) * .5, 25)];
        [self addSubview:tu];
        el = [[UILabel alloc]initWithFrame:CGRectMake(2, 83, (self.frame.size.width - 4) * .5, 25)];
        [self addSubview:el];
        nos = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .5, 29, (self.frame.size.width - 4) * .5, 25)];
        [self addSubview:nos];
        vos = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .5, 56, (self.frame.size.width - 4) * .5, 25)];
        [self addSubview:vos];
        ellos = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .5, 83, (self.frame.size.width - 4) * .5, 25)];
        [self addSubview:ellos];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
