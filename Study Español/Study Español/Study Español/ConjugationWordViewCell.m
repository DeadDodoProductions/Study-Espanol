//
//  TableViewCell.m
//  Study Español
//
//  Created by Evan Combs on 5/22/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This cell is in the ViewWord class to display the conjugations of a verb

#import "ConjugationWordViewCell.h"

@implementation ConjugationWordViewCell
@synthesize tense, yo, tu, el, nos, vos, ellos;
///Initilization
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        tense = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, 25)];
        [tense setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:tense];
        UILabel *yoLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 29, 30, 25)];
        [yoLabel setText:@"yo: "];
        [yoLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:yoLabel];
        yo = [[UILabel alloc]initWithFrame:CGRectMake(32, 29, ((self.frame.size.width - 4) * .4), 25)];
        [self addSubview:yo];
        UILabel *tuLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 56, 30, 25)];
        [tuLabel setText:@"tu: "];
        [tuLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:tuLabel];
        tu = [[UILabel alloc]initWithFrame:CGRectMake(32, 56, (self.frame.size.width - 4) * .4, 25)];
        [self addSubview:tu];
        UILabel *elLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 83, 30, 25)];
        [elLabel setText:@"el: "];
        [elLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:elLabel];
        el = [[UILabel alloc]initWithFrame:CGRectMake(32, 83, (self.frame.size.width - 4) * .4, 25)];
        [self addSubview:el];
        UILabel *nosLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .4, 29, 35, 25)];
        [nosLabel setText:@"nos: "];
        [nosLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:nosLabel];
        nos = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .4 + 37, 29, (self.frame.size.width - 4) * .6, 25)];
        [self addSubview:nos];
        UILabel *vosLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .4, 56, 35, 25)];
        [vosLabel setText:@"vos: "];
        [vosLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:vosLabel];
        vos = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .4 + 37, 56, (self.frame.size.width - 4) * .6, 25)];
        [self addSubview:vos];
        UILabel *ellosLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .4, 83, 35, 25)];
        [ellosLabel setText:@"ellos: "];
        [ellosLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:ellosLabel];
        ellos = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .4 + 37, 83, (self.frame.size.width - 4) * .6, 25)];
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
