//
//  LoginViewController.m
//  Product
//
//  Created by Sen wang on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController () <UITextFieldDelegate>
/// 账号
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;

/// 密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

/// 登录按钮
- (IBAction)loginBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = CGRectMake(0, 0, 12, 12);
    tempBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 10);
    [tempBtn setImage:kImageNamed(@"close_eyes") forState:UIControlStateNormal];
    [tempBtn setImage:[UIImage imageNamed:@"make_eyes"] forState:UIControlStateSelected];
    [tempBtn addTarget:self action:@selector(tempBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.passwordTF.rightView = tempBtn;
    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
    
    _passwordTF.secureTextEntry = YES;



    [_userNameTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
        if (x.length != 13) {
            _loginBtn.userInteractionEnabled = NO;
            [_loginBtn setBackgroundColor:kRGBColor(209, 209, 209, 1)];
            
        } else {
            _loginBtn.userInteractionEnabled = YES;
            [_loginBtn setBackgroundColor:kAllRGB];
            
        }
    }];
    
    _loginBtn.userInteractionEnabled = NO;
    _userNameTF.delegate = self;
    [_loginBtn setBackgroundColor:kRGBColor(209, 209, 209, 1)];
    

}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [textField phoneTFValueChangeValueString:string shouldChangeCharactersInRange:range];

    
    return false;
}



// MARK:  密码右边的眼睛
-(void) tempBtnClickAction:(UIButton *)tempBtn {
    self.passwordTF.secureTextEntry = YES;
    
    if ((tempBtn.selected=!tempBtn.selected)) {
        
        self.passwordTF.secureTextEntry = NO;
        
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
#pragma mark - 登录按钮点击方法
- (IBAction)loginBtnAction:(UIButton *)sender {
    if ([_userNameTF.text length] != 11) {
        
        [XXProgressHUD showMessage:@"请正确输入手机号"];
        [_userNameTF becomeFirstResponder];
        
        return;
    }
    
    if (_passwordTF.text.length == 0) {
        [XXProgressHUD showMessage:@"输入密码"];
        [_passwordTF becomeFirstResponder];
        
        return;
    }
    
    
}
@end
