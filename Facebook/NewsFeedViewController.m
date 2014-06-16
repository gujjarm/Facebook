//
//  NewsFeedViewController.m
//  Facebook
//
//  Created by Manish Gujjar on 6/15/14.
//  Copyright (c) 2014 Manish Gujjar. All rights reserved.
//

#import "NewsFeedViewController.h"

@interface NewsFeedViewController ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *feedIndicatorView;

@property (strong, nonatomic) IBOutlet UIScrollView *FeedScrollView;


@property (strong, nonatomic) IBOutlet UIImageView *feedImageView;



- (void)loadFeeds;

@end

@implementation NewsFeedViewController

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
    // Do any additional setup after loading the view from its nib.
    [self.FeedScrollView setBackgroundColor:[UIColor lightGrayColor]];
    [self.feedIndicatorView startAnimating];
    [self performSelector:@selector(loadFeeds) withObject:nil afterDelay:1];}

- (void)loadFeeds
{
    [self.feedIndicatorView stopAnimating];
    [self.feedImageView setHidden:false];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
