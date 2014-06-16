//
//  FeedViewController.m
//  wk2-fbhomework
//
//  Created by Engly Chang on 6/14/14.
//  Copyright (c) 2014 Engly Chang. All rights reserved.
//

#import "FeedViewController.h"


@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *feedContent;

- (void) delayLoad;
@property (nonatomic, assign) BOOL loading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loaderIcon;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;

@end

@implementation FeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    
    return self;}

- (void) delayLoad{
   //the animation that makes the feed move up like the keyboard
    NSTimeInterval animationDuration = 0.2;

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(7 << 16)
                     animations:^{
                         self.scrollContainer.frame = CGRectMake(0, 45, self.scrollContainer.frame.size.width, self.scrollContainer.frame.size.height);
                     }
                     completion:nil];
    //loading in/making the feed scroll
    self.scrollContainer.contentSize = CGSizeMake(320, self.feedContent.frame.size.height);

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.loaderIcon startAnimating];
    self.loading = YES;
    
    [self performSelector:@selector(delayLoad) withObject:nil afterDelay:2];
    
    
    // Configure the left button
    UIImage *leftButtonImage = [[UIImage imageNamed:@"search_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onLeftButton:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    // Configure the right button
    UIImage *rightButtonImage = [[UIImage imageNamed:@"person_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    

    //stylize the main ui nav bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:77/255.0f green:106/255.0f blue:164/255.0f alpha:1];
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    // Configure the title
    self.navigationItem.title = @"News Feed";
    
}

- (IBAction)onLeftButton:(id)sender {
   }

//- (IBAction)onRightButton:(id)sender {
    //SecondViewController *vc = [[SecondViewController alloc] init];
    //[self.navigationController pushViewController:vc animated:YES];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
