//
//  MainViewController.m
//  navDemo
//
//  Created by stonemover on 2017/10/20.
//  Copyright © 2017年 stonemover. All rights reserved.
//

#import "MainViewController.h"

#define IS_IOS_VERSION_11 (([[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0)? (YES):(NO))

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"TestNav";
    UIButton * leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    leftButton.backgroundColor=[UIColor redColor];
    [leftButton setTitle:@"Hello" forState:UIControlStateNormal];
    [self initBarItem:leftButton withType:0];
    
    
    UIView * rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    rightView.backgroundColor=[UIColor greenColor];
    [self initBarItem:rightView withType:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//0:leftBarButtonItems,1:rightBarButtonItems
- (void)initBarItem:(UIView*)view withType:(int)type{
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    //解决按钮不靠左 靠右的问题.iOS 11系统需要单独处理
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -16;//这个值可以根据自己需要自己调整
    switch (type) {
        case 0:
            if (!IS_IOS_VERSION_11) {
                self.navigationItem.leftBarButtonItems =@[spaceItem,buttonItem];
            }else{
                self.navigationItem.leftBarButtonItems =@[buttonItem];
            }
            break;
        case 1:
            if (!IS_IOS_VERSION_11) {
                self.navigationItem.rightBarButtonItems =@[spaceItem,buttonItem];
            }else{
                self.navigationItem.rightBarButtonItems =@[buttonItem];
            }
            break;
            
        default:
            break;
    }
}

-(void)viewDidLayoutSubviews{
    if (!IS_IOS_VERSION_11) return;
    UINavigationItem * item=self.navigationItem;
    NSArray * array=item.leftBarButtonItems;
    if (array&&array.count!=0){
        UIBarButtonItem * buttonItem=array[0];
        UIView * view =[[[buttonItem.customView superview] superview] superview];
        NSArray * arrayConstraint=view.constraints;
        for (NSLayoutConstraint * constant in arrayConstraint) {
            if (fabs(constant.constant)==16) {
                constant.constant=0;
            }
        }
    }
}

@end
