//
//  ViewController.m
//  NotificationWatchKit12
//
//  Created by MAEDAHAJIME on 2015/05/27.
//  Copyright (c) 2015年 MAEDAHAJIME. All rights reserved.
//

#import "ViewController.h"

#define NOTIFICATION_TIME   5   // 現在の日時より何秒後にアラート通知するか

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* ============================================================================== */
#pragma mark - Button Action
/* ============================================================================== */
// ローカル通知開始ボタン
- (IBAction)StartbtnAction:(UIButton *)sender {
    [self localNotificationStart];  // ローカル通知を開始
    // ラベルへテキストを設定
    self.label.text = [NSString stringWithFormat:@"ローカル通知を開始しました。\n%d秒後に通知します。", NOTIFICATION_TIME];
}

// ローカル通知停止ボタン
- (IBAction)StopbtnAction:(UIButton *)sender {
    [self localNotificationStop];   // ローカル通知を停止
    // ラベルへテキストを設定
    self.label.text = @"ローカル通知を停止しました。";
}

/* ============================================================================== */
#pragma mark - UILocalNotification
/* ============================================================================== */
// ローカル通知(アプリが起動していない時、あるいは起動しているがバックグラウンドにある状態の時に「指定時刻になったらユーザーに対して通知する」)
- (void)localNotificationStart
{
    // 現在日時を取得
    NSDate *dateNow = [NSDate date];
    
    // アラート通知する日時
    NSDate *dateAlert =  [dateNow initWithTimeInterval:NOTIFICATION_TIME sinceDate:dateNow]; // 現在日時から5秒後
    
    
    /* ローカル通知設定 */
    
    // ローカル通知を作成する
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // 通知日時を設定する
    [localNotification setFireDate:dateAlert];
    
    // タイムゾーンを指定する
    [localNotification setTimeZone:[NSTimeZone localTimeZone]];
    
    // 効果音は標準の効果音を利用する
    [localNotification setSoundName:UILocalNotificationDefaultSoundName];
    
    // ボタンの設定
    [localNotification setAlertAction:@"Open"];
    
    // タイトルを設定する（Apple Watch）
    localNotification.alertTitle = @"[セミナーのご案内]";
    
    // メッセージを設定する（Apple Watch）
    [localNotification setAlertBody:@"大阪心斎橋Bppleセンターで開催します。"];
    
    // 特定できるようにキーを設定する
    [localNotification setUserInfo:[NSDictionary  dictionaryWithObject:@"1" forKey:@"NOTIF_KEY"]];
    
    // ローカル通知を登録する
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

// ローカル通知キャンセル
- (void)localNotificationStop
{
    // アラート通知をキャンセルする(重複通知対策)
    for (UILocalNotification *notify in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        NSInteger keyId = [[notify.userInfo objectForKey:@"NOTIF_KEY"] intValue];
        
        if (keyId == 1) {
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
        }
    }
}

@end
