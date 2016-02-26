//
//  QuickLoanVideoUploadingVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/15.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "QuickLoanVideoUploadingVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface QuickLoanVideoUploadingVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
    AVPlayerLayer *playerlayer;
}

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (strong,nonatomic) UIImagePickerController *imagePicker;

@property (strong,nonatomic)NSData *data;
@property (assign,nonatomic) int isVideo;
@property (strong ,nonatomic) AVPlayer *player;//播放器，用于录制完视频后播放视频
@property (strong,nonatomic)NSString *urlStr;

@end

@implementation QuickLoanVideoUploadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.urlStr!=nil) {
                
        NSURL *url=[NSURL fileURLWithPath:self.urlStr];
        
        _player=[AVPlayer playerWithURL:url];
        
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
        
        playerLayer.frame=CGRectMake(0, 0, self.photo.frame.size.width, self.photo.frame.size.height);
        
        [self.photo.layer addSublayer:playerLayer];
    

    }
    
    //1、创建手势实例，并连接方法handleTapGesture,点击手势
    self.photo.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
    //设置手势点击数,双击：点1下
    tapGesture.numberOfTapsRequired=1;
    // imageView添加手势识别
    [self.photo addGestureRecognizer:tapGesture];
    
    // Do any additional setup after loading the view.
    
    //    读取路径
    NSString *path1=[NSString stringWithFormat:@"%@/path.txt",NSTemporaryDirectory()];
    
    NSFileManager *fm=[NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:path1]) {
        
        NSString *realpath=[NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"path--%@",realpath);
        
        NSURL *url=[NSURL fileURLWithPath:realpath];
        
        _player=[AVPlayer playerWithURL:url];
        
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
        
        playerLayer.frame=CGRectMake(0, 0, self.photo.frame.size.width, self.photo.frame.size.height);
        
        [self.photo.layer addSublayer:playerLayer];
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photo:(id)sender {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择文件来源" delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"录相机",@"本地视频",nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0://录相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _isVideo=0;
            imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
            
            
                CGRect frame = CGRectMake(self.view.frame.origin.x/2, 40, 360, 200);
                UILabel *lable=[[UILabel alloc] initWithFrame:frame];
                lable.text=@"录制视屏测试弹幕，录制视屏测试弹幕，录制视屏测试弹幕。";
                lable.backgroundColor=[UIColor clearColor];
                [imagePicker.cameraOverlayView addSubview:lable];
            
            
                self.imagePicker=imagePicker;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
            break;
            
        case 1://本地视频
        {
            
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            _isVideo=1;
                imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
                
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        
        
        NSLog(@"video...");
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        
       self.urlStr=[url path];
        
        NSLog(@"%@",_urlStr);
        
        if (_isVideo==0 ) {
            
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(self.urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
        }
        else
        {
            
            [self video:self.urlStr];
        }
        
        NSString *path1=[NSString stringWithFormat:@"%@/path.txt",NSTemporaryDirectory()];
        //        写入文件
        //        [self.urlStr writeToFile:path1 atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [self.urlStr writeToFile:path1 atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

-(void)video:(NSString*)path
{
    NSURL *url=[NSURL fileURLWithPath:path];
    
    _player=[AVPlayer playerWithURL:url];
    
    AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    
    playerLayer.frame=CGRectMake(0, 0, self.photo.frame.size.width, self.photo.frame.size.height);
    
    [self.photo.layer addSublayer:playerLayer];
    
}

-(UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置image picker的来源，这里设置为摄像头
        _imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;//设置使用哪个摄像头，这里设置为后置摄像头
        
        _imagePicker.videoQuality=UIImagePickerControllerQualityTypeLow;
        
        _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;
       
        _imagePicker.allowsEditing=YES;//允许编辑
        _imagePicker.delegate=self;//设置代理，检测操作
        
    }
    
    return _imagePicker;
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        //录制完之后自动播放
        NSURL *url=[NSURL fileURLWithPath:videoPath];
        
        _player=[AVPlayer playerWithURL:url];
        
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
        
        playerLayer.frame=CGRectMake(0, 0, self.photo.frame.size.width, self.photo.frame.size.height);
        
        [self.photo.layer addSublayer:playerLayer];
      
        
    }
}

-(void)handleTapGesture
{
      [_player play];
    
}

- (IBAction)preserve:(id)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"是否上传"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确认",nil];
    
    
    
    [alert show] ;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        NSLog(@"成功");
        
    }
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
