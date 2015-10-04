//
//  RootViewController.m
//  denglu
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 jydong. All rights reserved.
//

#import "RootViewController.h"
#import "Factory.h"
#import "UIView+Addition.h"
#import "MyHelper.h"
#import "AFNetworking.h"
#import "NetRequestPrefixHeader.pch"

@interface RootViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *name;
@property (nonatomic,strong) UITextField *secret;
@property (nonatomic,strong) UITextField *email;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

- (void)createView {
    self.name = [[UITextField alloc]initWithFrame:CGRectMake(LeftDistance, 20, ScreenWidth-2*LeftDistance, Default)];
    _name.placeholder = @"请输入账号";
    self.secret = [[UITextField alloc]initWithFrame:CGRectMake(LeftDistance, 100, ScreenWidth-2*LeftDistance  , Default)];
    _secret.placeholder = @"请输入密码";
    _email = [[UITextField alloc]initWithFrame:CGRectMake(LeftDistance, 180, ScreenWidth- 2*LeftDistance, Default)];
    _email.placeholder = @"请输入邮箱";
    
    [self.view addSubview:_email];
    [self.view addSubview:self.name];
    [self.view addSubview:self.secret];
    NSArray *arr = @[@"注册",@"登录",@"退出"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [Factory createButtonWithTitle:arr[i] frame:CGRectMake(LeftDistance, 300+i*(Default+ControlDistance), self.view.width-2*LeftDistance, Default) target:self selector:@selector(buttonDidClicked:)];
        button.tag = 100 + i;
        [self.view addSubview:button];
    }
}
- (void)buttonDidClicked:(UIButton *)button
{
    switch (button.tag) {
        case 100:[self registerRequest];break;
        case 101:[self sendLoginRequest];break;
        case 102:[self tuichuRequest];break;
        default:break;
    }
}
//注册
- (void)registerRequest {
    NSDictionary *dic = @{@"username":self.name.text,@"password":self.secret.text,@"email":self.email.text};
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage POST:[NSString stringWithFormat:@"%@%@",BaseURL,RegisterUrl] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil ];
        NSString *message = [obj objectForKey:@"message"];
        
        if (message) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        // NSLog(@"登陆成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
//登录
- (void)sendLoginRequest {
    NSDictionary *dic = @{@"username":self.name.text,@"password":self.secret.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://10.0.8.8/sns/my/login.php" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",obj);
        NSString *message = [obj objectForKey:@"message"];
        if (message) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        NSLog(@"登陆成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
//退出
- (void)tuichuRequest {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,tuichuUrl] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *message = [obj objectForKey:@"message"];
        if (message) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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








































