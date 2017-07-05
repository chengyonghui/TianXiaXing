//
//  MyProfileViewController.m
//  行天下_我的
//
//  Created by 程勇辉 on 2017/7/4.
//  Copyright © 2017年 程勇辉. All rights reserved.
//

#import "MyProfileViewController.h"
#import "xintianxia-Prefix.pch"
@interface MyProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray* dataSource;
@property(nonatomic,strong)NSArray* imageNames;
@property(nonatomic,strong)UITableView* tableView;

@end

@implementation MyProfileViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //    获取运用程序对象
    UIApplication* app=[UIApplication sharedApplication];
    //    获取运用程序的代理
    AppDelegate* delegate=(AppDelegate*)app.delegate;
    //    获取rootViewController的实例对象
    CHTabarRootViewController* rootVC=(CHTabarRootViewController*) delegate.window.rootViewController;
    //    隐藏自定义的tabbar（_backView）
    rootVC.backView.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0/255.0 green:63/255.0 blue:200/255.0 alpha:1];
    
    [self createDataSource];
    [self createTabelView];
    
}
-(void)createDataSource
{
    _dataSource=[NSMutableArray new];
    //    创建表格的数据源
    for (int i=0; i<3; i++) {
        NSMutableArray* arr=[NSMutableArray new];
        if (i==0) {
            NSString* str=@"头像";
            [arr addObject:str];
        }
        if (i==1) {
            for (int j=0; j<3; j++) {
                if (j==0) {
                    NSString* str=@"昵称";
                    [arr addObject:str];
                }
                if (j==1) {
                    NSString* str=@"性别";
                    [arr addObject:str];
                }
                if (j==2) {
                    NSString* str=@"常住地";
                    [arr addObject:str];
                }
            }
        }
        if (i==2) {
            for (int j=0; j<3; j++) {
                if (j==0) {
                    NSString* str=@"修改手机";
                    [arr addObject:str];
                }
                if (j==1) {
                    NSString* str=@"修改登录密码";
                    [arr addObject:str];
                }
                if (j==2) {
                    NSString* str=@"设置支付密码";
                    [arr addObject:str];
                }
            }
        }
        [_dataSource addObject:arr];
    }

}
-(void)createTabelView
{
    //    创建分组风格的表格
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
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
        if (indexPath.section==0) {
//            tableviewCell中Cell不能被点击
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(220, 5, 50, 50)];
            imageView.tag=10;
            [cell.contentView addSubview:imageView];
            
        }
    }
    //    通过tag获取label
    UIImageView* imageView=(UIImageView*)[cell.contentView viewWithTag:10];
    imageView.image=[UIImage imageNamed:@"mine_data_icon@3x"];
    imageView.userInteractionEnabled=YES;
    //    创建点击手势
    UITapGestureRecognizer* personViewTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personBtnTap:)];
    [imageView addGestureRecognizer:personViewTap];

    
    cell.textLabel.text=_dataSource[indexPath.section][indexPath.row];
    //设置挂件
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    if (indexPath.section==1) {
        
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text=@"行走的力量";
                break;
            case 1:
                cell.detailTextLabel.text=@"男";
                break;
            case 2:
                cell.detailTextLabel.text=@"江西省南昌市";
                break;
            default:
                break;
        }
    }
    if (indexPath.section==2) {
        
        if (indexPath.row==0) {
            cell.detailTextLabel.text=@"15083839769";
        }
    }
    return cell;
}
-(void)personBtnTap:(UITapGestureRecognizer*)sender
{
    NSLog(@"saaaaaaaaaaaa");
    
}

//改变单元格行高度，返回单元格行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }
    return 40;
}
//设置组距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
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
