//
//  LoginViewController.m
//  myapp
//
//  Created by alumno on 4/28/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import "LoginViewController.h"
#import "SSKeychain.h"

@interface LoginViewController ()

@end
BOOL match;
NSUserDefaults *eUser;

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _service = @"expreso";
    eUser = [NSUserDefaults standardUserDefaults];
    NSString *savedUser = [eUser objectForKey:@"user"];
    NSLog(@"Usuario %@", savedUser);
    NSString *account = [SSKeychain passwordForService:_service account:savedUser];
    NSLog(@"Accounts %@", account);
    if ([SSKeychain accountsForService:_service]) {
        [self performSegueWithIdentifier:@"login" sender:(nil)];
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
-(IBAction) quitaTeclado:(id)sender{

    [self.tfPassword resignFirstResponder];
    [self.tfUsuario resignFirstResponder];
}

- (IBAction)login:(id)sender {
    _usuario = self.tfUsuario.text;
    _password = self.tfPassword.text;
    //NSString *saved = [SSKeychain passwordForService:_service account:_usuario];
    if([_usuario isEqualToString:@"admin"] && [_password isEqualToString:@"admin"])
        match  = YES;
    else
        match = NO;
    
        if (match) {
            [SSKeychain setPassword:_password forService:_service account:_usuario];
            eUser = [NSUserDefaults standardUserDefaults];
            [eUser setObject:_usuario forKey:@"user"];
            [eUser synchronize];
            [self performSegueWithIdentifier:@"login" sender:(nil)];
            
        }else{
            UIAlertView *uhoh = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please enter your username and password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [uhoh show];
        }
    
    
}
@end
