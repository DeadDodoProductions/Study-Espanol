//
//  Launch.m
//  Study Español
//
//  Created by Evan Combs on 7/25/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "Launch.h"
#import "Home.h"
#import "Utilities.h"

@interface Launch ()

@end

@implementation Launch

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Launch.png"]];
    [imageView setFrame:CGRectMake((self.view.frame.size.width * .5f) - ((self.view.frame.size.width - 100) * .5f), (self.view.frame.size.height * .5f) - ((self.view.frame.size.width - 100) * .5f), self.view.frame.size.width - 100, self.view.frame.size.width - 100)];
    [self.view addSubview:imageView];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [header setHidden:true];
    [content setHidden:true];
}

-(void)viewDidAppear:(BOOL)animated
{
    [Utilities DeleteUnusedTags];
    
    Home *home = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
    [self presentViewController:home animated:false completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
