//
//  AFOOPMainController.m
//  AFOOnlinePlay
//

#import "AFOOPMainController.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface AFOOPMainController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *urlField;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UILabel *hintLabel;
@end

@implementation AFOOPMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线播放";
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    [self.view addSubview:self.hintLabel];
    [self.view addSubview:self.urlField];
    [self.view addSubview:self.playButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    UIEdgeInsets insets = self.view.safeAreaInsets;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat x = 16.0;
    CGFloat maxW = width - x * 2.0;
    CGFloat y = insets.top + 24.0;

    self.hintLabel.frame = CGRectMake(x, y, maxW, 44.0);
    y += 44.0 + 12.0;

    self.urlField.frame = CGRectMake(x, y, maxW, 44.0);
    y += 44.0 + 16.0;

    self.playButton.frame = CGRectMake(x, y, maxW, 48.0);
}

#pragma mark - Actions

- (void)onPlayTapped:(id)sender {
    [self.urlField resignFirstResponder];

    NSString *raw = [self.urlField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (raw.length == 0) {
        [self showAlertWithTitle:@"提示" message:@"请输入视频链接"];
        return;
    }

    NSURL *url = [NSURL URLWithString:raw];
    if (!url || url.scheme.length == 0) {
        // 允许用户只输入 host/path 的情况，默认补 https
        url = [NSURL URLWithString:[@"https://" stringByAppendingString:raw]];
    }
    if (!url) {
        [self showAlertWithTitle:@"提示" message:@"链接格式不正确"];
        return;
    }

    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.player = [AVPlayer playerWithURL:url];
    playerVC.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.navigationController pushViewController:playerVC animated:YES];
    [playerVC.player play];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self onPlayTapped:nil];
    return YES;
}

#pragma mark - Helpers

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - AFOTabRootControllerProviding

- (UIViewController *)returnController {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    nav.tabBarItem.title = @"在线播放";
    if (@available(iOS 13.0, *)) {
        nav.tabBarItem.image = [UIImage systemImageNamed:@"play.circle"];
        nav.tabBarItem.selectedImage = [UIImage systemImageNamed:@"play.circle.fill"];
    }
    return nav;
}

#pragma mark - UI

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.text = @"输入视频链接（支持 http/https）";
        _hintLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        _hintLabel.textColor = [UIColor secondaryLabelColor];
        _hintLabel.numberOfLines = 2;
    }
    return _hintLabel;
}

- (UITextField *)urlField {
    if (!_urlField) {
        _urlField = [[UITextField alloc] init];
        _urlField.placeholder = @"https://example.com/video.mp4";
        _urlField.borderStyle = UITextBorderStyleRoundedRect;
        _urlField.autocorrectionType = UITextAutocorrectionTypeNo;
        _urlField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _urlField.keyboardType = UIKeyboardTypeURL;
        _urlField.returnKeyType = UIReturnKeyGo;
        _urlField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _urlField.delegate = self;
    }
    return _urlField;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        _playButton.titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
        _playButton.backgroundColor = [UIColor systemBlueColor];
        [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _playButton.layer.cornerRadius = 10.0;
        _playButton.layer.masksToBounds = YES;
        [_playButton addTarget:self action:@selector(onPlayTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

@end

