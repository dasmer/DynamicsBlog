//
//  ViewController.m
//  PushPractice
//
//  Created by dasmer on 12/1/13.
//  Copyright (c) 2013 Columbia University. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) UIView *squareView;
@property (strong,nonatomic) UIDynamicAnimator *animator;
@property (strong,nonatomic) UIPushBehavior *pushBehavior;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self createGestureRecognizer];
    [self createSmallSquareView];
    [self createAnimatorAndBehaviors];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createSmallSquareView{ self.squareView =
    [[UIView alloc] initWithFrame:
     CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    self.squareView.backgroundColor = [UIColor greenColor];
    self.squareView.center = self.view.center;
    [self.view addSubview:self.squareView];
}

- (void) createGestureRecognizer{ UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]; [self.view addGestureRecognizer:tapGestureRecognizer];
}


- (void) createAnimatorAndBehaviors{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    /* Create collision detection */
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]
                                      initWithItems:@[self.squareView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    self.pushBehavior = [[UIPushBehavior alloc]
                         initWithItems:@[self.squareView]
                         mode:UIPushBehaviorModeContinuous];
    [self.animator addBehavior:collision];
    [self.animator addBehavior:self.pushBehavior];
}

- (void) handleTap:(UITapGestureRecognizer *)paramTap{
    NSLog(@"tapped");
    /* Get the angle between the center of the square view
     and the tap point */
    CGPoint tapPoint = [paramTap locationInView:self.view];
    CGPoint squareViewCenterPoint = self.squareView.center;
    /* Calculate the angle between the center point of the square view and
     the tap point to find out the angle of the push
     Formula for detecting the angle between two points is:
     arc tangent 2((p1.x - p2.x), (p1.y - p2.y)) */
    CGFloat deltaX = tapPoint.x - squareViewCenterPoint.x;
    CGFloat deltaY = tapPoint.y - squareViewCenterPoint.y;
    CGFloat angle = atan2(deltaY, deltaX);
    [self.pushBehavior setAngle:angle];
    /* Use the distance between the tap point and the center of our square
     view to calculate the magnitude of the push
     Distance formula is:
     square root of ((p1.x - p2.x)^2 + (p1.y - p2.y)^2) */
    CGFloat distanceBetweenPoints =
    sqrt(pow(tapPoint.x - squareViewCenterPoint.x, 2.0) +
         pow(tapPoint.y - squareViewCenterPoint.y, 2.0));
    [self.pushBehavior setMagnitude:distanceBetweenPoints / 30.0f];


}


@end