//
//  ViewController.m
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 29/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "RedditTableViewCell.h"
#import "RedditFeed.h"
#import "RedditViewModel.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIImageView *imageView;
@property NSArray *feeds;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[RedditViewModel sharedInstance] initialize];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.feeds = [NSArray array];
    
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView setClipsToBounds:YES];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:JSONObtainedNotification
                                               object:nil];
    
}


- (void) reloadTable: (NSNotification *) notification
{
    self.feeds = notification.object;
    
    [self.tableView reloadData];
}

#pragma mark Table Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RedditTableViewCell"];
    
    RedditFeed *feed = [self.feeds objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = feed.title;
    cell.authorLabel.text = feed.author;
    cell.commentsLabel.text = feed.commentsNum;
    cell.hoursAgoLabel.text = feed.createdOn;
    [cell setImageURL:feed.thumbnailImageURL];
    
    return cell;
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender
{

    CGPoint point = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    RedditTableViewCell *cell = (RedditTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    [self imgToFullScreen:cell];
}

-(void)imgToFullScreen:(RedditTableViewCell *) cell
{
        
    __block CGRect prevFrame;
    self.imageView.image = cell.thumbnailImageView.image;
    if ([UIScreen mainScreen].bounds.size.height != self.imageView.frame.size.height) {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            //save previous frame
            prevFrame = self.imageView.frame;
            [self.imageView setFrame:[[UIScreen mainScreen] bounds]];
        }completion:^(BOOL finished){
        }];
        return;
    } else {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            [self.imageView setFrame:prevFrame];
        }completion:^(BOOL finished){
          
        }];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
