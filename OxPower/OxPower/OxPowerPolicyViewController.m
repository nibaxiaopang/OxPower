//
//  OxPowerPolicyViewController.m
//  OxPower
//
//  Created by OxPower on 2024/10/25.
//

#import "OxPowerPolicyViewController.h"
#import <WebKit/WebKit.h>
#import <Photos/Photos.h>
#import "OxPowerUUDInstance.h"
#import "UIViewController+Extentsion.h"

@interface OxPowerPolicyViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate, WKDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *oxPowerIndicatorView;
@property (weak, nonatomic) IBOutlet WKWebView *oxPowerWebView;
@property (weak, nonatomic) IBOutlet UIButton *oxPowerBackBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCos;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCos;

@property (nonatomic, strong) NSURL *donFiURL;
@property (nonatomic, copy) void(^backAction)(void);
@property (nonatomic, copy) NSString *extUrlstring;

@property (nonatomic, strong) NSDictionary *confData;
@property (nonatomic, assign) BOOL bju;
@end

@implementation OxPowerPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.confData = [NSUserDefaults.standardUserDefaults objectForKey:@"OxPowerPolicyDatas"];
    self.bju = [[self.confData objectForKey:@"bju"] boolValue];
    [self oxPowerMSGHandlePrivacyInitSubViews];
    [self oxPowerInitConfigNav];
    [self oxPowerInitWebViewConfig];
    [self oxPowerInitWebData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.confData) {
        NSInteger top = [[self.confData objectForKey:@"top"] integerValue];
        NSInteger bottom = [[self.confData objectForKey:@"bottom"] integerValue];
        if (top>0) {
            self.topCos.constant = self.view.safeAreaInsets.top;
        }
        
        if (bottom>0) {
            self.bottomCos.constant = self.view.safeAreaInsets.bottom;
        }
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
}

#pragma mark Event
- (IBAction)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backClick
{
    if (self.backAction) {
        self.backAction();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark INIT
- (void)oxPowerMSGHandlePrivacyInitSubViews
{
    self.oxPowerWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.view.backgroundColor = UIColor.blackColor;
    self.oxPowerWebView.backgroundColor = [UIColor blackColor];
    self.oxPowerWebView.opaque = NO;
    self.oxPowerWebView.scrollView.backgroundColor = [UIColor blackColor];
    self.oxPowerIndicatorView.hidesWhenStopped = YES;
}

- (void)oxPowerInitConfigNav
{
    self.oxPowerBackBtn.hidden = self.navigationController == nil;
    if (!self.url.length) {
        self.oxPowerWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        return;
    }
    
    self.oxPowerBackBtn.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor systemBlueColor];
    UIImage *image = [UIImage systemImageNamed:@"xmark"];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)oxPowerInitWebViewConfig
{
    if (self.confData) {
        NSInteger type = [[self.confData objectForKey:@"type"] integerValue];
        WKUserContentController *userContentC = self.oxPowerWebView.configuration.userContentController;
        // w
        if (type == 1) {
            NSString *trackStr = @"window.jsBridge = {\n    postMessage: function(name, data) {\n        window.webkit.messageHandlers.OxPowerMSGHandle.postMessage({name, data})\n    }\n};\n";
            WKUserScript *trackScript = [[WKUserScript alloc] initWithSource:trackStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
            [userContentC addUserScript:trackScript];
            
            NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
            if (!version) {
                version = @"";
            }
            NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
            if (!bundleId) {
                bundleId = @"";
            }
            NSString *inPPStr = [NSString stringWithFormat:@"window.WgPackage = {name: '%@', version: '%@'}", bundleId, version];
            WKUserScript *inPPScript = [[WKUserScript alloc] initWithSource:inPPStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
            [userContentC addUserScript:inPPScript];
            [userContentC addScriptMessageHandler:self name:@"OxPowerMSGHandle"];
        }
        
        // afu
        else {
            [userContentC addScriptMessageHandler:self name:@"jsBridge"];
        }
    }
    
    self.oxPowerWebView.navigationDelegate = self;
    self.oxPowerWebView.UIDelegate = self;
}

- (void)oxPowerInitWebData
{
    if (self.url.length) {
        NSURL *url = [NSURL URLWithString:self.url];
        if (url == nil) {
            return;
        }
        [self.oxPowerIndicatorView startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.oxPowerWebView loadRequest:request];
    } else {
        NSURL *url = [NSURL URLWithString:self.oxPowerMainPrivacyUrl];
        if (url == nil) {
            return;
        }
        [self.oxPowerIndicatorView startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.oxPowerWebView loadRequest:request];
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *name = message.name;
    if ([name isEqualToString:@"OxPowerMSGHandle"]) {
        NSDictionary *trackMessage = (NSDictionary *)message.body;
        NSString *tName = trackMessage[@"name"] ?: @"";
        NSString *tData = trackMessage[@"data"] ?: @"";
        NSData *data = [tData dataUsingEncoding:NSUTF8StringEncoding];
        
        if (data) {
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!error && [jsonObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = jsonObject;
                if (![tName isEqualToString:@"openWindow"]) {
                    [self oxPowerSendEvent:tName values:dic];
                    return;
                }
                if ([tName isEqualToString:@"rechargeClick"]) {
                    return;
                }
                NSString *adId = dic[@"url"] ?: @"";
                if (adId.length > 0) {
                    [self oxPowerReloadWebViewData:adId];
                }
            }
        } else {
            [self oxPowerSendEvent:tName values:@{tName: data}];
        }
    }  else if ([message.name isEqualToString:@"jsBridge"] && [message.body isKindOfClass:[NSString class]]) {
        NSDictionary *dic = [self oxPowerJsonToDicWithJsonString:(NSString *)message.body];
        NSString *evName = dic[@"funcName"] ?: @"";
        NSString *evParams = dic[@"params"] ?: @"";
        if ([evName isEqualToString:@"openAppBrowser"]) {
            NSDictionary *uDic = [self oxPowerJsonToDicWithJsonString:evParams];
            NSString *urlStr = uDic[@"url"] ?: @"";
            NSURL *url = [NSURL URLWithString:urlStr];
            if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        } else if ([evName isEqualToString:@"appsFlyerEvent"]) {
            [self oxPowerSendEventsWithParams:evParams];
        }
    }
}

- (void)oxPowerReloadWebViewData:(NSString *)adurl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.extUrlstring isEqualToString:adurl] && self.bju) {
            return;
        }
        
        OxPowerPolicyViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:@"OxPowerPolicyViewController"];
        adView.url = adurl;
        __weak typeof(self) weakSelf = self;
        adView.backAction = ^{
            NSString *close = @"window.closeGame();";
            [weakSelf.oxPowerWebView evaluateJavaScript:close completionHandler:nil];
        };
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:adView];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    });
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.oxPowerIndicatorView stopAnimating];
    });
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.oxPowerIndicatorView stopAnimating];
    });
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction preferences:(WKWebpagePreferences *)preferences decisionHandler:(void (^)(WKNavigationActionPolicy, WKWebpagePreferences *))decisionHandler {
    if (@available(iOS 14.5, *)) {
        if (navigationAction.shouldPerformDownload) {
            decisionHandler(WKNavigationActionPolicyDownload, preferences);
            NSLog(@"%@", navigationAction.request);
            [webView startDownloadUsingRequest:navigationAction.request completionHandler:^(WKDownload *down) {
                down.delegate = self;
            }];
        } else {
            decisionHandler(WKNavigationActionPolicyAllow, preferences);
        }
    } else {
        decisionHandler(WKNavigationActionPolicyAllow, preferences);
    }
}

