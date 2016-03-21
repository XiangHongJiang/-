//
//  XHSoundInputView.m
//  Perfect_food
//
//  Created by qianfeng on 16/1/24.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "XHSoundInputView.h"

#import <iflyMSC/IFlySpeechRecognizer.h>//不带界面识别
#import <iflyMSC/iflyMSC.h>
#import "IATConfig.h"//语言识别基本配置文件


@interface XHSoundInputView()<IFlySpeechRecognizerDelegate>
{
    //语音识别对象
    IFlySpeechRecognizer *_speechRecognizer;
}
@property (weak, nonatomic) IBOutlet UIView *menuBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *microphoneImgeView;
@property (weak, nonatomic) IBOutlet UILabel *inputTipLabel;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *tryAgainBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@end

@implementation XHSoundInputView

+ (instancetype)soundInputView{

    return [[[NSBundle mainBundle] loadNibNamed:@"XHSoundInputView" owner:nil options:nil] firstObject];
}
/**
 *  Xib加载完成，设置
 */
- (void)awakeFromNib{
    
    //set
    self.tryAgainBtn.layer.cornerRadius = 3;
    self.cancelBtn.layer.cornerRadius = 3;
    self.cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    self.tryAgainBtn.hidden = YES;
//    self.inputTipLabel.hidden = YES;
    
    //1.初始化识别对象
    [self createSpeechRecognizer];
    //2.设置参数
    [self settingSpeechRecognizerParame];
    
    //执行动画
    [self startAnimation];
}
/**
 *  执行的动画
 */
- (void)startAnimation{
    
    //开始识别
    [self start];
    
    [UIView animateWithDuration:2 animations:^{
        self.menuView.y = 0;
    }];
    
    [UIView animateWithDuration:2 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.menuView.y = - self.menuView.height;
        
    } completion:^(BOOL finished) {
        self.menuView.y = self.menuView.height;

        self.inputTipLabel.hidden = NO;
        self.tryAgainBtn.hidden = NO;
        self.cancelBtn.centerX = self.cancelBtn.centerX - self.cancelBtn.width * 0.5 - 15;

        [self stop];

        //如果存在Block对象回调Block
//        if (_detectSoundSucceedBlock) {
//            
//             self.detectSoundSucceedBlock(_soundString);
//        }

    }];
    
}
#pragma mark - Response
- (IBAction)tryAgainAction:(UIButton *)tryAgainBtn {//点击了再试一次
    
    tryAgainBtn.hidden = YES;
    self.inputTipLabel.text = @"识别中...";
    
    self.cancelBtn.centerX = self.cancelBtn.centerX + self.cancelBtn.width * 0.5 + 15;
    [self startAnimation];
    
}
- (IBAction)cancelAction:(UIButton *)cancelBtn {//点击了取消
    
    [self removeFromSuperview];
}
#pragma mark - 语音识别体系
//1.创建识别对象
- (void)createSpeechRecognizer{
    
    if (_speechRecognizer == nil) {
        _speechRecognizer = [IFlySpeechRecognizer sharedInstance];
    }
}
//2.设置识别参数
- (void)settingSpeechRecognizerParame{
    
    if (_speechRecognizer == nil) {//对象不存在，创建
        
        [self createSpeechRecognizer];
        [self settingSpeechRecognizerParame];
    }
    else{//存在，设置参数
        
        //一：
        //扩展参数
        [_speechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        //设置听写模式
        [_speechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        //代理
        _speechRecognizer.delegate = self;
        
        //二：
        //语音识别基本配置文件
        IATConfig *instance = [IATConfig sharedInstance];
        //设置最长录音时间
        [_speechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_speechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_speechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_speechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        //设置采样率，推荐使用16K
        [_speechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        //三：
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_speechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_speechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            
            [_speechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        
        //四：
        //设置是否返回标点符号:设置不带标点符号
        [_speechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT_NODOT]];
        //设置音频来源为麦克风
        [_speechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        //设置听写结果格式为json
        [_speechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
//        [_speechRecognizer setParameter:@"" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
    }
    
}
//3.启动
- (void)start{
    [_speechRecognizer startListening];
}
//4.停止
- (void)stop{
    [_speechRecognizer stopListening];
}
//5.代理数据回调
#pragma mark - 代理
//识别错误
- (void)onError:(IFlySpeechError *)error{
    
    [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
}
//识别结束回调
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }//获得JSON数据
    
    //转为结果字符串
    NSString *resultFromJSON = [self stringFromJson:resultString];

    NSLog(@"result:%@\nresultFromJSON:%@",resultString, resultFromJSON);
    
    _soundString = resultFromJSON;

    self.detectSoundSucceedBlock(_soundString);
    
    if (_soundString.length == 0) {
        
        self.inputTipLabel.text = @"你好像没有说话";
    }
    
}
#pragma mark - 其他
//语音JSON数据解析
- (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {//没有值
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //返回的格式必须为utf8的,否则发生未知错误
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}

- (void)dealloc{
    
    [_speechRecognizer cancel]; //取消识别
    [_speechRecognizer setDelegate:nil];
    [_speechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
}
@end
