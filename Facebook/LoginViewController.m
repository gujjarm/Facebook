//
//  LoginViewController.m
//  Facebook
//
//  Created by Manish Gujjar on 6/13/14.
//  Copyright (c) 2014 Manish Gujjar. All rights reserved.
//

#import "LoginViewController.h"
#import "NewsFeedViewController.h"

@interface LoginViewController ()
- (IBAction)onTap:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *LoginButton;

@property (strong, nonatomic) IBOutlet UITextField *UserNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTextField;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *LoginActivityIndicator;

@property (strong, nonatomic) IBOutlet UIView *loginView;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

- (IBAction)onUserNameEntered:(id)sender;
- (IBAction)onPasswordEntered:(id)sender;
- (IBAction)onLoginButton:(id)sender;

- (void)checkCredentials;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    self.LoginButton.enabled = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
 
    [ self.view endEditing:(YES)];
}


- (IBAction)onUserNameEntered:(id)sender {
    
    if(self.PasswordTextField.hasText){
        self.LoginButton.enabled=true;
    }
    else {
        self.LoginButton.enabled=false;
    }
}



- (IBAction)onPasswordEntered:(id)sender {
    
    if (self.UserNameTextField.hasText) {
        self.LoginButton.enabled=true;
    }
    else {
        self.LoginButton.enabled=false;
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
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.loginView.frame.size.height, self.loginView.frame.size.width, self.loginView.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    // CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    // NSLog(@"Down - Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginView.frame = CGRectMake(0,  // X-axis
                                                           // I feel like this shouldn't be hard-coded, but it works...
                                                           0, // Y-axis
                                                           self.loginView.frame.size.width,
                                                           self.loginView.frame.size.height);
                     }
                     completion:nil];
}



- (IBAction)onLoginButton:(id)sender {
    
    [ self.view endEditing:(YES)];

    [self.LoginActivityIndicator startAnimating];

    UIImage *buttonImage = [UIImage imageNamed:@"LoggingIn.png"];
    
    [self.LoginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
 
    
    [self performSelector:@selector(checkCredentials)withObject:nil afterDelay:1];
    
}
- (void) checkCredentials{
    NSLog(@"Inside Check Credentials");
    if ([self.PasswordTextField.text isEqualToString:@"password"]) {
        NSLog(@"Correct Password");
        NewsFeedViewController *vc = [[NewsFeedViewController alloc] init];
         vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
         [self presentViewController:vc animated:YES completion:nil];
        
    }
    else{
        NSLog(@"Incorrect Password");
        [self.LoginActivityIndicator stopAnimating];
        
        UIImage *buttonImage = [UIImage imageNamed:@"LogIn.png"];
        
        [self.LoginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
        UIAlertView *alertview = [[ UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertview show];
    }
}


@end