#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (navigationAction.targetFrame == nil) {
        NSURL *url = navigationAction.request.URL;
        if (url) {
            self.extUrlstring = url.absoluteString;
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }
    return nil;
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSString *authenticationMethod = challenge.protectionSpace.authenticationMethod;
    if ([authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *credential = nil;
        if (challenge.protectionSpace.serverTrust) {
            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        }
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

#pragma mark - WKDownloadDelegate
- (void)download:(WKDownload *)download decideDestinationUsingResponse:(NSURLResponse *)response suggestedFilename:(NSString *)suggestedFilename completionHandler:(void (^)(NSURL *))completionHandler API_AVAILABLE(ios(14.5)){
    NSString *tempDir = NSTemporaryDirectory();
    NSURL *tempDirURL = [NSURL fileURLWithPath:tempDir isDirectory:YES];
    NSURL *destinationURL = [tempDirURL URLByAppendingPathComponent:suggestedFilename];
    self.donFiURL = destinationURL;
    if ([[NSFileManager defaultManager] fileExistsAtPath:destinationURL.path]) {
        [self oxPowerSaveDownloadedFileToPhotoAlbum:self.donFiURL];
    }
    completionHandler(destinationURL);
}

- (void)download:(WKDownload *)download didFailWithError:(NSError *)error API_AVAILABLE(ios(14.5)){
    NSLog(@"Download failed: %@", error.localizedDescription);
}

- (void)downloadDidFinish:(WKDownload *)download API_AVAILABLE(ios(14.5)){
    NSLog(@"Download finished successfully.");
    [self oxPowerSaveDownloadedFileToPhotoAlbum:self.donFiURL];
}

- (void)oxPowerSaveDownloadedFileToPhotoAlbum:(NSURL *)fileURL API_AVAILABLE(ios(14.5)){
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [PHAssetCreationRequest creationRequestForAssetFromImageAtFileURL:fileURL];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        [self oxPowerShowAlertWithTitle:@"sucesso" message:@"A imagem foi salva no álbum."];
                    } else {
                        [self oxPowerShowAlertWithTitle:@"erro" message:[NSString stringWithFormat:@"Falha ao salvar a imagem: %@", error.localizedDescription]];
                    }
                });
            }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self oxPowerShowAlertWithTitle:@"Photo album access denied." message:@"Please enable album access in settings."];
            });
            NSLog(@"Photo album access denied.");
        }
    }];
}

@end
