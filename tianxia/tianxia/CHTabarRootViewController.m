//
//  CHTabarRootViewController.m
//  行天下_我的
//
//  Created by 程勇辉 on 2017/7/3.
//  Copyright © 2017年 程勇辉. All rights reserved.
//

#import "CHTabarRootViewController.h"
#import "xintianxia-Prefix.pch"
@interface CHTabarRootViewController ()
@property(strong,nonatomic)CHHomePageViewController* homeVC;
@property(strong,nonatomic)CHTourismViewController* tourisVC;
@property(strong,nonatomic)CHCommunityViewController* communityVC;
@property(strong,nonatomic)CHServiceViewController* serviceVC;
@property(strong,nonatomic)CHPersonalViewController* personalVC;
@end

@implementation CHTabarRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBar.hidden=YES;
    [self createNavControlers];
    [self createtabbar];
}
-(void)createNavControlers
{
    _homeVC=[[CHHomePageViewController alloc]init];
    UINavigationController* nav1=[[UINavigationController alloc]initWithRootViewController:_homeVC];
    _tourisVC=[[CHTourismViewController alloc]init];
    UINavigationController* nav2=[[UINavigationController alloc]initWithRootViewController:_tourisVC];
    _communityVC=[[CHCommunityViewController alloc]init];
    UINavigationController* nav3=[[UINavigationController alloc]initWithRootViewController:_communityVC];
    _serviceVC=[[CHServiceViewController alloc]init];
    UINavigationController* nav4=[[UINavigationController alloc]initWithRootViewController:_serviceVC];
    _personalVC=[[CHPersonalViewController alloc]init];
    UINavigationController* nav5=[[UINavigationController alloc]initWithRootViewController:_personalVC];
    self.viewControllers=@[nav1,nav2,nav3,nav4,nav5];
}
-(void)createtabbar
{
    _backView=[[UIImageView alloc]initWithFrame:CGRectMake(0,Height-49*Height/568, Width, 49*Height/568)];
    _backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_backView];
    _backView.userInteractionEnabled=YES;
    
    NSArray* imageName1=@[@"Tab_HomePage_Noraml@2x",@"Tab_Tour_Normal@2x",@"Tab_SheQu_Noraml@2x",@"Tab_Server_Normal@2x",@"Tab_Mine_Normal@2x"];
    NSArray* imageName3=@[@"Tab_HomePage_Select@2x",@"Tab_Tour_Select@2x",@"Tab_SheQu_Select@2x",@"Tab_Server_Select@2x",@"Tab_Mine_Select@2x"];
    NSArray* imageName2=@[@"首页",@"旅游",@"社区",@"服务",@"我的"];
    CGFloat spaceX=(Width-46*Width/320*4)/5;
    for (int i=0; i<5; i++) {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(spaceX*(i+1)+35*Width/320*i, 5*Height/568, 20*Width/320, 20*Height/568);
        [btn setBackgroundImage:[UIImage imageNamed:imageName1[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageName3[i]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y+20*Width/320, 30*Width/320,30*Height/568 )];
        label.text=imageName2[i];
        label.textColor=[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:12];
        label.textAlignment=NSTextAlignmentLeft;
        [_backView addSubview:label];
        
        btn.tag=10+i;
        label.tag=10+i;
        if (i==4)
        {
            self.selectedIndex=i;
            btn.selected=YES;
            
        }
        [_backView addSubview:btn];
    }
}
-(void)btnAction:(UIButton*)sender
{
    //    根据标签栏按钮的索引值转换页面
    self.selectedIndex=sender.tag-10;
    NSArray* subViews=[_backView subviews];
    for (UIView* tempView in subViews)
    {
        //        isMemberOfClass判断前面的类是否与后面的类相匹配
        if ([tempView isMemberOfClass:[UIButton class]])
        {
            //            强转成按钮
            UIButton* btn=(UIButton*)tempView;
            if (btn.tag==sender.tag)
            {
                // 改变按钮显示的图片
                btn.selected=YES;
            }else
            {
                btn.selected=NO;
            }
        }else
        {
            UILabel* label=(UILabel*)tempView;
            if (label.tag==sender.tag) {
                [label setTextColor:[UIColor blueColor]];
            }else
            {
                [label setTextColor:[UIColor grayColor]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
