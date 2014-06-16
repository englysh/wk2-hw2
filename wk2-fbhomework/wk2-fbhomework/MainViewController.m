//
//  MainViewController.m
//  wk2-fbhomework
//
//  Created by Engly Chang on 6/14/14.
//  Copyright (c) 2014 Engly Chang. All rights reserved.
//

#import "MainViewController.h"
#import "FeedViewController.h"
@interface MainViewController ()

// Declare some methods that will be called when the keyboard is about to be shown or hidden
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

- (IBAction)onTapOutside:(id)sender; //dismissing the keyboard

- (IBAction)onUsernameChange:(id)sender;
- (IBAction)onPasswordChange:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
- (IBAction)onTouchLoginButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *PassWordField;
@property (weak, nonatomic) IBOutlet UITextField *UserNameField;

@property (weak, nonatomic) IBOutlet UIView *TopLoginView;
@property (weak, nonatomic) IBOutlet UILabel *SignUpLink;

- (void) checkLogin;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loaderIcon;
@property (nonatomic, assign) BOOL loading;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.UserNameField.Placeholder = @"Email or phone number";
    
    self.PassWordField.SecureTextEntry = YES;
    self.PassWordField.Placeholder = @"Password";
    
    self.LoginButton.enabled = NO;
    self.LoginButton.layer.cornerRadius = 4;
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) checkLogin {
    // Whatever is in here will be run after the delay
    if ([[self.UserNameField.text lowercaseString] isEqualToString:@"d"] && [[self.PassWordField.text lowercaseString] isEqualToString:@"d"]){
        
        //stop the loader
        [self.loaderIcon stopAnimating];
        self.loading = NO;
        
        UIViewController *vc = [[FeedViewController alloc] init];
        
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        //initwithroot: what is the first view you want to present, in this case: vc
        
        //vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;// Rises from below
        //vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve; // Fade
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; // Flip
        //vc.modalTransitionStyle = UIModalTransitionStylePartialCurl; // Curl
        
        
        [self presentViewController:nvc animated:YES completion:nil];
        //present the navigation
        

        
        
 
    } else {
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Idiot" message:@"You don't even remember your own password." delegate:self cancelButtonTitle:@"Argg" otherButtonTitles:nil];
        [errorView show];

        [self.loaderIcon stopAnimating];
        self.loading = NO;
        
        [self.LoginButton setTitle:@"Log In" forState:UIControlStateNormal];

    }
    
  

   }


- (IBAction)onTapOutside:(id)sender {
    [self.view endEditing:YES];
    //ends editing and dismiss keyboard
    
}



- (IBAction)onTouchLoginButton:(id)sender {
    
    [self performSelector:@selector(checkLogin) withObject:nil afterDelay:2];
   
    [self.loaderIcon startAnimating];
    self.loading = YES;
    
    [self.LoginButton setTitle:@"Logging In" forState:UIControlStateNormal];
    
    
}

- (IBAction)onUsernameChange:(id)sender {
    NSLog(@"Username");
    UITextField* f = [[UITextField alloc] init];
    f.autocorrectionType = UITextAutocorrectionTypeNo;
    
    //if either field is empty, login button is disabled
   if ([self.UserNameField.text isEqualToString:@""] || [self.PassWordField.text isEqualToString:@""])
    {
        self.LoginButton.enabled = NO;
        
    }
    else
    {
        self.LoginButton.enabled = YES;
    }
    

}

- (IBAction)onPasswordChange:(id)sender {
    NSLog(@"Password");
    UITextField *f = [[UITextField alloc] init];
    f.autocorrectionType = UITextAutocorrectionTypeNo;
    

    //if either field is empty, login button is disabled
    if ([self.UserNameField.text isEqualToString:@""] || [self.PassWordField.text isEqualToString:@""])
    {
        self.LoginButton.enabled = NO;
        
    }
    else
    {
        self.LoginButton.enabled = YES;
    }
    

}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    //animating the top part of login screen (logo + fields + login btn)
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.TopLoginView.frame = CGRectMake(self.TopLoginView.frame.origin.x, self.TopLoginView.frame.origin.y -(kbSize.height)/5, self.TopLoginView.frame.size.width, self.TopLoginView.frame.size.height);
                     }
                     completion:nil];
    //animating the sign up for fb link
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.SignUpLink.frame = CGRectMake(self.SignUpLink.frame.origin.x, self.SignUpLink.frame.origin.y -(kbSize.height)/2.2, self.SignUpLink.frame.size.width, self.SignUpLink.frame.size.height);
                     }
                     completion:nil];

}
- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    NSLog(@"curvevalue %d", curveValue.intValue);
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    //animate the top part (logo + login fields + login)
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.TopLoginView.frame = CGRectMake(self.TopLoginView.frame.origin.x, self.TopLoginView.frame.origin.y+(kbSize.height)/5, self.TopLoginView.frame.size.width, self.TopLoginView.frame.size.height);
                     }
                     completion:nil];
    
    //animate the sign up for fb link
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.SignUpLink.frame = CGRectMake(self.SignUpLink.frame.origin.x, self.SignUpLink.frame.origin.y+(kbSize.height)/2.2, self.SignUpLink.frame.size.width, self.SignUpLink.frame.size.height);
                     }
                     completion:nil];

}
@end
