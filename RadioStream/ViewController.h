//
//  ViewController.h
//  RadioStream
//
//  Created by Max Mikheyenko on 5/10/13.
//  Copyright (c) 2013 Max Mikheyenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *playControl;
- (IBAction)togglePlay:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *state;

@end
