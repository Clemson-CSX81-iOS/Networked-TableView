//
//  MyTableViewController.m
//  Networked TableView
//
//  Created by Douglas Edmonson on 6/27/12.
//  Copyright (c) 2012 Clemson University. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyTweetCell.h"
#import "AFNetworking.h"

@interface MyTableViewController ()

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, weak) UIActivityIndicatorView *activityView;
@property (nonatomic, copy) NSString *searchString;

@end

@implementation MyTableViewController

@synthesize results = _results;
@synthesize activityView = _activityView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchString = @"https://search.twitter.com/search.json?q=iphone&lang=en";
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIActivityIndicatorView *activView = [[UIActivityIndicatorView alloc] 
                                          initWithFrame:CGRectMake(5, 5, 20, 20)];
    self.activityView = activView;
    [titleView addSubview:activView];
    
    self.navigationItem.titleView = titleView;
    
    self.activityView.hidden = YES;

    NSURL *url = [NSURL URLWithString:self.searchString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation 
                                         JSONRequestOperationWithRequest:request 
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
                                             [self.activityView stopAnimating];
                                             self.activityView.hidden = YES;
                                             self.results = [json valueForKeyPath:@"results"];
                                             [self.tableView reloadData];
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             [self.activityView stopAnimating];
                                             self.activityView.hidden = YES;
                                         }];
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    [operation start];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"my tweet cell";
    MyTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    NSDictionary *tweet = [self.results objectAtIndex:indexPath.row];
    
    cell.userName.text = [tweet objectForKey:@"from_user"];
    cell.tweetText.text = [tweet objectForKey:@"text"];
    NSURL *imageURL = [NSURL URLWithString:[tweet objectForKey:@"profile_image_url"]];
    [cell.avatar setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]];
    
    [cell.tweetText flashScrollIndicators];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)refresh:(id)sender {    
    self.results = [NSArray array];
    [self.tableView reloadData];
    
    NSURL *url = [NSURL URLWithString:self.searchString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation 
                                         JSONRequestOperationWithRequest:request 
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
                                             [self.activityView stopAnimating];
                                             self.activityView.hidden = YES;
                                             self.results = [json valueForKeyPath:@"results"];
                                             [self.tableView reloadData];
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             [self.activityView stopAnimating];
                                             self.activityView.hidden = YES;
                                         }];
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    [operation start];
}
@end
