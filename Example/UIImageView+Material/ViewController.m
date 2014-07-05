//
//  INViewController.m
//  UIImageView+Material
//
//  Created by Tom Li on 07/05/2014.
//  Copyright (c) 2014 Tom Li. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+Material/UIImageView+Material.h>

@interface ViewController ()

@property (strong, nonatomic) UIImage *origImage;
@property (assign, nonatomic) BOOL hidden;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.origImage = [UIImage imageNamed:@"demo"];
    [self.imageView setImage:self.origImage];
    self.imageView.layer.opacity = 0.0;
    self.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender
{
    if (self.hidden) {
        [self.imageView fadeInWithDuration:1.0];
        self.hidden = NO;
        [self.button setTitle:@"Fade Out" forState:UIControlStateNormal];
    } else {
        [self.imageView fadeOutWithDuration:1.0];
        self.hidden = YES;
        [self.button setTitle:@"Fade In" forState:UIControlStateNormal];
    }
}
@end
