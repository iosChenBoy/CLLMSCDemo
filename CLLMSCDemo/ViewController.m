//
//  ViewController.m
//  CLLMSCDemo
//
//  Created by wln100-IOS1 on 17/2/10.
//  Copyright © 2017年 TianXing. All rights reserved.
//

#import "ViewController.h"
#import <iflyMSC/IFlyRecognizerView.h>
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlySpeechConstant.h>

@interface ViewController () <IFlyRecognizerViewDelegate>

@property (nonatomic, strong)IFlyRecognizerView *recognizerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)startRecognise:(id)sender {
    //开始识别语音
    // 1.初始化语音识别空间
    if (!self.recognizerView) {
        self.recognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        self.recognizerView.delegate = self;
        [self.recognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        //设置结果数据格式，可设置为json，xml，plain，默认为json。
        [self.recognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    }
    
    //2.开始语音服务
    [self.recognizerView start];

}

#pragma mark - delegate
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = resultArray[0];
    for (NSString *key in dic) {
        [result appendString:key];
    }
    [self.textView setText:[self.textView.text stringByAppendingString:result]];
}

- (void)onError:(IFlySpeechError *)error{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
