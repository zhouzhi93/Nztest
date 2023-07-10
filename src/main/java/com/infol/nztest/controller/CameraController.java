package com.infol.nztest.controller;

import com.infol.nztest.service.SalesService;
import com.infol.nztest.service.StorService;
import com.infol.nztest.service.impl.SalesServiceImpl;
import com.infol.nztest.service.impl.StorServiceImpl;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import sun.misc.BASE64Decoder;
import util.HttpUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@RestController
@RequestMapping(value = "/camera")
public class CameraController {

    @Autowired
    private SalesService salesService;

    @Autowired
    private StorService storService ;

    //人脸识别
    @RequestMapping("/video")
    @ResponseBody
    public String getCitizenCard(String base,String serial) throws Exception{
        HttpUtil  dao = new HttpUtil();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String result = dao.userInfoByFace(base,serial);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    //身份证识别
    @RequestMapping("/videosfz")
    @ResponseBody
    public String getIdentityCard(String base,String serial) throws Exception{
        HttpUtil  dao = new HttpUtil();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String result = dao.userInfoByVideoIdentity(base,serial);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    //传输销售单
    @RequestMapping("/record")
    @ResponseBody
    public String responseSeals(String base,String filename, HttpServletRequest request){
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        filename = f_shbm+"_"+filename+".mp3";
        String catalogue = request.getSession().getServletContext().getRealPath("record/");
        try {
            CameraController.decoderBase64File(base,catalogue+filename,catalogue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(base);
        return "ok";
    }

    /**
     * 将base64字符解码保存文件
     *
     * @param base64Code
     * @param targetPath
     * @throws Exception
     */
    public static void decoderBase64File(String base64Code, String targetPath,String catalogue)
            throws Exception {
        File file = new File(catalogue);
        if(file.exists()==false){
            file.mkdirs();
        }
        base64Code = base64Code.replace("data:audio/mp3;base64,","");
        byte[] buffer = new BASE64Decoder().decodeBuffer(base64Code);
        FileOutputStream out = new FileOutputStream(targetPath);
        out.write(buffer);
        out.close();
    }

}
