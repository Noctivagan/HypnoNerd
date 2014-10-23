//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Tom Anderson on 9/19/14.
//  Copyright (c) 2014 Maritom LLC. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface

BNRHypnosisViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *textField;

@end
@implementation BNRHypnosisViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";
        
        // Create a UIImage from a file
        UIImage *image = [ UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = image;
    }
    return self;
}
- (void) loadView
{
    // Create a view
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40, -30, 240, 30);
    UITextField *textField = [[ UITextField alloc] initWithFrame:textFieldRect];
    
    // Setting the border style on the text field will allow us to see ti more easily
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me!";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    [backgroundView addSubview:textField];
    self.textField = textField;
    
    // Set it as *the* view of this view controller
    self.view = backgroundView;
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:0.0 options:0 animations:^{
        CGRect frame = CGRectMake(40, 70, 240, 30);
        self.textField.frame = frame;
    }completion:NULL];
}
- (BOOL) textFieldShouldReturn: (UITextField *)textField
{
    NSLog(@"%@", textField.text);
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    
    return YES;
}

- (void) drawHypnoticMessage: (NSString *)message
{
    for (int i=0; i<20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        // Configure the label's colors and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.text = message;
        
        // This method resizes the label, which will be relative
        // to the text that it is displaying
        [messageLabel sizeToFit];
        
        // Get a random x value that fits within the hypnosis view's wideth
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random() % width;
        
        // get a random y value that ifts within the hypnosis view's height
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random() % height;
        
        // Update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        // Add the frame to the hierarchy
        [self.view addSubview:messageLabel];
        
        // Set the label's initial alpha
        messageLabel.alpha = 0.0;
        
        // Animate the alpha to 1.0
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{messageLabel.alpha = 1.0;} completion:^(BOOL ffinished){
            NSLog(@"First animation finished");
        }];
        
        [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:0 animations:^{[UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{messageLabel.center = self.view.center;}];
            [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                int x = arc4random() % width;
                int y = arc4random() % height;
                messageLabel.center = CGPointMake(x,y);
            }];
        } completion:^(BOOL sfinished){
            NSLog(@"Second animation finished");
        }];
         
        UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
        
        
    }
}

@end
