//
//  Home.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"

@class SearchView;

@interface Home : BaseView
{
    int selected;
    bool searching;
    UIView *background;
    SearchView *searchView;
}
-(void)ExitSearch;

@end
