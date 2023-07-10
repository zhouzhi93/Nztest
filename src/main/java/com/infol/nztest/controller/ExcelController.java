package com.infol.nztest.controller;

import com.infol.nztest.service.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

@RestController
@RequestMapping(value = "/excel")
public class ExcelController {

    @Autowired
    private SalesService salesService;

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private SalesParameterService salesParameterService;

    @Autowired
    private RepertoryService repertoryService ;

    @Autowired
    private AllotService allotService;

    //创建表头
    private void createTitle(String[] title,HSSFWorkbook workbook,HSSFSheet sheet){
        HSSFRow row = sheet.createRow(0);
        //设置列宽，setColumnWidth的第二个参数要乘以256，这个参数的单位是1/256个字符宽度
        sheet.setColumnWidth(1,12*256);
        sheet.setColumnWidth(3,17*256);

        //设置为居中加粗
        HSSFCellStyle style = workbook.createCellStyle();
        HSSFFont font = workbook.createFont();
        font.setBold(true);
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setFont(font);

        HSSFCell cell;

        for(int i = 0 ; i<title.length ; i++){
            cell = row.createCell(i);
            cell.setCellValue(title[i]);
            cell.setCellStyle(style);
        }
    }

    //生成销售单表汇总excel
    @RequestMapping("/getBillDetailExcel")
    @ResponseBody
    public String getBillDetailExcel(String cxtj, String f_ksrq, String f_jsrq, HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String[] title ={"制单时间","客户名称","合计金额","结算总金额","付款金额"};
        String[] row = {"F_ZDSJ","F_CSMC","F_ZFJE","F_ZFJE","F_ZFJE"};
        createTitle(title,workbook,sheet);
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetBillDetail(cxtj, f_bmbm, f_ksrq,f_jsrq, f_shbm,f_zybm);
        }
        JSONArray rows = new JSONArray(result);

