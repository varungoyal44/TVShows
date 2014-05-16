//
//  TVSMainViewController.m
//  TVShows
//
//  Created by Varun Goyal on 5/5/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "TVSMainViewController.h"
#import "TVSScrollableCellTableViewCell.h"
#import "TVSShowModel.h"
#import "TVSShowBlockView.h"

#define MARGIN 15.0
#define HEADER_HEIGHT 35


@interface TVSMainViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *dictionaryOfShows;
@end

@implementation TVSMainViewController
@synthesize tableView = _tableView;
@synthesize dictionaryOfShows = _dictionaryOfShows;



#pragma mark- Lifecycle
-(void) viewDidLoad
{
    [super viewDidLoad];
    
    // To parse the json and get show details
    self.dictionaryOfShows = [[NSMutableDictionary alloc] init];
    [self getShows];
    
    // To set background colors
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"App_Background"]]];
}



#pragma mark- Utilities
-(void) getShows
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JSON-Response" ofType:@"txt"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF8StringEncoding error:nil];
    NSArray *scheduleArray = (NSArray *) [jsonDictionary objectForKey:@"schedules"];
    
    for (NSDictionary *thisShow in scheduleArray)
    {
        // To create TVSShowModel
        TVSShowModel *thisShowModel = [[TVSShowModel alloc] init];
        
        // To get image URL
        thisShowModel.imageURLstring = [[thisShow objectForKey:@"program"] objectForKey:@"14"];
        if(!thisShowModel.imageURLstring)
            thisShowModel.imageURLstring = [thisShow objectForKey:@"21"];
        
        // To get show title
        thisShowModel.title = [[thisShow objectForKey:@"program"] objectForKey:@"11"];
        
        // To get show categories
        NSString *categories = [[thisShow objectForKey:@"program"] objectForKey:@"13"];
        NSArray *categoryArray = [categories componentsSeparatedByString:@","];
        
        for(NSString *thisCategory in categoryArray)
        {
            [self addShow:thisShowModel ForCategory:thisCategory];
        }
    }
}


-(void) addShow:(TVSShowModel *) show ForCategory:(NSString *) category
{
    // To add the show to the list of shows in that category; if the category exists and there are some other shows in that category
    if ([self.dictionaryOfShows.allKeys containsObject:category])
    {
        NSArray *arrayOfShowsInThisCategory = (NSArray *)[self.dictionaryOfShows objectForKey:category];
        
        NSMutableArray *mutableArrayOfShowsInThisCategory = [NSMutableArray arrayWithArray:arrayOfShowsInThisCategory];
        [mutableArrayOfShowsInThisCategory addObject:show];

        [self.dictionaryOfShows setObject:mutableArrayOfShowsInThisCategory forKey:category];
        return;
    }
    
    // To add the show and category to the show
    NSArray *newArrayOfShowsInThisCategory = [NSArray arrayWithObject:show];
    [self.dictionaryOfShows setObject:newArrayOfShowsInThisCategory forKey:category];
}



#pragma mark- UITableView DataSource Delegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dictionaryOfShows.allKeys.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    TVSScrollableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // To clear the scroll view...
    for (UIView *thisView in cell.scrollView.subviews)
    {
        [thisView removeFromSuperview];
    }
    [cell.scrollView setContentSize:CGSizeMake(0, cell.scrollView.frame.size.height)];
    
    
    // To add the shows to the scrollview
    NSArray *arrayOfShowsInCategory = [self.dictionaryOfShows.allValues objectAtIndex:indexPath.section];
    CGPoint newBlockPosition = CGPointMake(MARGIN, 5);
    
    for (TVSShowModel *thisShow in arrayOfShowsInCategory)
    {
        TVSShowBlockView *newBlock = [[TVSShowBlockView alloc] initWithPosition:newBlockPosition WithShowModel:thisShow];
        newBlockPosition.x = newBlockPosition.x + newBlock.frame.size.width + MARGIN;
        [cell.scrollView addSubview:newBlock];
        [cell.scrollView setContentSize:CGSizeMake(newBlockPosition.x, cell.scrollView.frame.size.height)];
    }
    
    
    return cell;
}



#pragma mark- UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_HEIGHT;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // To get the header title
    NSString *titleString = [self.dictionaryOfShows.allKeys objectAtIndex:section];
    
    // To create new header view
    CGFloat width = CGRectGetWidth(tableView.bounds);
    UIView *cellHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, HEADER_HEIGHT)];
    //[cellHeaderView setBackgroundColor:[UIColor greenColor]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, 0, width, HEADER_HEIGHT)];
    [titleLabel setTextColor:[UIColor yellowColor]];
    [titleLabel setAlpha:0.6];
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:14]];
    [titleLabel setText:titleString];
    [cellHeaderView addSubview:titleLabel];
    
    return cellHeaderView;
}
@end