//
//  StudentIdentityCardUploadingVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "StudentIdentityCardUploadingVC.h"
#import "Header.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface StudentIdentityCardUploadingVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
    
    float width,heig;
}


@property (strong, nonatomic) UIImageView *photo;
@property (strong, nonatomic)UIButton *anniu;

@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong,nonatomic)NSData *data;
@property (strong,nonatomic)UIImage *image;


@end

@implementation StudentIdentityCardUploadingVC


- (void)choosephoto {
    
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

//当选择一张图片后进入这里

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
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image2"] contents:_data attributes:nil];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"xueshengzflag"];
        
        //得到选择后沙盒中图片的完整路径
        
        //        self.fileData = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        
        //关闭相册界面
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        
        //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
        
        
        self.photo.image=[UIImage imageWithData:_data];
    }
    

}





- (void)safe:(id)sender {
    
    if (([[[NSUserDefaults standardUserDefaults] objectForKey: @"xueshengzflag"] intValue]==1)||[[[NSUserDefaults standardUserDefaults] objectForKey:@"zjz3"] length]>0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"是否上传"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确认",nil];
        
        
        
        [alert show] ;
        
    }
    
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"请选择图片"
                                                      delegate:self
                                             cancelButtonTitle:nil otherButtonTitles:@"确认",nil];
        
        
        
        [alert show] ;
    }
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        NSLog(@"成功");
        
        [self.navigationController popViewControllerAnimated:YES];

        [self.delegate tu2];
        
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"学生证上传";
    
    width=[[UIScreen mainScreen] bounds].size.width;
    
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    _photo=[[UIImageView alloc] initWithFrame:CGRectMake(16, 68, width-32, 276)];
    //    _photo.image=[UIImage imageNamed:@"takephoto.png"];
    
    _photo.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosephoto)];
    
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    
    [_photo addGestureRecognizer:tap];
    
    _photo.image=[UIImage imageNamed:@"takephoto.png"];
    
    [self.view addSubview:_photo];
    
    
    if (heig==480) {
        _anniu=[[UIButton alloc] initWithFrame:CGRectMake(16, heig-124, width-32, 44)];
    }
    else
    
    _anniu=[[UIButton alloc] initWithFrame:CGRectMake(16, heig-204, width-32, 44)];
    
    NSLog(@"--%f--%f-%f",width,heig,heig-64);
    
    _anniu.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1];
    
    [_anniu setTitle:@"确定" forState:UIControlStateNormal];
    
    [_anniu addTarget:self action:@selector(safe:) forControlEvents:UIControlEventTouchUpInside];
    [_anniu.layer setCornerRadius:5.0f];
    
    [_anniu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_anniu];
    


//    NSUserDefaults *defaults3 = [NSUserDefaults standardUserDefaults];
//    
//    [defaults3 setObject:imageData forKey:@"zjz2"];

    
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

@end
