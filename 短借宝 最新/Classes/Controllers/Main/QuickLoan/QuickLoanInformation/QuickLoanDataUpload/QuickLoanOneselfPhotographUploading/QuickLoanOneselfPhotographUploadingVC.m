//
//  QuickLoanOneselfPhotographUploadingVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/15.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "QuickLoanOneselfPhotographUploadingVC.h"

@interface QuickLoanOneselfPhotographUploadingVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (strong,nonatomic) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (strong,nonatomic)NSData *data;
@property (strong,nonatomic)UIImage *image;


@end

@implementation QuickLoanOneselfPhotographUploadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSData *ss=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/image22.png",NSHomeDirectory()]];
    
    
    self.photo.image=[UIImage imageWithData:ss];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photo:(id)sender {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择文件来源" delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0://照相机
        {                 UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
            
            imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            
        case 1://本地相簿
        {                 UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:(NSString *)kUTTypeImage])
    {
        //先把图片转成NSData
        _image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if (UIImagePNGRepresentation(_image) == nil)
        {
            _data = UIImageJPEGRepresentation(_image, 1.0);
        }
        else
        {
            _data = UIImagePNGRepresentation(_image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        
        //[fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image22.png"] contents:_data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        
        //        self.fileData = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        
        //关闭相册界面
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        
        //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
        
        
        self.photo.image=[UIImage imageWithData:_data];
    }
    
    
    
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
