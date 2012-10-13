/*******************************************************************************
 *
 * Copyright 2012 Zack Grossbart
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ******************************************************************************/

#import "YouWonViewController.h"
#import "LevelMgr.h"
#import "StyleUtil.h"

@interface YouWonViewController ()

@end

@implementation YouWonViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self = [super initWithNibName:@"YouWonViewiPad" bundle:nibBundleOrNil];
    } else {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    
    
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    int i = [[LevelMgr getLevelMgr].levelIds indexOfObject:self.currentLevel.levelId];
    
    [self styleButtons];
    
    if (i == [[LevelMgr getLevelMgr].levelIds count] - 1) {
        /*
         * Then we're at the end and we hide the next button.  We should probably
         * put up some type of more levels coming soon method.
         */
        _nextButton.hidden = YES;
    } else {
        _nextButton.hidden = NO;
    }
}

-(void)styleButtons {
    [StyleUtil styleMenuButton:_nextButton];
    [StyleUtil styleMenuButton:_menuButton];
    [StyleUtil styleMenuButton:_replayButton];
}


-(void)viewDidUnload {
    [super viewDidUnload];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)viewDidAppear:(BOOL)animated {
    /*[UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.80];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromRight
                           forView:self.navigationController.view cache:NO];
    
    
    //[self.navigationController pushViewController:menu animated:YES];
    [UIView commitAnimations];
    */
    
    self.view.alpha = 0;
    
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.5];
    self.view.alpha = 1;
    [UIView commitAnimations];
    
}

-(IBAction)replayTapped:(id)sender {
    [self.layer refresh];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)nextTapped:(id)sender {
    int i = [[LevelMgr getLevelMgr].levelIds indexOfObject:self.currentLevel.levelId];
    
    if (i == [[LevelMgr getLevelMgr].levelIds count] - 1) {
        /* 
         * Then we're at the end and we just go back to the menu
         */
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        NSString *key = [[LevelMgr getLevelMgr].levelIds objectAtIndex:i + 1];
        [self.layer setLevel:[[LevelMgr getLevelMgr].levels objectForKey:key]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(IBAction)menuTapped:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)dealloc {
    [_nextButton release];
    [_replayButton release];
    [_menuButton release];
    [super dealloc];
}
@end
