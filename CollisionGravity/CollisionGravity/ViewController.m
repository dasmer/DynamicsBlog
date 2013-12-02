//
//  ViewController.m
//  CollisionGravity
//
//  Created by dasmer on 12/1/13.
//  Copyright (c) 2013 Columbia University. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    UICollisionBehavior* _collision;
    NSInteger counter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView* square = [[UIView alloc] initWithFrame:
                      CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = [UIColor grayColor]; [self.view addSubview:square];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]]; [_animator addBehavior:_gravity];
    
    
    
    
    UIView* barrier = [[UIView alloc]
                       initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor redColor]; [self.view addSubview:barrier];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width,
                                    barrier.frame.origin.y); [_collision addBoundaryWithIdentifier:@"barrier"
                                                                                         fromPoint:barrier.frame.origin toPoint:rightEdge];
    
    _collision.translatesReferenceBoundsIntoBoundary = YES; [_animator addBehavior:_collision];
    _collision.collisionDelegate = self;
    
    UIDynamicItemBehavior* itemBehaviour =
    [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
    itemBehaviour.elasticity = 0.7; [_animator addBehavior:itemBehaviour];
    
    
    
}


- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item
   withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    
    [UIView animateWithDuration:0.1 animations:^{
        ((UIView *) item).backgroundColor = color;
    }];
    
    if (counter < 2) {
        counter++;
        UIView* square = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
        square.backgroundColor = [UIColor grayColor]; [self.view addSubview:square];
        [_collision addItem:square]; [_gravity addItem:square];
        
//        UIAttachmentBehavior* attach = [[UIAttachmentBehavior alloc] initWithItem:self.view attachedToItem:square];
//        [_animator addBehavior:attach];
                                        }

    
    NSLog(@"Boundary contact occurred - %@", identifier);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
