package com.infol.nztest.controller;

import com.infol.nztest.service.ClerkService;
import com.infol.nztest.service.CommodityService;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import util.BASE64DecodedMultipartFile;
import util.Base64StrToImage;
import util.FileUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/file")
public class FileController {
    @Autowired
    private ClerkService clerkService ;

    @Autowired
    private CommodityService commodityService;

    @RequestMapping("/upload")
    public String uploadFile(MultipartFile file,HttpServletRequest request){
        String result = "";
        String contentType = file.getContentType();
        String fileName = file.getOriginalFilename();
        /*System.out.println("fileName-->" + fileName);
        System.out.println("getContentType-->" + contentType);*/
        String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();
        String hzm = fileName.substring(fileName.lastIndexOf("."));
        uuid = uuid+hzm;
        String filePath = request.getSession().getServletContext().getRealPath("fileImages/");
        try {
            result = FileUtil.uploadFile(file.getBytes(), filePath, uuid);
        } catch (Exception e) {
            // TODO: handle exception
        }
        //返回json
        return result;
    }

    @RequestMapping("/uploadBase64")
    public String uploadBase64(String sptm,String file64,HttpServletRequest request){
        String result = "";
        try {
            BASE64DecodedMultipartFile file = null;
            if(null != file64 && !file64.isEmpty()){
                file =  (BASE64DecodedMultipartFile) Base64StrToImage.base64MutipartFile(file64);
            }
            String contentType = file.getContentType();
            String fileName = file.getOriginalFilename();
        /*System.out.println("fileName-->" + fileName);
        System.out.println("getContentType-->" + contentType);*/
            String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();
            String hzm = fileName.substring(fileName.lastIndexOf("."));
            uuid = uuid+hzm;
            String filePath = request.getSession().getServletContext().getRealPath("fileImages/");
            String filePath2 = filePath+uuid;
            String uuid2 = UUID.randomUUID().toString().replace("-", "").toLowerCase();
            String hzm2 = fileName.substring(fileName.lastIndexOf("."));
            uuid2 = uuid2+hzm2;
            String filePath3 = filePath+uuid2;
            /**
             * 缩略图begin
             */
            //added by yangkang 2016-3-30 去掉后缀中包含的.png字符串
            if(uuid.contains(".png")){
                uuid = uuid.replace(".png", ".jpg");
            }
            if(uuid2.contains(".png")){
                uuid2 = uuid2.replace(".png", ".jpg");
            }
            if(filePath2.contains(".png")){
                filePath2 = filePath2.replace(".png", ".jpg");
            }
            if(filePath3.contains(".png")){
                filePath3 = filePath3.replace(".png", ".jpg");
            }
            long size = file.getSize();
            double scale = 1.0d ;
            if(size >= 200*1024){
                if(size > 0){
                    scale = (200*1024f) / size  ;
                }
            }
            result = FileUtil.uploadFile(file.getBytes(), filePath, uuid);
            File toPic=new File(filePath3);

            if(size < 200*1024){
                Thumbnails.of(filePath2).scale(0.5f).outputFormat("jpg").toFile(toPic);
            }else{
                Thumbnails.of(filePath2).scale(0.5f).outputQuality(scale).outputFormat("jpg").toFile(toPic);
            }
            File fromPic = new File(filePath2);
            fromPic.delete();
            commodityService.updateSpTp(sptm,"/fileImages/"+uuid2,request);

        } catch (Exception ex) {
        }
        //返回json
        return result;
    }

    @RequestMapping("/uploadFiles")
    public String uploadFiles(MultipartFile[] files,HttpServletRequest request){

        String result = "";

        //判断file数组不能为空并且长度大于0
        if (files != null && files.length > 0) {
            //循环获取file数组中得文件
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                String fileName = file.getOriginalFilename();
                String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();
                String hzm = fileName.substring(fileName.lastIndexOf("."));
                uuid = uuid+hzm;
                String filePath = request.getSession().getServletContext().getRealPath("fileImages/");
                System.out.println(filePath);
                try {
                    result += FileUtil.uploadFile(file.getBytes(), filePath, uuid) + ",";
                    System.out.println(result);
                } catch (Exception e) {
                    // TODO: handle exception
                }
            }
        }

        //跳转视图
        return result.substring(0,result.length()-1);
    }

}
