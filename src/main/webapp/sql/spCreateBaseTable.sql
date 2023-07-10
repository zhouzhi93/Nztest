USE [INFOLYW]
GO
/****** Object:  StoredProcedure [dbo].[spCreateBaseTable]    Script Date: 2023/3/21 16:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[spCreateBaseTable] 
as 
begin

-- tbSysMsg 系统参数 
if not exists(select * from sysobjects where name='tbSysMsg')
begin
Create table tbSysMsg  (
        f_Csmc     VARCHAR(50) ,                  --参数名称
        f_Csz      VARCHAR(255)   DEFAULT(''),     --参数值
        f_Cssm     VARCHAR(50)    DEFAULT(''),     --参数说明
        ConstraINT pSysMsg  Primary Key(f_Csmc)
)
end

--tbptzyda平台职员档案（用于系统后台登陆）
if not exists(select * from sysobjects where name='tbptzyda')
begin
Create Table tbptzyda
      (
       f_Zybm     VARCHAR(8),                     	--职员编码
       f_Zymc     VARCHAR(20)     DEFAULT(''),      --职员名称                
       f_Xgrq     VARCHAR(20)     DEFAULT(''),      --修改日期          
       f_Zykl     VARCHAR(20)     DEFAULT(''),      --职员口令
       f_sjh      VARCHAR(11)     DEFAULT(''),      --手机号码       
       f_zylx     VARCHAR(2)      DEFAULT(''),      --职员类型    
       f_shbm     VARCHAR(12)     DEFAULT(''),     	--商户编码
      ConstraINT pZyda Primary Key(f_Zybm)
)
end

--区域档案表（全国的区域档案）
if not exists(select * from sysobjects where name='tbqyda')
begin
Create Table tbqyda 
(
   f_qybm      VARCHAR(20)      NOT NULL DEFAULT(''),                --区域编码
   f_qymc      VARCHAR(30)     NOT NULL ,                --区域名称
   f_sfqy      INT             NOT NULL     DEFAULT(0),   --
   f_jb        INT             NOT NULL     DEFAULT(0),   --级别
   f_mj        INT             NOT NULL     DEFAULT(0),   --末级
   f_zjf       varchar(50)     NOT NULL     DEFAULT(''),  --助记符 
   ConstraINT pqybm  Primary Key(f_qybm)
)
end


  --tbDxmb  短信模板
if not exists(select * from sysobjects where name='tbDxmb')
begin
Create Table tbDxmb
      (
       f_Dxbm   VARCHAR(3),                   --短信编码
       f_Dxmc   VARCHAR(30)     DEFAULT(''),   --短信名称        
       f_Dxnr   VARCHAR(1000)   DEFAULT(''),   --短信内容          
       ConstraINT pDxmb Primary Key(f_Dxbm)
       )
end


  --商户类型档案
if not exists(select * from sysobjects where name='tbshlxda')
begin
CREATE TABLE tbshlxda
	  (
	   f_lxbm	VARCHAR(2)	    NOT NULL  DEFAULT(''),    --商户类型编码  0 农药厂商、 1农资店  、3 零售 4、批发商
	   f_lxmc	VARCHAR(20)         NOT NULL  DEFAULT(''),    --商户类型名称
	   f_Bz		VARCHAR(500)        NOT NULL  DEFAULT(''),    --备注
	   f_c_col1	VARCHAR(30)	    NOT NULL  DEFAULT(''), 
	   f_c_col2	VARCHAR(30)	    NOT NULL  DEFAULT(''),
	   f_c_col3	VARCHAR(30)	    NOT NULL  DEFAULT(''),
	   f_f_col1	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col2	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col3	FLOAT		    NOT NULL  DEFAULT(0),
	   CONSTRAINT pshlxda PRIMARY KEY(f_lxbm)
	   )
insert INTo tbshlxda(f_lxbm,f_lxmc)values('0','农药厂商')
insert INTo tbshlxda(f_lxbm,f_lxmc)values('1','农资店')
insert INTo tbshlxda(f_lxbm,f_lxmc)values('3','零售')
insert INTo tbshlxda(f_lxbm,f_lxmc)values('4','批发商')
insert INTo tbshlxda(f_lxbm,f_lxmc)values('11','通用版')
insert INTo tbshlxda(f_lxbm,f_lxmc)values('12','常熟专版')
insert INTo tbshlxda(f_lxbm,f_lxmc)values('13','太仓专版')
insert INTo tbshlxda(f_lxbm,f_lxmc)values('14','江阴专版')
end



--界面档案表
if not exists(select * from sysobjects where name='tbpages')
begin
Create table tbpages  (
        f_bm     VARCHAR(50)   NOT NULL  DEFAULT(''),    --编码
        f_mc     VARCHAR(255)            DEFAULT(''),     --名称
        f_sm     VARCHAR(50)             DEFAULT(''),     --说明
        ConstraINT ptbpages  Primary Key(f_bm)
)
end

--界面元素表
if not exists(select * from sysobjects where name='tbpagenodes')
begin
Create table tbpagenodes  (
        f_lxbm	VARCHAR(2)	NOT NULL  DEFAULT(''),     --行业类别编码
        f_bm    VARCHAR(50)     NOT NULL  DEFAULT('') ,    --界面编码
        f_zdid  VARCHAR(50)               DEFAULT(''),     --界面字段编码
        f_zdmc  VARCHAR(250)              DEFAULT(''),     --界面字段名称
        ConstraINT ptbpagenodes Primary Key(f_lxbm,f_bm,f_zdid)
)
end
     
  --商户档案表
if not exists(select * from sysobjects where name='tbShda')
begin
CREATE TABLE tbShda
      (
       f_Shbm    VARCHAR(12)   NOT NULL DEFAULT(''),   --商户编码
       f_Shmc    VARCHAR(60)   NOT NULL DEFAULT(''),   --商户名称      
       f_lxbm    VARCHAR(2)    NOT NULL DEFAULT(''),   --类型编码
       f_sfls    INT                    DEFAULT(0) ,   --是否连锁1 不连锁 2连锁
       f_Zjf     VARCHAR(60)            DEFAULT(''),   --助记符                  
       f_shzt    INT                    DEFAULT(0) ,   --商户状态  0 待审核 1 审核通过  2审核未通过    3停用        
       f_Yb      VARCHAR(10)            DEFAULT(''),   --邮编                   
       f_Dz      VARCHAR(180)           DEFAULT(''),   --地址                
       f_Dh      VARCHAR(20)            DEFAULT(''),   --电话                
       f_Cz      VARCHAR(20)            DEFAULT(''),   --传真              
       f_Email   VARCHAR(20)            DEFAULT(''),   --EMAIL               
       f_Khh     VARCHAR(80)            DEFAULT(''),   --开户行            
       f_Zh      VARCHAR(20)            DEFAULT(''),   --账号          
       f_Sh      VARCHAR(20)            DEFAULT(''),   --税号                 
       f_Fr      VARCHAR(10)            DEFAULT(''),   --法人             
       f_Zczb    FLOAT                  DEFAULT(0),    --注册资本               
       f_Bzj     FLOAT                  DEFAULT(0),    --保证金               
       f_Jgdm    VARCHAR(20)            DEFAULT(''),   --机构代码 
       f_sjh     VARCHAR(11)            DEFAULT(''),   --手机  
       f_mm      VARCHAR(20)            DEFAULT(''),   --登录密码（ 需要加密存储） 
       f_dqrq    VARCHAR(8)             DEFAULT(''),   --到期日期
       f_qybm    VARCHAR(20)            NOT NULL  DEFAULT(''),   --区域编码
	   f_Xxdz 	 VARCHAR(200)    		DEFAULT(''),	 	---详细地址
	   f_jyxkzh  VARCHAR(200)    		DEFAULT('')	 	---农药经营许可证号	   
       ConstraINT PShda_Shbm  Primary Key(f_Shbm),
       Constraint fshda_qybm foreign key(f_qybm) references tbqyda(f_qybm)
       )
end

 --商户部门注册
if not exists(select * from sysobjects where name='tbShbmzc')
begin
CREATE TABLE tbShbmzc
      (
       f_Shbm      VARCHAR(7)   DEFAULT(''),      --商户编码
       f_Bmbm      VARCHAR(6)   DEFAULT(''),      --门店编码
       f_zclx      VARCHAR(2)   DEFAULT(''),      --0 服务费  1注册费
       f_zcje      FLOAT        DEFAULT(0),       --金额
       f_zffs      INT,                           --支付方式
       f_Zch       VARCHAR(100) DEFAULT(''),      --注册号
       f_Zcrq      VARCHAR(8)   DEFAULT(''),      --注册日期
       f_dqrq      VARCHAR(8)   DEFAULT(''),      --到期日期
       f_zdrq      VARCHAR(8)   DEFAULT(''),      --操作日期
       ConstraINT PShbmzc  Primary Key(f_Shbm,f_Bmbm,f_zdrq)
)
end


--总商品类别档案
if not exists(select * from sysobjects where name='tbSplbda')
begin
Create Table tbSplbda 
( f_lxbm	VARCHAR(2)	    NOT NULL  DEFAULT(''),    --商户类型编码
  f_Splbbm    VARCHAR(15)    NOT NULL    DEFAULT(''),    --商品类别编码          
  f_Splbmc    VARCHAR(60)    NOT NULL    DEFAULT(''),    --商品类别名称           
  f_Jb        INT            NOT NULL    DEFAULT(0),     --级别            
  f_Mj        INT            NOT NULL    DEFAULT(0),     --末级标志           
  f_Memo      VARCHAR(100)   NOT NULL    DEFAULT(''),    --备注          
  f_c_col1    VARCHAR(20)    NOT NULL    DEFAULT(''),    --备用Col           
  f_c_col2    VARCHAR(20)    NOT NULL    DEFAULT(''),    --备用Col          
  f_c_col3    VARCHAR(20)    NOT NULL    DEFAULT(''),    --备用Col          
  f_f_col1    FLOAT          NOT NULL    DEFAULT(0),     --备用Col          
  f_f_col2    FLOAT          NOT NULL    DEFAULT(0),     --备用Col           
  f_f_col3    FLOAT          NOT NULL    DEFAULT(0),     --备用Col          
  ConstraINT pSplbda Primary Key(f_lxbm,f_Splbbm)
)
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','01','农药','1','0')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0101','杀虫剂','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0102','杀菌剂','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0103','除草剂','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0104','其他农药','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','02','化肥','1','0')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0201','复合肥','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0202','尿素','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0203','钾肥','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0204','其他化肥','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','03','其他','1','0')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0301','种子','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','0302','包装物','2','1')
insert into dbo.tbSplbda(f_lxbm,f_Splbbm,f_Splbmc,f_Jb,f_mj) values ('1','04','原材料','1','1')

end


--总商品类别对照
if not exists(select * from sysobjects where name='tbSplbdz')
begin
Create Table tbSplbdz 
( f_lxbm      VARCHAR(2)     NOT NULL    DEFAULT(''),    --商户类型编码
  f_Splbbm    VARCHAR(15)    NOT NULL    DEFAULT(''),    --商品类别编码           
  f_Sptm      VARCHAR(15)    NOT NULL    DEFAULT(''),    --商品编码            
  f_c_col1    VARCHAR(20)    NOT NULL    DEFAULT(''),    --备用Col          
  f_c_col2    VARCHAR(20)    NOT NULL    DEFAULT(''),    --备用Col          
  f_c_col3    VARCHAR(20)    NOT NULL    DEFAULT(''),    --备用Col          
  f_f_col1    FLOAT          NOT NULL    DEFAULT(0),     --备用Col          
  f_f_col2    FLOAT          NOT NULL    DEFAULT(0),     --备用Col            
  f_f_col3    FLOAT          NOT NULL    DEFAULT(0),     --备用Col         
  ConstraINT pSplbdz Primary Key(f_lxbm,f_SPLbbm, f_Sptm),
  ConstraINT fSplbdz Foreign Key(f_lxbm,f_Splbbm) References tbSplbda(f_lxbm,f_Splbbm)
)
end

 
--总商品档案
if not exists(select * from sysobjects where name='tbSpda')
begin
Create Table tbSpda
       (f_lxbm	   VARCHAR(2)	 NOT NULL  DEFAULT(''),  --商户类型编码
        f_Sptm     VARCHAR(15)   NOT NULL  DEFAULT(''),  --商品编码
        f_ypzjh    VARCHAR(15)   NOT NULL  DEFAULT(''),  --药品登记号
        f_Spmc     VARCHAR(80)   NOT NULL  DEFAULT(''),  --商品名称          
        f_Spcd     VARCHAR(12)   NOT NULL  DEFAULT(''),  --商品产地        
        f_Ggxh     VARCHAR(30)   NOT NULL  DEFAULT(''),  --规格型号            
        f_Sppp     VARCHAR(20)   NOT NULL  DEFAULT(''),  --商品品牌         
        f_Sl       FLOAT         NOT NULL  DEFAULT(17),  --进项税率          
        f_Xxsl     FLOAT         NOT NULL  DEFAULT(17),  --销项税率          
        f_Jldw     VARCHAR(10)   NOT NULL  DEFAULT(''),  --标准计量单位                    
        f_Spdj     VARCHAR(20)   NOT NULL  DEFAULT(''),  --商品等级                                 
        f_Yssp     VARCHAR(2)    NOT NULL  DEFAULT('0'),  --应税商品 0：正常商品 1：应税商品       
        f_c_colum1 VARCHAR(20)   NOT NULL  DEFAULT(''),  --预留字符型字段1       
        f_c_colum2 VARCHAR(20)   NOT NULL  DEFAULT(''),  --预留字符型字段2       
        f_c_colum3 VARCHAR(100)  NOT NULL  DEFAULT(''),  --助记符      
        f_c_colum4 VARCHAR(20)   NOT NULL  DEFAULT(''),  --预留字符型字段4        
        f_c_colum5 VARCHAR(20)   NOT NULL  DEFAULT(''),  --预留字符型字段5       
        f_f_colum1 FLOAT         NOT NULL  DEFAULT(0),   --预留浮点型字段1     
        f_f_colum2 FLOAT         NOT NULL  DEFAULT(0),   --预留浮点型字段2      
        f_f_colum3 FLOAT         NOT NULL  DEFAULT(0),   --预留浮点型字段3      
        f_f_colum4 FLOAT         NOT NULL  DEFAULT(0),   --预留浮点型字段4      
        f_f_colum5 FLOAT         NOT NULL  DEFAULT(0),   --预留浮点型字段5                           
        ConstraINT pSpda Primary Key(f_lxbm,f_Sptm)
        )
end

--支付方式档案总表
if not exists(select * from sysobjects where name='tbZffsda')
begin
CREATE TABLE tbZffsda
	  (
	   f_Zfbm	VARCHAR(2)	    NOT NULL  DEFAULT(''),    --支付方式编码
	   f_Zfmc	VARCHAR(20)         NOT NULL  DEFAULT(''),    --支付方式名称
	   f_Zflx	VARCHAR(2)	    NOT NULL  DEFAULT(''),    --支付类型
	   f_Sfqy	INT                 NOT NULL  DEFAULT(1),     --是否启用
	   f_Sfdyjk	INT                 NOT NULL  DEFAULT(0),     --是否调用接口
	   f_Sfyxzl     INT                 NOT NULL  DEFAULT(0),     --是否允许找零
	   f_Jkwjmc	VARCHAR(100)        NOT NULL  DEFAULT(''),    --接口文件名称 
	   f_Sfyxth	INT                 NOT NULL  DEFAULT(0),     --是否允许退货
	   f_Jslx       INT                 NOT NULL  DEFAULT(0),     --计算类型 0 计算 1 扣除 2 不计算
	   f_Xgrq	VARCHAR(8)	    NOT NULL  DEFAULT(''),    --修改日期
	   f_Bz		VARCHAR(500)        NOT NULL  DEFAULT(''),    --备注
	   f_c_col1	VARCHAR(30)	    NOT NULL  DEFAULT(''), 
	   f_c_col2	VARCHAR(30)	    NOT NULL  DEFAULT(''),
	   f_c_col3	VARCHAR(30)	    NOT NULL  DEFAULT(''),
	   f_f_col1	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col2	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col3	FLOAT		    NOT NULL  DEFAULT(0),
	   CONSTRAINT pZffsda PRIMARY KEY(f_Zfbm)
	   )
end


-- 总权限表         
if not exists(select * from sysobjects where name='tbQx')
begin   
Create Table tbQx
      (
       f_Qxbm  VARCHAR(10),                       --权限编码
       f_Qxmc  VARCHAR(50),                       --权限名称
       f_JB    INT,                               --级别
       f_SFMJ  INT,                               --是否末级  0 否 1 是
       ConstraINT pQx Primary Key(f_Qxbm)
       )
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('00','生产','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0001','原料采购','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0002','原料采购查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0003','产品销售','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0004','产品销售查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('01','销售','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0101','销售单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0102','销售退货','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0103','销售查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0104','登录跳转销售单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('02','进货','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0201','进货单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0202','进货退货','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0203','进货查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('03','损益','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0301','损益单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0302','损益查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('04','配送','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0401','配送单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0402','配送退货','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0403','配送查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('05','台账','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0501','销售台账','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0502','进货台账','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('06','库存','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0601','库存报表','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0602','移库处理','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0603','仓库报表','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('07','资料','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0701','门店资料','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0702','职员资料','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0703','商品类别','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0704','商品资料','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0705','供应商资料','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0706','客户资料','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0707','角色维护','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0708','参数设置','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0709','仓库档案维护','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0710','公司信息','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0711','统计类型维护','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0712','统计明细维护','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0713','补贴标准设置','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0714','经营季设置','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('08','调拨','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0801','调拨单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('09','欠款','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('0901','欠款查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('10','包装物','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1001','包装物回收单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1002','处置记录登记','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1003','包装物回收查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1004','包装物拨入单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1005','包装物拨入查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1006','包装物拨出单','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1007','包装物拨出查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('11','信息管理','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1101','信息分类','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1102','信息维护','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('12','报表','1','0')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1201','综合进销存查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1202','出入库查询','2','1')
insert into dbo.tbQx(f_Qxbm,f_Qxmc,f_JB,f_SFMJ) values ('1203','销售季报表','2','1')	   
end



-- 微信扫描商品表         
if not exists(select * from sysobjects where name='tbwxsp')
begin  
create table tbwxsp(
	f_sptm varchar(15) not null default '',
	f_zybm varchar(8) not null default '',
	f_shbm varchar(12) not null default '',
	f_djlx int default 0,	--0销售单，1进货单
	ConstraINT pWxsp Primary Key(f_sptm,f_zybm,f_shbm,f_djlx)
)
end

-- 交互公司档案         
if not exists(select * from sysobjects where name='tbjhgsda')
begin  
CREATE TABLE tbjhgsda
	  (
	   f_jhgsbm	VARCHAR(10)	    NOT NULL  DEFAULT(''),    --交互公司编码
	   f_jhgsmc	VARCHAR(50)         NOT NULL  DEFAULT(''),    --交互公司名称
	   f_Bz		VARCHAR(500)        NOT NULL  DEFAULT(''),    --备注
	   f_c_col1	VARCHAR(30)	    NOT NULL  DEFAULT(''), 
	   f_c_col2	VARCHAR(30)	    NOT NULL  DEFAULT(''),
	   f_c_col3	VARCHAR(30)	    NOT NULL  DEFAULT(''),
	   f_f_col1	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col2	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col3	FLOAT		    NOT NULL  DEFAULT(0),
	   CONSTRAINT jhgsda PRIMARY KEY(f_jhgsbm)
	   )
insert INTo tbjhgsda(f_jhgsbm,f_jhgsmc)values('0','常信公司')
end

-- 读卡器品牌档案      
if not exists(select * from sysobjects where name='tbdkqppda')
begin  
CREATE TABLE tbdkqppda
	  (
	   f_dkqppbm	VARCHAR(10)	    NOT NULL  DEFAULT(''),    --读卡器品牌编码
	   f_dkqppmc	VARCHAR(50)         NOT NULL  DEFAULT(''),    --读卡器品牌名称
	   f_Bz		VARCHAR(500)        NOT NULL  DEFAULT(''),    --备注
	   f_c_col1	VARCHAR(30)	    NOT NULL  DEFAULT(''), 
	   f_c_col2	VARCHAR(30)	    NOT NULL  DEFAULT(''),
	   f_c_col3	VARCHAR(30)	    NOT NULL  DEFAULT(''),
	   f_f_col1	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col2	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col3	FLOAT		    NOT NULL  DEFAULT(0),
	   CONSTRAINT dkqppda PRIMARY KEY(f_dkqppbm)
	   )
insert INTo tbdkqppda(f_dkqppbm,f_dkqppmc)values('0','明泰')
end

-- 读卡器品牌档案      
if not exists(select * from sysobjects where name='tbdkqppda')
begin  
CREATE TABLE tb_Jyztdz (
  f_xh int  NOT NULL,								--序号
  f_Xzmc varchar(255) NOT NULL  DEFAULT(''),		--乡镇名称
  f_Ztmc varchar(255) NOT NULL  DEFAULT(''),		--主体名称
  f_Wdmc varchar(255) NOT NULL  DEFAULT(''),		--网点名称
  f_Shmc varchar(255) NOT NULL  DEFAULT(''),		--商户名称
  CONSTRAINT Jyztdz PRIMARY KEY(f_xh)
)
end



end