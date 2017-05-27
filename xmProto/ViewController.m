//
//  ViewController.m
//  xmProto
//
//  Created by ucse on 2017/5/27.
//  Copyright © 2017年 孙明月. All rights reserved.
//

#import "ViewController.h"
#import "Xm.pbobjc.h"
#import "TXHttpClient.h"

@interface ViewController ()
@property(nonatomic, strong)UILabel *result;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupViews];
    
//    [self createresponse];
}



-(void)createresponse
{
    UCSEXMxesponse *response = [UCSEXMxesponse message];
    response.errorMsg =@"error";
    response.errorCode = 1000;
    [response setListArray:[NSMutableArray arrayWithArray:@[@"11", @"22", @"33"]]];
    
    NSData *data = [response data];
    NSString *fullPath = [NSString stringWithFormat:@"%@/Documents/c.data", NSHomeDirectory()];
    [data writeToFile:fullPath atomically:YES];

}



-(void)setupViews
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"请求" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 200, 80, 40);
    [btn addTarget:self action:@selector(request) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];


    UILabel *result = [[UILabel alloc] init];
    result.backgroundColor = [UIColor lightGrayColor];
    self.result = result;
    result.textColor = [UIColor blueColor];
    result.numberOfLines = 0;
    result.frame = CGRectMake(10, 300, 200, 200);
    [self.view addSubview:result];
    
}

-(void)request
{
    __weak typeof(self) weakSelf = self;
    
//    self.result.text = @"123";
    [[TXHttpClient sharedInstance] sendRequest:@"a.php" token:@"" bodyData:nil onCompleted:^(NSError *error, UCSEXMxesponse *response) {
        NSLog(@"error:%@", error);
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.result.text =  [NSString stringWithFormat:@"errmsg:%@ errCode:%@, list:%@", response.errorMsg, @(response.errorCode), response.listArray];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
