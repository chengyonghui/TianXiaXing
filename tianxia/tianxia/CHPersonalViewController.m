//
//  CHPersonalViewController.m
//  行天下_我的
//
//  Created by 程勇辉 on 2017/7/3.
//  Copyright © 2017年 程勇辉. All rights reserved.
//

#import "CHPersonalViewController.h"
#import "MyProfileViewController.h"
#import "xintianxia-Prefix.pch"
@interface CHPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray* dataSource;
@property(nonatomic,strong)NSArray* imageNames;
@property(nonatomic,strong)UITableView* tableView;

@end

@implementation CHPersonalViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //    获取运用程序对象
    UIApplication* app=[UIApplication sharedApplication];
    //    获取运用程序的代理
    AppDelegate* delegate=(AppDelegate*)app.delegate;
    //    获取rootViewController的实例对象
    CHTabarRootViewController * rootVC=(CHTabarRootViewController*) delegate.window.rootViewController;
    //    显示自定义的tabbar（_backView）
    rootVC.backView.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;//  防止下滑
     self.tableView.showsHorizontalScrollIndicator = NO;
    //设置导航条右边的按钮图片 0 63 132
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Order_Tour_Select@3x"] style:UIBarButtonItemStyleDone target:self action:@selector(btnAction:)];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:1/255.0 green:88/255.0 blue:169/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    _imageNames=@[@"Mine_MyOrderIcon@3x",@"Mine_MyWalletIcon@3x",@"Mine_MyImfoIcon@3x",@"Mine_MyCommentIcon@3x",@"Mine_MyCollectIcon@3x",@"Mine_MyDistributeIcon@3x",@"Mine_MySettingIcon@3x"];
    _dataSource=[NSMutableArray new];
    
    //    创建表格的数据源
    for (int i=0; i<3; i++) {
        NSMutableArray* arr=[NSMutableArray new];
        if (i==0) {
            NSString* str=@"我的订单";
            [arr addObject:str];
        }
        if (i==1) {
            NSString* str=@"我的钱包";
            [arr addObject:str];
        }
        if (i==2) {
            for (int j=0; j<5; j++) {
                if (j==0) {
                    NSString* str=@"常用信息";
                    [arr addObject:str];
                }
                if (j==1) {
                    NSString* str=@"我的评价";
                    [arr addObject:str];
                }
                if (j==2) {
                    NSString* str=@"我的收藏";
                    [arr addObject:str];
                }
                if (j==3) {
                    NSString* str=@"我的发布";
                    [arr addObject:str];
                }
                if (j==4) {
                    NSString* str=@"我的设置";
                    [arr addObject:str];
                }
            }
        }
        [_dataSource addObject:arr];
    }
    
    //    创建分组风格的表格
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,self.view.bounds.size.height-40*Height/568) style:UITableViewStyleGrouped];
    [self createHead];
    
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
}
-(void)createHead
{
    UIView* headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220*Height/568)];
    headView.backgroundColor=[UIColor whiteColor];
    UIImageView* titleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 160*Height/568)];
    titleImageView.image=[UIImage imageNamed:@"Mine_TopVWBg@3x"];
    [headView addSubview:titleImageView];
    _tableView.tableHeaderView=headView;
    
    UIImageView* personImageView=[[UIImageView alloc]initWithFrame:CGRectMake(Width*2/5, headView.frame.size.height*11/40, Width/5, Width/5)];
    personImageView.image=[UIImage imageNamed:@"Mine_DefaultHead@3x"];
    [headView addSubview:personImageView];
    personImageView.userInteractionEnabled=YES;
    //    创建点击手势
    UITapGestureRecognizer* personTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personBtnTap:)];
    [personImageView addGestureRecognizer:personTap];
    
    UILabel* together=[[UILabel alloc]initWithFrame:CGRectMake(Width*2/5-10, personImageView.frame.origin.y+65, Width/4, 30*Height/568)];
    together.text=@"一起去旅游";
    together.font=[UIFont systemFontOfSize:15];
    together.textColor=[UIColor whiteColor];
    together.textAlignment=NSTextAlignmentRight;
    [headView addSubview:together];
    
    
    
    
    UIButton* singBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    singBtn.frame=CGRectMake(30*Width/320, 170*Height/568, 120*Width/320, 30*Height/568);
    [singBtn setImage:[UIImage imageNamed:@"Mine_Sign_New@3x"] forState:UIControlStateNormal];
    [singBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [singBtn setTitle:@"签到赚积分" forState:UIControlStateNormal];
    singBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    singBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10*Height/568, 0, 0);
    [singBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [headView addSubview:singBtn];
    [singBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    UIButton* footprintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    footprintBtn.frame=CGRectMake(180*Width/320, 170*Height/568, 120*Width/320, 30*Height/568);
    [footprintBtn setImage:[UIImage imageNamed:@"Mine_BrowserHistory_New@3x"] forState:UIControlStateNormal];
    [footprintBtn setTitle:@"我的足迹" forState:UIControlStateNormal];
    footprintBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [footprintBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    footprintBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10*Height/568, 0, 0);
    [footprintBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [headView addSubview:footprintBtn];
    [footprintBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* grayView=[[UIView alloc]initWithFrame:CGRectMake(0, footprintBtn.frame.origin.y+40*Height/568, [UIScreen mainScreen].bounds.size.width, 10*Height/568)];
    grayView.backgroundColor=[UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
    [headView addSubview:grayView];
}
-(void)personBtnTap:(UITapGestureRecognizer*)sender
{
    NSLog(@"sdfasdfasdf");
    MyProfileViewController* myProfileVC=[[MyProfileViewController alloc]init];
    [self.navigationController pushViewController:myProfileVC animated:YES];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:_tableView.contentOffset.y / 100]] forBarMetrics:UIBarMetricsDefault];
    
}
-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return _dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [_dataSource[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellID=@"cell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];

    }

    
    cell.textLabel.text=_dataSource[indexPath.section][indexPath.row];
    //设置挂件
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section==0) {
        cell.detailTextLabel.text=@"查看全部订单";
        cell.imageView.image=[UIImage imageNamed:_imageNames[indexPath.row]];
    }
    if (indexPath.section==1) {
        cell.imageView.image=[UIImage imageNamed:_imageNames[indexPath.row+1]];
    }
    if (indexPath.section==2) {
        cell.imageView.image=[UIImage imageNamed:_imageNames[indexPath.row+2]];
    }
    return cell;
}
//返回每个区的尾部视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 0;
    }
    _tableView.sectionFooterHeight = 0;
    if (section==0) {
        return 60*Height/568;
    }
    return 50*Height/568;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 60*Height/568)];
        view.backgroundColor=[UIColor whiteColor];
        NSArray* imageName=@[@"Mine_UnPayIcon@3x",@"Mine_UnTripIcon@3x",@"Mine_UnCommentIcon@3x",@"Mine_RefundIcon@3x"];
        NSArray* titleName=@[@"待支付",@"待出行",@"待评价",@"退款"];
        CGFloat spaceX=([UIScreen mainScreen].bounds.size.width-60*Width/320*3)/4;
        for (int i=0; i<4; i++) {
            UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(spaceX*(i+1)+40*Width/320*i, 10*Height/568, 25*Width/320, 25*Height/568);
            [btn setBackgroundImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
            
            UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x-10*Width/320, btn.frame.origin.y+15*Height/568, 40*Width/320,40*Height/568 )];
            label.text=titleName[i];
            label.textColor=[UIColor grayColor];
            label.font=[UIFont systemFontOfSize:12];
            label.textAlignment=NSTextAlignmentCenter;
            [view addSubview:label];
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }
        return view;
    }
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 50*Height/568)];
    view.backgroundColor=[UIColor whiteColor];
    NSArray* imageName=@[@"0.00元",@"2043分",@"0张"];
    NSArray* titleName=@[@"余额",@"积分",@"劵包"];
    CGFloat spaceX=([UIScreen mainScreen].bounds.size.width-55*Width/320*3)/4;
    for (int i=0; i<3; i++) {
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(spaceX*(i+1)+55*Width/320*i, 0, 60*Width/320, 30*Height/568)];
        label.text=imageName[i];
        label.font=[UIFont systemFontOfSize:17];
        label.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label];
        
        UILabel* label1=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y+20*Height/568, 40*Width/320, 40*Height/568)];
        label1.text=titleName[i];
        label1.font=[UIFont systemFontOfSize:13];
        label1.textColor=[UIColor grayColor];
        label1.textAlignment=NSTextAlignmentRight;
        [view addSubview:label1];
    }
    return view;
}
//可以监听到当前用户点击的事那一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    //    获取数据源的表题
//    NSString* title=_dataSource[indexPath.section][indexPath.row];
//    _detailVC=[[detailViewController alloc]init];
//    _detailVC.titleStr=title;
//    [self.navigationController pushViewController:_detailVC animated:YES];
}
-(void)btnAction:(UIButton*)sender
{
    NSLog(@"asfasd");
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