        String fileName = putExcelFile("销售查询汇总",sheet,row,rows);

        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    //生成销售单表明细excel
    @RequestMapping("/getSalesDetailExcel")
    @ResponseBody
    public String getSalesDetailExcel(String cxtj, String f_ksrq, String f_jsrq, HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String[] title ={"单据号","制单日起","商品条码","商品名称","商品属性","规格","批号","单位","单价","销售数量","销售金额"};
        String[] row = {"F_DJH","F_RZRQ","F_SPTM","F_SPMC","F_NYBZMC","F_GGXH","F_SGPCH","F_JLDW","F_XSDJ","F_XSSL","F_SSJE"};
        createTitle(title,workbook,sheet);
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetSalesDetail(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        JSONArray rows = new JSONArray(result);

        String fileName = putExcelFile("销售查询明细",sheet,row,rows);

        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    //生成进货单汇总excel
    @RequestMapping("/getPurchaqseBillExcel")
    @ResponseBody
    public String getPurchaqseBillExcel(String cxtj, String f_ksrq, String f_jsrq, HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String[] title ={"制单时间","客户名称","制单人编码","制单人名称","单据备注","状态"};
        String[] row = {"F_ZDRQ","F_CSMC","F_ZDRBM","F_ZDRMC","F_DJBZ","F_STATE"};
        createTitle(title,workbook,sheet);
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetBillDetail(cxtj, f_bmbm, f_ksrq,f_jsrq, f_shbm,f_zybm);
        }
        JSONArray rows = new JSONArray(result);

        String fileName = putExcelFile("进货查询汇总",sheet,row,rows);

        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    //生成进货单明细excel
    @RequestMapping("/getSpgjDetailExcel")
    @ResponseBody
    public String getSpgjDetailExcel(String cxtj, String f_ksrq, String f_jsrq, HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String[] title ={"单据号","制单日起","商品条码","商品名称","商品属性","规格","批号","单位","单价","进货数量","进货金额"};
        String[] row = {"F_DJH","F_RZRQ","F_SPTM","F_SPMC","F_NYBZMC","F_GGXH","F_SGPCH","F_JLDW","F_GJDJ","F_GJSL","F_GJJE"};
        createTitle(title,workbook,sheet);
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetSpgjDetail(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        JSONArray rows = new JSONArray(result);

        String fileName = putExcelFile("进货查询明细",sheet,row,rows);

        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    //生成调拨单汇总excel
    @RequestMapping("/getAllotBillExcel")
    @ResponseBody
    public String getAllotBillExcel(String cxtj, String f_ksrq, String f_jsrq, HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String[] title ={"制单时间","制单人编码","制单人名称","转出部门","转入部门","单据备注"};
        String[] row = {"F_ZDRQ","F_ZDRBM","F_ZDRMC","F_ZCBMMC","F_ZRBMMC","F_DJBZ"};
        createTitle(title,workbook,sheet);
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = allotService.GetBillDetail(cxtj, f_bmbm, f_ksrq,f_jsrq, f_shbm,f_zybm);
        }
        JSONArray rows = new JSONArray(result);

        String fileName = putExcelFile("调拨查询汇总",sheet,row,rows);

        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    //生成调拨单明细excel
    @RequestMapping("/getAllotDetailExcel")
    @ResponseBody
    public String getAllotDetailExcel(String cxtj, String f_ksrq, String f_jsrq, HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String[] title ={"单据号","制单日起","商品条码","商品名称","调出部门","调入部门","规格","批号","单位","单价","调拨数量","调拨金额"};
        String[] row = {"F_DJH","F_RZRQ","F_SPTM","F_SPMC","F_ZCBMMC","F_ZRBMMC","F_GGXH","F_SGPCH","F_JLDW","F_ZYDJ","F_ZYSL","F_ZYJE"};
        createTitle(title,workbook,sheet);
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = allotService.GetSpzyDetail(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        JSONArray rows = new JSONArray(result);

        String fileName = putExcelFile("调拨查询明细",sheet,row,rows);

        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    //生成销售台账excel
    @RequestMapping("/getSalesParameterExcel")
    @ResponseBody
    public String getSalesParameterExcel(String ksrq,String jsrq,String spmc,String djh,String sptm,String khbm,String khmc,String qybm,
                                         HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String f_lxbm = (String) request.getSession().getAttribute("f_lxbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String fileName = null;
        if("0".equals(f_lxbm) || "1".equals(f_lxbm)){
            String[] title = {"网点名称","商品条码","登记号","商品名称","产品规格","销售日期","客户名称","联系电话","身份证号","计量单位","数量","销售单价","销售金额"};
            String[] row = {"F_BMMC","F_SPTM","F_YPZJH","F_SPMC","F_GGXH","F_RZRQ","F_KHMC","F_DH","F_SFZH","F_JLDW","F_XSSL","F_XSDJ","F_SSJE"};
            createTitle(title,workbook,sheet);
            String result = "";
            if (f_zybm == null) {
                result = "尚未登录";
            } else {
                result = salesParameterService.getXstzs(ksrq,jsrq,spmc,djh,sptm,khbm,khmc,qybm,null,null,request);
            }
            JSONArray rows = new JSONArray(result);

            fileName = putExcelFile("销售台账",sheet,row,rows);
        }else{
            String[] title = {"网点名称","商品条码","商品名称","产品规格","销售日期","客户名称","联系电话","计量单位","数量","销售单价","销售金额"};
            String[] row = {"F_BMMC","F_SPTM","F_SPMC","F_GGXH","F_RZRQ","F_KHMC","F_DH","F_JLDW","F_XSSL","F_XSDJ","F_SSJE"};
            createTitle(title,workbook,sheet);
            String result = "";
            if (f_zybm == null) {
                result = "尚未登录";
            } else {
                result = salesParameterService.getXstzs(ksrq,jsrq,spmc,djh,sptm,khbm,khmc,qybm,null,null,request);
            }
            JSONArray rows = new JSONArray(result);

            fileName = putExcelFile("销售台账",sheet,row,rows);
        }

        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    //生成进货台账excel
    @RequestMapping("/getProcurementParameterExcel")
    @ResponseBody
    public String getProcurementParameterExcel(String ksrq,String jsrq,String spmc,String djh,String sptm,String gysbm,String gysmc,String qybm, HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String f_lxbm = (String) request.getSession().getAttribute("f_lxbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String fileName = null;
        if("0".equals(f_lxbm) || "1".equals(f_lxbm)){
            String[] title = {"网点名称","商品条码","登记号","商品名称","产品规格","供应商名称","联系电话","采购日期","计量单位","数量"};
            String[] row = {"F_BMMC","F_SPTM","F_YPZJH","F_SPMC","F_GGXH","F_GYSMC","F_DH","F_RZRQ","F_JLDW","F_GJSL"};
            createTitle(title,workbook,sheet);
            String result = "";
            if (f_zybm == null) {
                result = "尚未登录";
            } else {
                result = salesParameterService.getCjtzs(ksrq,jsrq,spmc,djh,sptm,gysbm,gysmc,qybm,null,null,request);
            }
            JSONArray rows = new JSONArray(result);

            fileName = putExcelFile("进货台账",sheet,row,rows);
        }else{
            String[] title = {"网点名称","商品条码","商品名称","产品规格","供应商名称","联系电话","采购日期","计量单位","数量","销售单价","销售金额"};
            String[] row = {"F_BMMC","F_SPTM","F_SPMC","F_GGXH","F_GYSMC","F_DH","F_RZRQ","F_JLDW","F_GJSL"};
            createTitle(title,workbook,sheet);
            String result = "";
            if (f_zybm == null) {
                result = "尚未登录";
            } else {
                result = salesParameterService.getCjtzs(ksrq,jsrq,spmc,djh,sptm,gysbm,gysmc,qybm,null,null,request);
            }
            JSONArray rows = new JSONArray(result);

            fileName = putExcelFile("进货台账",sheet,row,rows);
        }

/*        ksrq=ksrq.replace("-","");
        jsrq=jsrq.replace("-","");*/


        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    //生成库存报表excel
    @RequestMapping("/getRepertoryStatementExcel")
    @ResponseBody
    public String getRepertoryStatementExcel(String kcrq,String spmc,String djh,String sptm,String gysbm,String gysmc, HttpServletRequest request,HttpServletResponse response) throws Exception{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("统计表");
        String f_lxbm = (String) request.getSession().getAttribute("f_lxbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String fileName = null;
        if("0".equals(f_lxbm) || "1".equals(f_lxbm)){
            String[] title = {"网点名称","商品条码","登记号","商品名称","产品规格","计量单位","库存数量","成本单价","成本金额"};
            String[] row = {"F_BMMC","F_SPTM","F_YPZJH","F_SPMC","F_GGXH","F_JLDW","F_KCSL","F_CBDJ","F_CBJE"};
            createTitle(title,workbook,sheet);
            String result = "";
            if (f_zybm == null) {
                result = "尚未登录";
            } else {
                result = repertoryService.getKctzs(kcrq,spmc,djh,sptm,gysbm,gysmc,null,null,request);
            }
            JSONArray rows = new JSONArray(result);

            fileName = putExcelFile("库存报表",sheet,row,rows);
        }else{
            String[] title = {"网点名称","商品条码","商品名称","产品规格","计量单位","库存数量","成本单价","成本金额"};
            String[] row = {"F_BMMC","F_SPTM","F_SPMC","F_GGXH","F_JLDW","F_KCSL","F_CBDJ","F_CBJE"};
            createTitle(title,workbook,sheet);
            String result = "";
            if (f_zybm == null) {
                result = "尚未登录";
            } else {
                result = repertoryService.getKctzs(kcrq,spmc,djh,sptm,gysbm,gysmc,null,null,request);
            }
            JSONArray rows = new JSONArray(result);

            fileName = putExcelFile("库存报表",sheet,row,rows);
        }

/*        ksrq=ksrq.replace("-","");
        jsrq=jsrq.replace("-","");*/


        //生成excel文件
        buildExcelFile(fileName, workbook);

        //浏览器下载excel
        buildExcelDocument(fileName,workbook,response);

        return fileName;
    }

    protected String putExcelFile(String fileName,HSSFSheet sheet,String[] row,JSONArray rows){
        //新增数据行，并且设置单元格数据
        int rowNum=1;
        for(int i = 0 ; i<rows.length() ; i++){
            JSONObject temp = rows.getJSONObject(i);
            HSSFRow temprow = sheet.createRow(rowNum);
            int colnum = 0;
            for(String s : row){
                temprow.createCell(colnum).setCellValue(temp.getString(s));
                colnum++;
            }
            rowNum++;
        }

        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
        fileName = fileName+"_"+format.format(new Date())+".xls";
        String fileName2 = "E:/ypt/files/"+fileName;
        File f = new File(fileName2);
        if (!f.getParentFile().exists()) { //判断父目录路径是否存在，即test.txt前的I:\a\b\
            try {
                f.getParentFile().mkdirs();//不存在则创建父目录
                f.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return fileName;
    }

    //生成excel文件
    protected void buildExcelFile(String filename,HSSFWorkbook workbook) throws Exception{
        FileOutputStream fos = new FileOutputStream(filename);
        workbook.write(fos);
        fos.flush();
        fos.close();
    }

    //浏览器下载excel
    protected void buildExcelDocument(String filename,HSSFWorkbook workbook,HttpServletResponse response) throws Exception{
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(filename, "utf-8"));
        OutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        outputStream.flush();
        outputStream.close();
    }


}
