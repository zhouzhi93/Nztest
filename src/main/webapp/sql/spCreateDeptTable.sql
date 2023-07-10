USE [INFOLYW]
GO
/****** Object:  StoredProcedure [dbo].[spCreateDeptTable]    Script Date: 2023/4/7 12:16:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[spCreateDeptTable](@lxbm VARCHAR(8),@shbm VARCHAR(8),@shmc VARCHAR(100))
AS
set nocount on
declare @sql VARCHAR(8000)
begin tran

---界面档案表(对应不同页面)
set @sql='Create table tb'+@shbm+'_pages  (
        f_bm     VARCHAR(50) ,                  ---编码
        f_mc     VARCHAR(255)   DEFAULT(''''),     ---名称
        f_sm     VARCHAR(50)    DEFAULT(''''),     ---说明
        ConstraINT p'+@shbm+'_pages  Primary Key(f_bm)
)'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_pages select * from tbpages'
Execute(@sql)

---界面元素表（对应不同页面的元素）
set @sql='Create table tb'+@shbm+'_pagenodes  (
        f_bm        VARCHAR(50) ,                  ---界面编码
        f_zdid      VARCHAR(50)   DEFAULT(''''),      ---界面字段编码
        f_zdmc      VARCHAR(250)    DEFAULT(''''),    ---界面字段名称
        ConstraINT p'+@shbm+'_pagenodes Primary Key(f_bm,f_zdid)
)'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_pagenodes(f_bm,f_zdid,f_zdmc)
 select f_bm,f_zdid,f_zdmc from tbpagenodes where f_lxbm='''+@lxbm+''''
Execute(@sql)

--- 商户权限表      
set @sql='Create Table  tb'+@shbm+'_Qx
      (
       f_Qxbm  VARCHAR(10),                       ---权限编码
       f_Qxmc  VARCHAR(50),                       ---权限名称
       f_JB    INT,                               ---级别
       f_SFMJ  INT,                               ---是否末级  0 否 1 是
       ConstraINT p'+@shbm+'_Qx Primary Key(f_Qxbm)
       ) '

Execute(@sql)    


set @sql='insert into tb'+@shbm+'_qx(f_qxbm,f_qxmc,f_jb,f_sfmj) 
  select f_qxbm,f_qxmc,f_jb,f_sfmj from tbqx '
Execute(@sql)


--- 商户职员档案
set @sql='Create Table  tb'+@shbm+'_Zyda
      (
       f_Zybm     VARCHAR(8),                      ---职员编码
       f_Zymc     VARCHAR(20)     DEFAULT(''''),      ---职员名称                
       f_Xgrq     VARCHAR(20)     DEFAULT(''''),      ---修改日期          
       f_Zykl     VARCHAR(20)     DEFAULT(''''),          
       f_sjh      VARCHAR(11)     DEFAULT(''''),      ---手机号码                                 
       f_Zjf	  VARCHAR(60)     DEFAULT(''''),      --助记符
       ConstraINT p'+@shbm+'_Zyda Primary Key(f_Zybm)
      )'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_zyda(f_zybm,f_zymc,f_xgrq,f_zykl,f_sjh) 
select '''+@shbm+'01'',''管理员'',convert(varchar(8),getdate(),112),f_mm,f_sjh
 from tbShda where f_shbm='''+@shbm+''''
Execute(@sql)


---  商户角色档案表
set @sql='Create Table  tb'+@shbm+'_Jsda
    ( f_Jsbm    VARCHAR(20)   NOT NULL ,
      f_Jsmc    VARCHAR(50)   NOT NULL  DEFAULT(''''),
      f_Sfkj    INT           NOT NULL  DEFAULT(0),
      f_Jslx    INT           NOT NULL  DEFAULT(0),
      f_c_col1  VARCHAR(50)   NOT NULL  DEFAULT(''''),
      f_c_col2  VARCHAR(50)   NOT NULL  DEFAULT(''''),
      f_c_col3  VARCHAR(50)   NOT NULL  DEFAULT(''''),
      f_c_col4  VARCHAR(50)   NOT NULL  DEFAULT(''''),
      f_c_col5  VARCHAR(50)   NOT NULL  DEFAULT(''''),
      f_f_col1  FLOAT         NOT NULL  DEFAULT(0),
      f_f_col2  FLOAT         NOT NULL  DEFAULT(0),
      f_f_col3  FLOAT         NOT NULL  DEFAULT(0),
      f_f_col4  FLOAT         NOT NULL  DEFAULT(0),
      f_f_col5  FLOAT         NOT NULL  DEFAULT(0),
  ConstraINT p'+@shbm+'_Jsda Primary Key(f_Jsbm)
)'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_jsda(f_jsbm,f_jsmc,f_sfkj)values(''0'',''管理员'',1)'
Execute(@sql)

--- 商户角色与权限对照表
set @sql='Create Table  tb'+@shbm+'_Jsqxdz
      (
       f_Jsbm      VARCHAR(20)    NOT NULL ,
       f_Qxbm      VARCHAR(20)    NOT NULL ,
       f_c_col1    VARCHAR(50)    NOT NULL  DEFAULT(''''),
       f_c_col2    VARCHAR(50)    NOT NULL  DEFAULT(''''),
       f_c_col3    VARCHAR(50)    NOT NULL  DEFAULT(''''),
       f_c_col4    VARCHAR(50)    NOT NULL  DEFAULT(''''),
       f_c_col5    VARCHAR(50)    NOT NULL  DEFAULT(''''),
       f_f_col1    FLOAT          NOT NULL  DEFAULT(0),
       f_f_col2    FLOAT          NOT NULL  DEFAULT(0),
       f_f_col3    FLOAT          NOT NULL  DEFAULT(0),
       f_f_col4    FLOAT          NOT NULL  DEFAULT(0),
       f_f_col5    FLOAT          NOT NULL  DEFAULT(0)
     ConstraINT  p'+@shbm+'_Jsqxdz Primary Key(f_jsbm,f_Qxbm)    
)'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_jsqxdz(f_jsbm,f_qxbm)
  select ''0'',f_qxbm from tb'+@shbm+'_qx'
Execute(@sql)


  --- 商户职员权限表
set @sql='Create Table  tb'+@shbm+'_Zyqx
      (
       f_Zybm    VARCHAR(8),           ---操作员编码
       f_Qxbm    VARCHAR(12),          ---权限编码
       ConstraINT  p'+@shbm+'_Zyqx Primary Key(f_Zybm,f_Qxbm)
       )'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_zyqx(f_zybm,f_qxbm)
  select '''+@shbm+'01'',f_qxbm from tb'+@shbm+'_qx'
Execute(@sql)


  --- 商户职员所辖部门
set @sql='Create Table  tb'+@shbm+'_zysxbm
      (
       f_Zybm      VARCHAR(8),       ---职员编码
       f_Bmbm      VARCHAR(12),      ---部门编码
       f_Xh        INT,              ---序号
       ConstraINT p'+@shbm+'_Zysxbm Primary Key(f_Zybm,f_Xh,f_Bmbm)
       )'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_zysxbm(f_zybm,f_xh,f_bmbm)values('''+@shbm+'01'',''0'','''+@shbm+''')'
Execute(@sql)

---商户支付方式档案
set @sql='Create Table  tb'+@shbm+'_Zffsda
	  (
	   f_Zfbm	VARCHAR(2)	    NOT NULL  DEFAULT(''''),    ---支付方式编码
	   f_Zfmc	VARCHAR(20)         NOT NULL  DEFAULT(''''),    ---支付方式名称
	   f_Zflx	VARCHAR(2)	    NOT NULL  DEFAULT(''''),    ---支付类型
	   f_Sfqy	INT                 NOT NULL  DEFAULT 1,     ---是否启用
	   f_Sfdyjk	INT                 NOT NULL  DEFAULT(0),     ---是否调用接口
	   f_Sfyxzl     INT                 NOT NULL  DEFAULT(0),     ---是否允许找零
	   f_Jkwjmc	VARCHAR(100)        NOT NULL  DEFAULT(''''),    ---接口文件名称 
	   f_Sfyxth	INT                 NOT NULL  DEFAULT(0),     ---是否允许退货
	   f_Jslx       INT                 NOT NULL  DEFAULT(0),     ---计算类型 0 计算 1 扣除 2 不计算
	   f_Xgrq	VARCHAR(8)	    NOT NULL  DEFAULT(''''),    ---修改日期
	   f_Bz		VARCHAR(500)        NOT NULL  DEFAULT(''''),    ---备注
	   f_c_col1	VARCHAR(30)	    NOT NULL  DEFAULT(''''), 
	   f_c_col2	VARCHAR(30)	    NOT NULL  DEFAULT(''''),
	   f_c_col3	VARCHAR(30)	    NOT NULL  DEFAULT(''''),
	   f_f_col1	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col2	FLOAT		    NOT NULL  DEFAULT(0),
	   f_f_col3	FLOAT		    NOT NULL  DEFAULT(0),
	   CONSTRAINT p'+@shbm+'_Zffsda PRIMARY KEY(f_Zfbm)
	   )'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_zffsda select * from tbzffsda '
Execute(@sql)


  ---tbBmda  部门档案
set @sql='Create Table  tb'+@shbm+'_Bmda
       (
        f_Bmbm    VARCHAR(12)   NOT NULL  DEFAULT(''''),  ---部门编码            
        f_Bmmc    VARCHAR(60)   NOT NULL  DEFAULT(''''),  ---部门名称
        f_Zjf     VARCHAR(60)            DEFAULT(''''),  ---助记符                                 
        f_Yb      VARCHAR(10)            DEFAULT(''''),  ---邮编                  
        f_Dz      VARCHAR(180)           DEFAULT(''''),  ---地址               
        f_Dh      VARCHAR(20)            DEFAULT(''''),  ---电话            
        f_Cz      VARCHAR(20)            DEFAULT(''''),  ---传真                   
        f_Email   VARCHAR(20)            DEFAULT(''''),  ---EMAIL               
        f_Khh     VARCHAR(80)            DEFAULT(''''),  ---开户行                
        f_Zh      VARCHAR(20)            DEFAULT(''''),  ---账号                 
        f_Sh      VARCHAR(20)            DEFAULT(''''),  ---税号                   
        f_Fr      VARCHAR(10)            DEFAULT(''''),  ---法人                              
        f_Tybz    INT                    DEFAULT(0),   ---是否停用 0 否 1 是
        f_jwd     VARCHAR(100)            DEFAULT(''''),  --经纬度
        f_jyxkzh  varchar(200)           DEFAULT(''''),  --经营许可号
        f_fzrq    varchar(20)           DEFAULT(''''),  --发证日期
        f_zjyxrq  varchar(20)           DEFAULT(''''),  --证件有效期
        f_jyxk    varchar(600)          DEFAULT(''''),  --许可证图片存放路径
        f_nybz    VARCHAR(1)            DEFAULT(1),   --0、禁限农药 1、非禁限农药
        f_jyxkzbh varchar(50) not null default '''',    ---经营许可证编号
        f_jyxkzfzrq varchar(50) not null default '''',  --经营许可证发证日期
        f_jyxkzsxrq varchar(50) not null default '''',  --经营许可证失效日期
        f_jyxkz varchar(50) not null default '''',      --经营许可证
        f_sfjwjg varchar(1) not null default '''',      ---否为境外机构设立，默认否，如果选择是，则需填写如下信息
        f_cphfzm varchar(255) not null default '''',    ---产品合法证明
        f_slxsjgsm varchar(100) not null default '''',  --设立销售机构
        f_scxkzbh varchar(50) not null default '''',    ---生产许可证编号
        f_scxkzfzrq varchar(50) not null default '''',  ---生产许可证发证日期
        f_scxkzsxrq varchar(50) not null default '''',  --生产许可证失效日期
        f_scxkz varchar(255) not null default '''',     ---生产许可证
        f_sczxbz varchar(100) not null default '''',    ---产品执行标准
        f_scaqbz varchar(100) not null default '''',    ---安全生产标准化等级
        f_schbbz varchar(100) not null default '''',    ---环保等级评定
        f_xxqy varchar(100) not null default '''',      ---详细区域
        f_sczt		VARCHAR(50)	   NOT NULL   DEFAULT(''''),  ---是否上传对接公司  ''未上传		1上传  
        f_yjdz		VARCHAR(100)	   NOT NULL   DEFAULT(''''),  ---读卡器序列号
        f_yjzh 		VARCHAR(100)	   NOT NULL   DEFAULT(''''),  ---摄像头序列号
        f_yjmm 		VARCHAR(10)			NOT NULL   DEFAULT(''''),	---销售控制接口
        f_jhgsbm	VARCHAR(50)	   NOT NULL   DEFAULT(''''),	---交互公司编码
        f_dkqppbm 	VARCHAR(50)	   NOT NULL   DEFAULT(''''),	---读卡器品牌编码
		f_bmlx 		INT 		   NOT NULL   DEFAULT(0)		---部门类型(0、普通部门 1、包装物特有部门)
        ConstraINT P'+@shbm+'_Bmda  Primary Key(f_Bmbm)
        )'
Execute(@sql)


set @sql='insert into tb'+@shbm+'_bmda(f_bmbm,f_bmmc)values('''+@shbm+''','''+@shmc+''')'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Bmda(f_Bmbm,f_Bmmc,f_Zjf,f_bmlx) 
values(''900001'',ISNULL((select f_Shmc from tbShda where f_Shbm='+@shbm+'),''),isNUll((select f_Zjf from tbShda where f_Shbm='+@shbm+'),''),1)'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Bmda(f_Bmbm,f_Bmmc,f_Zjf,f_bmlx) values(''901001'',''环保局'',''HBJ'',1)'
Execute(@sql)


--tbspda 商品档案
set @sql='Create Table  tb'+@shbm+'_Spda
		(
        f_Sptm     VARCHAR(15)   NOT NULL ,             	--商品编码
        f_ypzjh    VARCHAR(15)   NOT NULL ,             	--药品登记号
        f_Sphh     VARCHAR(20)   NOT NULL  default '''',  	--商品货号          
        f_Spmc     VARCHAR(80)   NOT NULL  default '''',  	--商品名称          
        f_Spcd     VARCHAR(12)   NOT NULL  default '''',  	--商品产地        
        f_Ggxh     VARCHAR(80)   NOT NULL  default '''',  	--规格型号            
        f_Sppp     VARCHAR(20)   NOT NULL  default '''',  	--商品品牌         
        f_Sl       FLOAT         NOT NULL  default 17,  	--进项税率          
        f_Xxsl     FLOAT         NOT NULL  default 17,  	--销项税率          
        f_Jldw     VARCHAR(10)   NOT NULL  default '''',  	--标准计量单位       
        f_Sccsbm   VARCHAR(12)   NOT NULL  default '''',  	--生产厂商编码       
        f_Ftfs     VARCHAR(1)    NOT NULL  default 0, 	--多供应商的销售 应付款 分摊方式 0平均分摊 1顺序分摊
        f_Bzq      INT           NOT NULL  default 0,   	--保质期         
        f_Xsdj     FLOAT         NOT NULL  default 0,   	--零售单价         
        f_Zhjj     FLOAT         NOT NULL  default 0,   	--最后进价              
        f_Zdsj     FLOAT         NOT NULL  default 0,   	--最低零价     
        f_Jysj     FLOAT         NOT NULL  default 0,   	--建议售价     
        f_Pfj      FLOAT         NOT NULL  default 0,   	--批发价      
        f_Zgkc     FLOAT         NOT NULL  default 0,   	--最高库存     
        f_Zdkc     FLOAT         NOT NULL  default 0,   	--最低库存    
        f_Jdrq     VARCHAR(8)    NOT NULL  default '''',  	--建档日期     
        f_Xjbz     INT           NOT NULL  default 0,   	--下架标志 0否1是     
        f_Jhkz     INT           NOT NULL  default 0,   	--进货控制 0否1是       
        f_Zpbz     INT           NOT NULL  default 0,   	--直配标志 0否1是     
        f_Jb       INT           NOT NULL ,             	--级别
        f_Mj       INT           NOT NULL  default 1,   	--是否末级 0否1     
        f_Kl       FLOAT         NOT NULL  default 0,   	--扣率      
        f_Sdkl     FLOAT         NOT NULL  default 0,   	--时段扣率      
        f_Sdklksrq VARCHAR(10)   NOT NULL  default '''',  	--时段扣率开始日期     
        f_Sdkljsrq VARCHAR(10)   NOT NULL  default '''',  	--时段扣率结束日期     
        f_Cfbz     INT           NOT NULL  default 1,   	--能否拆分 0否1是     
        f_Zhbz     INT           NOT NULL  default 1,   	--能否组合 0否1是        
        f_Spdj     VARCHAR(20)   NOT NULL  default '''',  	--商品等级     
        f_Sptj_c   FLOAT         NOT NULL  default 0,   	--商品体积-长     
        f_Sptj_k   FLOAT         NOT NULL  default 0,   	--商品体积-宽              
        f_Sptj_g   FLOAT         NOT NULL  default 0,   	--商品体积-高      
        f_Spys     VARCHAR(10)   NOT NULL  default '''',  	--商品颜色 改成是否大集线上商品0否1是       
        f_Spks     VARCHAR(10)   NOT NULL  default '''',  	--商品款式           
        f_Wxpbz    INT           NOT NULL  default 0,   	--危险品标准 0否1是       
        f_Mjbz     INT           NOT NULL  default 1,   	--是否免检商品 0否1是      
        f_Thbz     INT           NOT NULL  default 1,   	--能否退货标志 0否1是       
        f_Thjc     INT           NOT NULL  default 0,   	--退货是否检查 0否1是     
        f_Spjx     VARCHAR(20)   NOT NULL  default '''',  	--商品剂型(商品帐期)           
        f_Zzxbz    INT           NOT NULL  default 0,   	--是否需要周转箱标志 0否1是     
        f_Zzxcc    FLOAT         NOT NULL  default 0,   	--周转箱尺寸      
        f_Zzxjg    FLOAT         NOT NULL  default 0,   	--周转箱价格      
        f_Zzxjebz  INT           NOT NULL  default 0,   	--是否收取周转箱金额 0否1是     
        f_Bjkc     FLOAT         NOT NULL  default 0,   	--报警库存      
        f_Aqkc     FLOAT         NOT NULL  default 0,   	--安全库存      
        f_bhfs     INT           NOT NULL  default 0, 		--补货方式0 卖一补一1 最高/最低指数分配2 周期平均销售法3 自适应最高/最低
        f_jjxsp    INT           NOT NULL  default 0,   	--季节性商品  0否1是           
        f_jhksrq   VARCHAR(8)    NOT NULL  default '''',  	--允许进货开始日期      
        f_jhjsrq   VARCHAR(20)   NOT NULL  default '''',  	--允许进货结束日期     
        f_xsksrq   VARCHAR(8)    NOT NULL  default '''',  	--允许销售开始日期     
        f_xsjsrq   VARCHAR(8)    NOT NULL  default '''',  	--允许销售结束日期    
        f_jdrmc    VARCHAR(10)   NOT NULL  default '''',  	--建档人名称      
        f_zhxgrq   VARCHAR(12)   NOT NULL  default '''',  	--最后修改日期       
        f_zhxgrmc  VARCHAR(10)   NOT NULL  default '''',  	--最后修改人名称       
        f_Zjzsdqr  VARCHAR(8)    NOT NULL  default '''',  	--质检证书到期日         
        f_Mjzsdqr  VARCHAR(8)    NOT NULL  default '''',  	--免检证书到期日         
        f_Yssp     VARCHAR(2)    NOT NULL  default 0, 	--应税商品 0 正常商品 1 应税商品 
        f_jfbl     FLOAT         NOT NULL  default 1,   	--积分比率       
        f_c_colum1 VARCHAR(20)   NOT NULL  default '''',  	--预留字符型字段1  商品结算期     
        f_c_colum2 VARCHAR(20)   NOT NULL  default '''',  	--预留字符型字段2  总部贴牌     
        f_c_colum3 VARCHAR(100)  NOT NULL  default '''',  	--助记符      
        f_c_colum4 VARCHAR(20)   NOT NULL  default '''',  	--预留字符型字段4  服装标志      
        f_c_colum5 VARCHAR(20)   NOT NULL  default '''',  	--预留字符型字段5  商品采购类型       
        f_f_colum1 FLOAT         NOT NULL  default 0,   	--商品种类(0普通商品 1包装物)
        f_f_colum2 FLOAT         NOT NULL  default 0,   	--预留浮点型字段2      
        f_f_colum3 FLOAT         NOT NULL  default 0,   	--预留浮点型字段3      
        f_f_colum4 FLOAT         NOT NULL  default 0,   	--预留浮点型字段4      
        f_f_colum5 FLOAT         NOT NULL  default 0,   	--预留浮点型字段5
        f_nybz VARCHAR(1)         NOT NULL  default 1,   	--农药标志
        f_nycpdjz varchar(255)   not null  default '''',      ---农药登记证
        f_nycpbz varchar(255)   not null   default '''',      --农药产品包装
        f_nycpbq varchar(255)   not null   default '''',      ---农药产品标签
        f_nycpsms varchar(255)   not null  default '''',      ---说明书
        f_nycpzmwjbh varchar(100)   not null default '''',    --相关许可证明文件编号  
        f_zhl varchar(30)   not null default '''',    --总含量（如: 1.8%、2.5%等）
        f_jx varchar(30)   not null default '''',    --剂型（如水剂、乳油、可湿性粉剂等）
        f_mbzzl varchar(30)   not null default '''',    --每包装重量
        f_mbzzldw varchar(30)   not null default '''',    --每包装重量   单位：ML、G   
        f_sptp varchar(255)   not null  default ''/images/default.png'',      ---商品图片地址
		f_yxcf VARCHAR(50)    NOT NULL   DEFAULT('')  			--有效成分
		f_dxbm VARCHAR(10)    NOT NULL   DEFAULT('')  			--毒性编码
		f_yxq  VARCHAR(20)    NOT NULL   DEFAULT('')  			--有效期
		f_scqy VARCHAR(100)   NOT NULL   DEFAULT('')  			--生产企业
		f_ppmc VARCHAR(100)   NOT NULL   DEFAULT('')  			--品牌名称
		f_syfw VARCHAR(200)   NOT NULL   DEFAULT('')  			--适用范围		
        ConstraINT p'+@shbm+'_Spda Primary Key(f_Sptm)
        )'
        
        
Execute (@sql)

set @sql='insert into tb'+@shbm+'_Spda(f_Sptm,f_ypzjh,f_Spmc,f_Spcd,f_Ggxh,f_Sppp,f_Sl,f_Xxsl,f_Jldw,f_Spdj,f_Yssp,f_jb) 
          select f_Sptm,f_ypzjh,f_Spmc,f_Spcd,f_Ggxh,f_Sppp,f_Sl,f_Xxsl,f_Jldw,f_Spdj,f_Yssp,1 
          from tbspda where f_lxbm='''+@lxbm+''''
  Execute(@sql)


---商品类别档案
set @sql='Create Table  tb'+@shbm+'_Splbda 
(
  f_Splbbm    VARCHAR(15)    NOT NULL    DEFAULT(''''),    ---商品类别编码          
  f_Splbmc    VARCHAR(60)    NOT NULL    DEFAULT(''''),    ---商品类别名称           
  f_Jb        INT            NOT NULL    DEFAULT(0),     ---级别            
  f_Mj        INT            NOT NULL    DEFAULT(0),     ---末级标志           
  f_Memo      VARCHAR(100)   NOT NULL    DEFAULT(''''),    ---备注          
  f_c_col1    VARCHAR(20)    NOT NULL    DEFAULT(''''),    ---备用Col           
  f_c_col2    VARCHAR(20)    NOT NULL    DEFAULT(''''),    ---备用Col          
  f_c_col3    VARCHAR(20)    NOT NULL    DEFAULT(''''),    ---备用Col          
  f_f_col1    FLOAT          NOT NULL    DEFAULT(0),     ---备用Col          
  f_f_col2    FLOAT          NOT NULL    DEFAULT(0),     ---备用Col           
  f_f_col3    FLOAT          NOT NULL    DEFAULT(0),     ---备用Col          
  ConstraINT p'+@shbm+'_Splbda Primary Key(f_Splbbm)
)'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_Splbda(f_splbbm,f_splbmc,f_jb,f_mj,f_memo) 
           select f_splbbm,f_splbmc,f_jb,f_mj,f_memo 
            from tbsplbda where f_lxbm='''+@lxbm+''''
Execute(@sql)

---商品类别对照
set @sql='Create Table  tb'+@shbm+'_Splbdz 
(
  f_Splbbm    VARCHAR(15)    NOT NULL    DEFAULT(''''),    ---商品类别编码           
  f_Sptm      VARCHAR(15)    NOT NULL    DEFAULT(''''),    ---商品编码            
  f_c_col1    VARCHAR(20)    NOT NULL    DEFAULT(''''),    ---备用Col          
  f_c_col2    VARCHAR(20)    NOT NULL    DEFAULT(''''),    ---备用Col          
  f_c_col3    VARCHAR(20)    NOT NULL    DEFAULT(''''),    ---备用Col          
  f_f_col1    FLOAT          NOT NULL    DEFAULT(0),     ---备用Col          
  f_f_col2    FLOAT          NOT NULL    DEFAULT(0),     ---备用Col            
  f_f_col3    FLOAT          NOT NULL    DEFAULT(0),     ---备用Col         
  ConstraINT p'+@shbm+'_Splbdz Primary Key(f_SPLbbm, f_Sptm),
  ConstraINT f'+@shbm+'_Splbdz Foreign Key(f_Splbbm) References tb'+@shbm+'_Splbda(f_Splbbm)
)'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_Splbdz(f_splbbm,f_sptm) 
           select f_splbbm,f_sptm
            from tbsplbdz where f_lxbm='''+@lxbm+''''
Execute(@sql)


---tbXsmxzb商品销售明细主表 
set @sql='Create Table  tb'+@shbm+'_Xsmxzb
   (
     f_Djh      VARCHAR(10)    NOT NULL ,             ---单据号
     f_Bmbm     VARCHAR(12)    NOT NULL ,             ---部门编码（柜组、连锁店）
     f_Syybm    VARCHAR(8)     NOT NULL ,             ---收银员编码
     f_Syymc    VARCHAR(12)    NOT NULL   DEFAULT(''''), ---收银员名称          
     f_Yyybm    VARCHAR(8)     NOT NULL ,             ---营业员编码
     f_Yyymc    VARCHAR(12)    NOT NULL   DEFAULT(''''), ---营业员名称          
     f_Fhrbm    VARCHAR(8)     NOT NULL   DEFAULT(''''), ---复核人编码           
     f_Fhrmc    VARCHAR(12)    NOT NULL   DEFAULT(''''), ---复核人名称          
     f_Khbm     VARCHAR(20)    NOT NULL   DEFAULT(''''), ---客户编码          
     f_Ckbm     VARCHAR(12)    NOT NULL   DEFAULT(''''), ---仓库编码            
     f_Xssj     VARCHAR(12)    NOT NULL ,             ---销售时间（自然）
     f_Rzrq     VARCHAR(8)     NOT NULL ,             ---入账日期
     f_Zfbz     VARCHAR(20)    NOT NULL ,             ---支付标志 1,现金 2,储值卡 3,卷类 4,空IC卡 5,转账 6,信用卡 
                                                     ---12,赊销 13,支付卡 14,会员卡(,分隔)
     f_Zfje     FLOAT          NOT NULL   DEFAULT(0),  ---支付金额             
     f_YDJH     VARCHAR(10)    NOT NULL   DEFAULT(''''), ---原单据号          
     f_YDJRQ    VARCHAR(8)     NOT NULL   DEFAULT(''''), ---原单据日期          
     f_YDJLX    VARCHAR(1)     NOT NULL   DEFAULT(''''), ---原单据类型0：销售单,1：出库单         
     f_Djlx     VARCHAR(1)     NOT NULL   DEFAULT(''0''),---单据类型 0：正常销售单 1：暂估销售单 2：暂估红冲单 
                                                     ---新前台单据类型为 0 正常销售 1 整单红冲 2 按单退货 3 无单退货
     f_Hcbz     VARCHAR(1)     NOT NULL   DEFAULT(''''), ---红冲标志 0：已红冲 1：未红冲         
     f_HCZXRBM  VARCHAR(8)     NOT NULL   DEFAULT(''''), ---红冲执行人编码           
     f_HCZXRMC  VARCHAR(10)    NOT NULL   DEFAULT(''''), ---红冲执行人名称           
     f_Djbz     VARCHAR(650)   NOT NULL   DEFAULT(''''), ---单据备注           
     f_HyKh     VARCHAR(20)    NOT NULL   DEFAULT(''''), ---会员卡号           
     f_ZZZT     INT            NOT NULL   DEFAULT(0),  ---财务  
     f_c_col1   VARCHAR(20)    NOT NULL   DEFAULT(''''), ---备用Col  查询模式           
     f_c_col2   VARCHAR(20)    NOT NULL   DEFAULT(''''), ---备用Col  价格模式           
     f_c_col3   VARCHAR(20)    NOT NULL   DEFAULT(''''), ---备用Col            
     f_f_col1   FLOAT          NOT NULL   DEFAULT(0),  ---备用Col           
     f_f_col2   FLOAT          NOT NULL   DEFAULT(0),  ---备用Col         
     f_f_col3   FLOAT          NOT NULL   DEFAULT(0),  ---备用Col   
     rediourl	VARCHAR(50)	   NOT NULL   DEFAULT(''''),    --录音文件名     
     f_sczt		VARCHAR(50)	   NOT NULL   DEFAULT('''')		---是否上传对接公司  ''未上传		1上传                             
     ConstraINT p'+@shbm+'_Xsmxzb Primary Key(f_bmbm,f_Djh)
   )'

Execute(@sql)
   

---tbXsmxcb商品销售从表
set @sql='Create Table  tb'+@shbm+'_Xsmxcb
  (
     f_Djh       VARCHAR(10)     NOT NULL ,              ---单据号
     f_Bmbm      VARCHAR(12)     NOT NULL ,              ---部门编码（柜组、连锁店）
     f_Dnxh      INT             NOT NULL ,              ---单内序号
     f_ypzjh    VARCHAR(15)   NOT NULL ,                 ---药品登记号
     f_Sptm      VARCHAR(15)     NOT NULL ,              ---商品编码
     f_Jldwlx    INT             NOT NULL   DEFAULT(0),   ---计量单位类型  一品多码的序号             
     f_Xssl      FLOAT           NOT NULL   DEFAULT(0),   ---销售数量            
     f_Ssje      FLOAT           NOT NULL   DEFAULT(0),   ---实收金额（无税）           
     f_Sssj      FLOAT           NOT NULL   DEFAULT(0),   ---实收税金           
     f_Sl        FLOAT           NOT NULL   DEFAULT(0),   ---税率            
     f_Zkzr      FLOAT           NOT NULL   DEFAULT(0),   ---折扣折让           
     f_Thyybm    VARCHAR(4)      NOT NULL   DEFAULT(''''),  ---退货原因编码          
     f_Ythrq     VARCHAR(8)      NOT NULL   DEFAULT(''''),  ---原提单日期             
     f_Ytdh      VARCHAR(30)     NOT NULL   DEFAULT(''''),  ---原提货单号            
     f_Ckbm      VARCHAR(12)     NOT NULL   DEFAULT(''''),  ---仓库编码            
     f_Fplx      VARCHAR(1)      NOT NULL   DEFAULT(''0''), ---发票类型 0提货单 1发票号
     f_Fph       VARCHAR(12)     NOT NULL   DEFAULT(''''),  ---发票号            
     f_Thlx      VARCHAR(1)      NOT NULL   DEFAULT(''''),  ---退货类型 1冲红 2实物退货
     f_Thqdh     VARCHAR(12)     NOT NULL   DEFAULT(''''),  ---退货清单号           
     f_Spbz      VARCHAR(60)     NOT NULL   DEFAULT(''''),  ---商品备注             
     f_Pch       VARCHAR(30)     NOT NULL   DEFAULT(''''),  ---合同号            
     f_Js        FLOAT           NOT NULL   DEFAULT(0),   ---件数            
     f_sgpch     VARCHAR(30)     NOT NULL   DEFAULT(''''),  ---手工批次号           
     f_Hykh      VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---会员卡号           
     f_Splx      VARCHAR(2)      NOT NULL   DEFAULT(''0''), ---商品类型  0：正常商品 1：赠品
     f_hscb 	 float		     NOT NULL   default 0,      --含税成本
     f_wscb 	 float 		     NOT NULL   default 0,      --无税成本
     f_wsml 	 float 	         NOT NULL   default 0,      --无税毛利
     f_Hth       VARCHAR(20)     NOT NULL   DEFAULT(''''),           
     f_Htlx      INT             NOT NULL   DEFAULT(0),           
     f_Gysbm     VARCHAR(15)     NOT NULL   DEFAULT(''''),            
     f_Scbz      INT             NOT NULL   DEFAULT(0),
     f_YPEWM     VARCHAR(100)     NOT NULL   DEFAULT(''''),  ---药品二维码  
     f_c_col1    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---退货单据日期            
     f_c_col2    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---备用Col            
     f_c_col3    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---备用Col               
     f_f_col1    FLOAT           NOT NULL   DEFAULT(0),   ---手工退货折扣           
     f_f_col2    FLOAT           NOT NULL   DEFAULT(0),   ---自动退货折扣            
     f_f_col3    FLOAT           NOT NULL   DEFAULT(0),   ---总退货折扣折让                                          
     f_c_col4    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---前台折扣原因1             
     f_c_col5    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---前台折扣原因2                                      
     f_c_col6    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---前台折扣原因3             
     f_c_col7    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---备用Col             
     f_c_col8    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---备用Col                                      
     f_c_col9    VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---备用Col             
     f_c_col10   VARCHAR(20)     NOT NULL   DEFAULT(''''),  ---备用Col                                         
     f_f_col4    FLOAT           NOT NULL   DEFAULT(0),   ---手工折扣金额           
     f_f_col5    FLOAT           NOT NULL   DEFAULT(0),   ---自动折扣金额           
     f_f_col6    FLOAT           NOT NULL   DEFAULT(0),   ---退货数量           
     f_f_col7    FLOAT           NOT NULL   DEFAULT(0),   ---退货金额             
     f_f_col8    FLOAT           NOT NULL   DEFAULT(0),   ---退货金额               
     ConstraINT p'+@shbm+'_Xsmxcb Primary Key(f_bmbm,f_Djh,f_Dnxh),
     ConstraINT f'+@shbm+'_Xsmxcb_Djh Foreign Key(f_bmbm,f_Djh) References tb'+@shbm+'_Xsmxzb(f_bmbm,f_Djh),
     ConstraINT f'+@shbm+'_Xsmxcb_Sptm Foreign Key(f_Sptm) References tb'+@shbm+'_Spda(f_Sptm)
    )'

Execute(@sql)


---tbXsmxcb商品支付信息表
set @sql='Create Table  tb'+@shbm+'_Xszfxx
   ( 
     f_Djh       VARCHAR(10)  NOT NULL   DEFAULT(''''),  ---单据号 
     f_Bmbm      VARCHAR(12)  NOT NULL ,              ---部门编码（柜组、连锁店）         
     f_Dnxh      INT          NOT NULL   DEFAULT(0),   ---单内序号          
     f_Zfbm      VARCHAR(2)   NOT NULL   DEFAULT(''''),  ---支付方式编码        
     f_Zflx      VARCHAR(2)   NOT NULL   DEFAULT(''''),  ---支付方式类型         
     f_Zfje      FLOAT        NOT NULL   DEFAULT(0),   ---支付金额         
     f_Czkh      VARCHAR(30)  NOT NULL   DEFAULT(''''),  ---储值卡号         
     f_c_col1    VARCHAR(30)  NOT NULL   DEFAULT(''''),  ---支付订单号        
     f_c_col2    VARCHAR(30)  NOT NULL   DEFAULT(''''),  ---支付时间        
     f_c_col3    VARCHAR(30)  NOT NULL   DEFAULT(''''),         
     f_f_col1    FLOAT        NOT NULL   DEFAULT(0),   ---接口返回的优惠金额         
     f_f_col2    FLOAT        NOT NULL   DEFAULT(0),         
     f_f_col3    FLOAT        NOT NULL   DEFAULT(0),        
     ConstraINT p'+@shbm+'_XsZfxx Primary Key(f_Djh,f_bmbm,f_Dnxh),
     )'

Execute(@sql)
  

---商品促销表
set @sql='Create Table  tb'+@shbm+'_Spcx
(
     f_Bz          VARCHAR(2)      NOT NULL ,                 ---标志
     f_bmbm        VARCHAR(12)     NOT NULL ,                 ---部门编码（柜组、连锁店） 
     f_Spbm        VARCHAR(15)     NOT NULL ,                 ---商品编码
     f_S1          VARCHAR(15)     NOT NULL     DEFAULT(''''),                
     f_S2          VARCHAR(15)     NOT NULL     DEFAULT(''''),             
     f_S3          VARCHAR(15)     NOT NULL     DEFAULT(''''),           
     f_S4          VARCHAR(15)     NOT NULL     DEFAULT(''''),             
     f_S5          VARCHAR(15)     NOT NULL     DEFAULT(''''),             
     f_F1          FLOAT           NOT NULL     DEFAULT(0),            
     f_F2          FLOAT           NOT NULL     DEFAULT(0),             
     f_F3          FLOAT           NOT NULL     DEFAULT(0),              
     f_F4          FLOAT           NOT NULL     DEFAULT(0),              
     f_F5          FLOAT           NOT NULL     DEFAULT(0),              
     f_c_col1      VARCHAR(20)     NOT NULL     DEFAULT(''''),    ---备用Col 已使用              
     f_c_col2      VARCHAR(20)     NOT NULL     DEFAULT(''''),    ---备用Col             
     f_c_col3      VARCHAR(20)     NOT NULL     DEFAULT(''''),    ---备用Col             
     f_f_col1      FLOAT           NOT NULL     DEFAULT(0),     ---备用Col            
     f_f_col2      FLOAT           NOT NULL     DEFAULT(0),     ---备用Col             
     f_f_col3      FLOAT           NOT NULL     DEFAULT(0),     ---备用Col                
)'

Execute(@sql)

/*
   说明：
      a.   标志： ‘1’ 会员特价
                  ‘2’ 会员特价折扣率
                  ‘5’ 特价
                  ‘6'  特价折扣率
      b.   f_S1~f_S5,f_F1~f_F5
         f_Bz = 1  : f_S1=会员特价起始日期，f_S2=会员特价结束日期， f_S3~f_S5为空，
                     f_F1为会员特价；同时增加f_Bz= ‘1’f_Spbm=Hytjljxf 记录，f_F1=-1
         f_Bz = 2  : f_S1=会员特价折扣率起始日期，f_S2=会员特价折扣率结束日期，f_S3~f_S5为空，
                     f_F1为会员特价折扣率
         f_Bz=5 : f_S1=特价的起始日期，f_S2=特价的结束日期, f_S3~f_S5为空，
                  f_F1=特价，f_F2~f_F5为0
         f_Bz=6 : f_S1=特价的起始日期，f_S2=特价的结束日期, f_S3~f_S5为空，
                  f_F1=特价折扣率，f_F2~f_F5为0
*/



---厂商档案
set @sql='Create Table  tb'+@shbm+'_Csda
(
      f_Cslx       VARCHAR(1)      NOT NULL     DEFAULT(''0''),     ---厂商类型 0供应商 1客户 2生产厂商
      f_Csbm       VARCHAR(20)     NOT NULL ,                    ---厂商编码
      f_Csmc       VARCHAR(60)     NOT NULL     DEFAULT(''''),      ---厂商名称           
      f_Zjf        VARCHAR(100)    NOT NULL     DEFAULT(''''),      ---助记符            
      f_Yzbm       VARCHAR(6)      NOT NULL     DEFAULT(''''),      ---邮政编码           
      f_Dz         VARCHAR(300)    NOT NULL     DEFAULT(''''),      ---地址         
      f_Dh         VARCHAR(30)     NOT NULL     DEFAULT(''''),      ---电话        
      f_Cz         VARCHAR(30)     NOT NULL     DEFAULT(''''),      ---传真       
      f_Http       VARCHAR(30)     NOT NULL     DEFAULT(''''),      ---网址        
      f_Email      VARCHAR(30)     NOT NULL     DEFAULT(''''),      ---Email      
      f_Khh        VARCHAR(40)     NOT NULL     DEFAULT(''''),      ---开户行        
      f_Zh         VARCHAR(30)     NOT NULL     DEFAULT(''''),      ---账号          
      f_Sh         VARCHAR(30)     NOT NULL     DEFAULT(''''),      ---税号         
      f_Zczb       FLOAT           NOT NULL     DEFAULT(0),       ---注册资本       
      f_Fr         VARCHAR(8)      NOT NULL     DEFAULT(''''),      ---法人       
      f_Lxr        VARCHAR(50)     NOT NULL     DEFAULT(''''),      ---联系人      
      f_Lx         VARCHAR(1)      NOT NULL     DEFAULT(''0''),     ---类型 0生产厂商 1中间商 2进口 3其他
      f_Jb         INT             NOT NULL ,                    ---级别
      f_Mj         INT             NOT NULL     DEFAULT(1),       ---是否末级 0否1是         
      f_Jzzq       INT             NOT NULL     DEFAULT(30),      ---结帐周期     
      f_Xydj       VARCHAR(15)     NOT NULL     DEFAULT(''''),      ---信用等级       
      f_Bzxx       VARCHAR(200)    NOT NULL     DEFAULT(''''),      ---备注信息        
      f_Yyzzdqr    VARCHAR(8)      NOT NULL     DEFAULT(''''),      ---营业执照到期日       
      f_Swdjdqr    VARCHAR(8)      NOT NULL     DEFAULT(''''),      ---税务登记到期日      
      f_Wsykdqr    VARCHAR(8)      NOT NULL     DEFAULT(''''),      ---卫生许可到期日       
      f_Jszq       VARCHAR(2)      NOT NULL     DEFAULT(''0''),     ---结算周期0: 任意时点 1: 月结  2: 半月结 3: 10天结   4: 周结  5: 5天结
      f_Dj         VARCHAR(4)      NOT NULL     DEFAULT(''''),      ---等级
      f_yfk        FLOAT           NOT NULL     DEFAULT(0),         ---可用预付款        
      f_qybm       VARCHAR(100)    NOT NULL     DEFAULT(''''),      ---区域编码               
      f_sfzh	   VARCHAR(30)	   NOT NULL     DEFAULT(0),		    --身份证号
      f_Scxkzh     VARCHAR(50)	   NOT NULL     DEFAULT(''''),		--生产许可证号
      f_Sfqy	   INT             NOT NULL     DEFAULT 1,          ---是否启用
      f_c_col1     VARCHAR(80)     NOT NULL     DEFAULT(''''),      ---备用Col         
      f_c_col2     VARCHAR(20)     NOT NULL     DEFAULT(''''),      ---备用Col     
      f_c_col3     VARCHAR(20)     NOT NULL     DEFAULT(''''),      ---备用Col         
      f_f_col1     FLOAT           NOT NULL     DEFAULT(0),       ---备用Col        
      f_f_col2     FLOAT           NOT NULL     DEFAULT(0),       ---备用Col       
      f_f_col3     FLOAT           NOT NULL     DEFAULT(0),       ---备用Col
	  f_Yhkh 	   VARCHAR(50) 	   NOT NULL     DEFAULT('')		  --银行卡号
	  f_Tyxym 	   VARCHAR(100)    NOT NULL     DEFAULT('')	      --统一信用码
	  f_Sfjzps     VARCHAR(10)     NOT NULL     DEFAULT('')	      --是否集中配送（否0是1）
	  f_Khlx       VARCHAR(10)     NOT NULL     DEFAULT('')		  --客户类型，0农户 1大户 2合作社	  
      ConstraINT p'+@shbm+'_Csda Primary Key(f_Csbm)
      )'

Execute(@sql)


---供应商对照
SET @Sql = 'Create Table tb'+@shbm+'_Gysdz
(
   f_Sptm       varchar(15)        Not Null,             --商品编码
   f_Gysbm      varchar(20)        Not Null,             --供应商编码
   f_Xh         int                Not Null              --序号
                default 1,
   f_Jyfs       varchar(1)         Not Null              --经营方式
                default 0,                               --0:经销 1:代销 2:联销 9 未定
   f_Sx         varchar(8)         Not Null              --时效 （允许供货的有效日期）
                default '''',
   f_Tscs       int                Not Null              --投诉次数
                default 0,
   f_Zgjj       float              Not Null              --最高进价
                default 0,
   f_Zdjj       float              Not Null              --最低进价
                default 0,
   f_Zhjj       float              Not Null              --最后进价
                default 0,
   f_Scghrq     varchar(8)         Not Null              --首次供货日期
                default '''',
   f_Scghjj     float              Not Null              --首次供货进价
                default 0,
   f_Zhghrq1    varchar(8)         Not Null              --最后第一次供货日期
                default '''',
   f_Zhghjj1    float              Not Null              --最后第一次供货进价
                default 0,
   f_Zhghrq2    varchar(8)         Not Null              --最后第二次供货日期
                default '''',
   f_Zhghjj2    float              Not Null              --最后第二次供货进价
                default 0,
   f_Zhghrq3    varchar(8)         Not Null              --最后第三次供货日期
                default '''',
   f_Zhghjj3    float              Not Null              --最后第三次供货进价
                default 0,
   f_Tgjksrq    VarChar(10)        Not Null              --特供价开始日期
                default '''',
   f_Tgjjsrq    VarChar(10)        Not Null              --特供价结束日期
                default '''',
   f_Tgj        float              Not Null              --特供价
                default 0, 
   f_first      varchar(1)         Not Null              --供应商优先级 （0：否；1：是）
                default 0,
   f_C_Col1     varchar(20)        Not Null              --备用Col
                default '''',
   f_C_Col2     varchar(20)        Not Null              --备用Col
                default '''',
   f_C_Col3     varchar(20)        Not Null              --备用Col
                default '''',
   f_F_Col1     float              Not Null              --备用Col
                default 0,
   f_F_Col2     float              Not Null              --备用Col
                default 0,
   f_F_Col3     float              Not Null              --备用Col
                default 0,
   Constraint pGysdz' +@shbm+ ' Primary Key(f_Sptm,f_Gysbm,f_Xh),
   Constraint fGysdz_Spbm' +@shbm + ' Foreign Key(f_Sptm) References tb'+ @shbm +'_Spda(f_Sptm)
)'
Execute(@Sql)
select @Sql = 'Create Index Ind' + @shbm +'_Gysdz_Sx on tb'+@shbm+'_Gysdz(f_Sx)'
Execute(@Sql)
select @Sql = 'Create Index Ind' + @shbm + '_Gysdz_Jyfs on tb'+ @shbm +'_Gysdz(f_Jyfs)'
Execute(@Sql)


--- 商品购进主表
set @sql='Create Table  tb'+@shbm+'_Spgjzb
(
      f_Gjlx      VARCHAR(1)      NOT NULL ,                  		---购进类型 0入库 1上柜(直配) 2包装物
      f_Djh       VARCHAR(10)     NOT NULL ,                  		---单据号
      f_Zdrq      VARCHAR(8)      NOT NULL ,                  		---制单日期
      f_Rzrq      VARCHAR(8)      NOT NULL ,                  		---入账日期
      f_Zdrbm     VARCHAR(8)      NOT NULL ,                  		---制单人编码
      f_Zdrmc     VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---制单人名称          
      f_Fhrbm     VARCHAR(8)      NOT NULL      DEFAULT(''''),   	---复核人编码          
      f_Fhrmc     VARCHAR(50)      NOT NULL      DEFAULT(''''),   	---复核人名称         
      f_Bmbm      VARCHAR(12)     NOT NULL ,                  		---部门编码
      f_Ckbm      VARCHAR(12)     NOT NULL      DEFAULT(''''),   	---仓库编码     
      f_Yhdh      VARCHAR(12)     NOT NULL      DEFAULT(''''),   	---运货单号     
      f_YhRq      VARCHAR(12)	  NOT NULL      DEFAULT(''''),   	---运货日期  
      f_Gysbm     VARCHAR(20)     NOT NULL ,                  		---供应商编码
      f_Zrrbm     VARCHAR(8)      NOT NULL ,                  		---责任人编码
      f_Jyfs      VARCHAR(4)      NOT NULL      DEFAULT(''0''),  	---经营方式 0经销 1代销 2联销
      f_Djlx      VARCHAR(1)      NOT NULL      DEFAULT(''0''),  	---单据类型  0 正常商品验收入库单 1 赠品验收入库单  2 暂估入库单 3 暂估红冲单
      f_YDJH      VARCHAR(18)     NOT NULL      DEFAULT(''''),   	---原单据号         
      f_YDJRQ     VARCHAR(8)      NOT NULL      DEFAULT(''''),   	---原单据日期         
      f_Hcbz      VARCHAR(1)      NOT NULL      DEFAULT(''''),   	---红冲标志 0 已红冲 1 未红冲   
      f_HCZXRBM   VARCHAR(8)      NOT NULL      DEFAULT(''''),   	---红冲执行人编码    
      f_HCZXRMC   VARCHAR(10)     NOT NULL      DEFAULT(''''),   	---红冲执行人名称     
      f_Djbz      VARCHAR(650)    NOT NULL      DEFAULT(''''),   	---单据备注
      f_State     INT             NOT NULL      DEFAULT(0),    		---单据状态 0 未审核 1 已审核    
      f_Cgdd      VARCHAR(15)     NOT NULL      DEFAULT(''''),   	---采购订单号
      f_Fph       VARCHAR(40)     NOT NULL      DEFAULT(''''),   	---发票号
      f_ZZZT	  INT 		      NOT NULL      DEFAULT(0),      	---财务    
      f_c_col1    VARCHAR(20)     NOT NULL      DEFAULT(''''),   	---拨入部门编码       
      f_c_col2    VARCHAR(20)     NOT NULL      DEFAULT(''''),		---备用的COL      
      f_c_col3    VARCHAR(20)     NOT NULL      DEFAULT(''''),   	---备用的COL     
      f_f_col1    FLOAT           NOT NULL      DEFAULT(0),    		---备用的COL        
      f_f_col2    FLOAT           NOT NULL      DEFAULT(0),    		---备用的COL      
      f_f_col3    FLOAT           NOT NULL      DEFAULT(0),    		---备用的COL  
      f_c_col4    VARCHAR(50)     NOT NULL      DEFAULT(''''),  	---备用的COL  
      f_c_col5    VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---备用的COL    
      f_c_col6    VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---备用的COL                    
      f_c_col7    VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---备用的COL   
      f_c_col8    VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---备用的COL    
      f_f_col4    decimal(20,2)   NOT NULL      DEFAULT(0),    		---备用的COL   
      f_f_col5    VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---备用的COL  
      f_f_col6    VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---备用的COL  
      f_f_col7    VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---备用的COL   
      f_f_col8    VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---备用的COL
      F_bzwczfs   varchar(20)     not null      default (''''), 	---包装物处置方式
	  f_bzwczlx   INT 			  NOT NULL 		DEFAULT(0)			---包装物操作类型(0、默认 1、拨入(XXX分店拨入XXX总部) 2、拨出(xxx总部拨入xxx环保局))	  
      ConstraINT p'+@shbm+'_Spgjzb Primary Key(f_Gjlx,f_Bmbm,f_Djh),
      ConstraINT f'+@shbm+'_Spgjzb_Bmbm Foreign Key(f_Bmbm) References tb'+@shbm+'_Bmda(f_Bmbm),
      ConstraINT f'+@shbm+'_Spgjzb_Gysbm Foreign Key(f_Gysbm) References tb'+@shbm+'_Csda(f_Csbm)
      )'

Execute(@sql)


---商品购进从表
set @sql='Create Table  tb'+@shbm+'_Spgjcb
      (
      f_Bmbm       VARCHAR(12)     NOT NULL ,                   	---部门编码
      f_Gjlx       VARCHAR(1)      NOT NULL ,                   	---购进类型 0入库 1上柜(直配) 9上海验收单
      f_Djh        VARCHAR(10)     NOT NULL ,                   	---单据号
      f_Dnxh       INT             NOT NULL ,                   	---单内序号
      f_Ckbm       VARCHAR(12)     NOT NULL       DEFAULT(''''),   	---仓库编码         
      f_Sptm       VARCHAR(15)     NOT NULL ,                   	---商品编码
      f_ypzjh      VARCHAR(15)     NOT NULL ,                 		---药品登记号
      f_Jldwlx     INT             NOT NULL       DEFAULT(0),    	---计量单位类型 一品多码的序号    
      f_Gjsl       FLOAT           NOT NULL       DEFAULT(0),    	---购进数量 
      f_Gjdj       FLOAT           NOT NULL       DEFAULT(0),    	---购进单价（无税）    
      f_Gjje       FLOAT           NOT NULL       DEFAULT(0),    	---购进金额（无税）      
      f_Gjsj       FLOAT           NOT NULL       DEFAULT(0),    	---购进税金      
      f_Sl         FLOAT           NOT NULL       DEFAULT(0),    	---税率          
      f_Lsdj       FLOAT           NOT NULL       DEFAULT(0),    	---零售单价     
      f_Lsje       FLOAT           NOT NULL       DEFAULT(0),    	---零售金额           
      f_Dqrq       VARCHAR(8)      NOT NULL       DEFAULT(''''),   	---到期日期       
      f_Hth        VARCHAR(12)     NOT NULL       DEFAULT(''''),   	---合同号    
      f_Htdnxh     INT             NOT NULL       DEFAULT(0),    	---合同单内序号
      f_Htbz       VARCHAR(60)     NOT NULL       DEFAULT(''''),   	---合同备注        
      f_Thyybm     VARCHAR(4)      NOT NULL       DEFAULT(''''),   	---退货原因编码        
      f_Ydjrq      VARCHAR(8)      NOT NULL       DEFAULT(''''),   	---原单据日期      
      f_Ydjh       VARCHAR(10)     NOT NULL       DEFAULT(''''),   	---原单据号        
      f_Ysbz       VARCHAR(60)     NOT NULL       DEFAULT(''''),   	---验收备注
      f_YhBmbm     VARCHAR(12)     NOT NULL       DEFAULT(''''),   	---要货部门编码        
      f_Yhsl       FLOAT           NOT NULL       DEFAULT(0),    	---要货数量         
      f_fglx       VARCHAR(1)      NOT NULL       DEFAULT(''''),   	---分割类型   1配送单  0销售单             
      f_Pch        VARCHAR(30)     NOT NULL       DEFAULT(''''),   	---批次号          
      f_Js         FLOAT           NOT NULL       DEFAULT(0),    	---件数          
      f_sgpch      VARCHAR(30)     NOT NULL       DEFAULT(''''),   	---手工批次号          
      f_Spbz       VARCHAR(60)     NOT NULL       DEFAULT(''''),   	---商品备注          
      f_Splx       VARCHAR(1)      NOT NULL       DEFAULT(''''),   	---商品类型  0正常商品 1赠品         
      f_YDnxh      INT             NOT NULL       DEFAULT(0),    	---原单内序号          
      f_spkd       FLOAT           NOT NULL       DEFAULT(0),    	---商品扣点          
      f_kdje       FLOAT           NOT NULL       DEFAULT(0),    	---扣点金额         
      f_scrq       VARCHAR(8)      NOT NULL       DEFAULT(''''),   	--生产日期
      f_scpch      VARCHAR(30)     NOT NULL       DEFAULT(''''),   	--生产批次号
      f_c_col1     VARCHAR(20)     NOT NULL       DEFAULT(''''),   	---拨入部门编码          
      f_c_col2     VARCHAR(20)     NOT NULL       DEFAULT(''''),  	 ---备用的COL         
      f_c_col3     VARCHAR(20)     NOT NULL       DEFAULT(''''),   	---备用的COL        
      f_f_col1     FLOAT           NOT NULL       DEFAULT(0),    	---备用的COL            
      f_f_col2     FLOAT           NOT NULL       DEFAULT(0),    	---备用的COL            
      f_f_col3     FLOAT           NOT NULL       DEFAULT(0),    	---备用的COL
	  f_bzwjcklx   INT 			   NOT NULL 	  DEFAULT(0)		---包装物操作类型(0、默认 1、入库 2、出库)	  
      ConstraINT pSpgjcb'+@shbm+'_ Primary Key(f_Gjlx,f_Bmbm,f_Djh,f_Dnxh),
      ConstraINT fSpgjcb_Djh'+@shbm+'_ Foreign Key(f_Gjlx,f_Bmbm,f_Djh) references tb'+@shbm+'_Spgjzb(f_Gjlx,f_Bmbm,f_Djh),
      ConstraINT fSpgjcb_Sptm'+@shbm+'_ Foreign Key(f_Sptm) references tb'+@shbm+'_Spda(f_Sptm)
      )'

Execute(@sql)



---商品损溢主表
set @sql='Create Table  tb'+@shbm+'_Spsyzb
    (
     f_Djh         	VARCHAR(10)     NOT NULL ,                  	---单据号
     f_Zdrq        	VARCHAR(8)      NOT NULL ,                  	---制单日期
     f_Rzrq        	VARCHAR(8)      NOT NULL ,                  	---入账日期
     f_Zdrbm       	VARCHAR(8)      NOT NULL ,                  	---制单人编码
     f_Zdrmc       	VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---制单人名称            
     f_Fhrbm       	VARCHAR(8)      NOT NULL      DEFAULT(''''),   	---复核人编码         
     f_Fhrmc       	VARCHAR(50)     NOT NULL      DEFAULT(''''),   	---复核人名称        
     f_Bmbm        	VARCHAR(12)     NOT NULL ,                  	---部门编码
     f_Ckbm        	VARCHAR(12)     NOT NULL      DEFAULT(''''),   	---仓库编码       
     f_Djlx        	VARCHAR(2)      NOT NULL      DEFAULT(''0''),  	---单据类型：0 正常损益单；1 赠品转正常商品；2  正常商品转赠品；3　盘点转损益; 4　损溢申请单; 5 总部代做损溢申请单         
     f_state       	VARCHAR(1)      NOT NULL      DEFAULT(''0''),  	---是否审核，0　未审核　　1　已审核            
     f_ZZZT	   		INT             NOT NULL      DEFAULT(0),    	---财务      	              
     f_c_col1      	VARCHAR(100)    NOT NULL      DEFAULT(''''),   	---备用Col          
     f_c_col2      	VARCHAR(20)     NOT NULL      DEFAULT(''''),   	---备用Col     
     f_c_col3      	VARCHAR(20)     NOT NULL      DEFAULT(''''),   	---备用Col
     f_f_col1      	FLOAT           NOT NULL      DEFAULT(0),    	---备用Col      
     f_f_col2      	FLOAT           NOT NULL      DEFAULT(0),    	---备用Col      
     f_f_col3      	FLOAT           NOT NULL      DEFAULT(0),    	---备用Col            
     ConstraINT p'+@shbm+'_Spsyzb Primary Key(f_Bmbm,f_Djh,f_djlx),
     ConstraINT f'+@shbm+'_Spsyzb_Bmbm Foreign Key(f_Bmbm) References tb'+@shbm+'_Bmda(f_Bmbm)
    )'

Execute(@sql)

---商品损溢从表
 set @sql='Create Table  tb'+@shbm+'_Spsycb
    (
      f_Bmbm      	VARCHAR(12)     NOT NULL ,                      		---部门编码
      f_Ckbm      	VARCHAR(12)     NOT NULL          	DEFAULT(''''),   	---仓库编码      
      f_Djh       	VARCHAR(10)     NOT NULL ,                      		---单据号
      f_djlx      	VARCHAR(2)      NOT NULL          	DEFAULT(''0''), 	---单据类型      
      f_Dnxh      	INT             NOT NULL ,                      		---单内序号
      f_Sptm      	VARCHAR(15)     NOT NULL ,                      		---商品编码
      f_ypzjh    	VARCHAR(15)   	NOT NULL ,                         		---药品登记号
      f_Jldwlx    	INT             NOT NULL          	DEFAULT(0),    		---计量单位类型 一品多码的序号         
      f_Sysl      	FLOAT           NOT NULL          	DEFAULT(0),    		---损溢数量       
      f_Sydj      	FLOAT           NOT NULL         	DEFAULT(0),    		---损溢单价（无税）        
      f_Syje      	FLOAT           NOT NULL         	DEFAULT(0),    		---损溢金额（无税）
      f_Sysj      	FLOAT           NOT NULL          	DEFAULT(0),    		---损溢税金   
      f_Sl        	FLOAT           NOT NULL          	DEFAULT(0),    		---税率      
      f_Lsdj      	FLOAT           NOT NULL          	DEFAULT(0),    		---零售单价    
      f_Lsje      	FLOAT           NOT NULL          	DEFAULT(0),    		---零售金额    
      f_Syyybm    	VARCHAR(4)      NOT NULL          	DEFAULT(''''),   	---损溢原因编码    
      f_Js        	FLOAT           NOT NULL          	DEFAULT(0),    		---件数     
      f_Sgpch     	VARCHAR(30)     NOT NULL          	DEFAULT(''''),   	---手工批次号         
      f_Pch       	VARCHAR(30)     NOT NULL          	DEFAULT(''''),   	---批次号          
      f_Splx      	VARCHAR(2)      NOT NULL          	DEFAULT(''0''),  	---商品类型 0正常商品 1赠品
      f_zhjj      	FLOAT           NOT NULL          	DEFAULT(0),    		---最后进价         
      f_c_col1    	VARCHAR(200)    NOT NULL         	DEFAULT(''''),   	---备用Col  已用　损益备注       
      f_c_col2    	VARCHAR(20)     NOT NULL          	DEFAULT(''''),   	---备用Col             
      f_c_col3    	VARCHAR(20)     NOT NULL          	DEFAULT(''''),   	---备用Col            
      f_f_col1    	FLOAT           NOT NULL          	DEFAULT(0),    		---备用Col       
      f_f_col2    	FLOAT           NOT NULL          	DEFAULT(0),    		---备用Col        
      f_f_col3    	FLOAT           NOT NULL          	DEFAULT(0),    		---备用Col
	  f_sylx 		INT 			NOT NULL 			DEFAULT(0)			---包装物操作类型(0、默认 1、升益 2、损耗)	  
     ConstraINT p'+@shbm+'_Spsycb Primary Key(f_Bmbm,f_Djh,f_djlx,f_Dnxh),
     ConstraINT f'+@shbm+'_Spsycb_Djh Foreign Key(f_Bmbm,f_Djh,f_djlx) References tb'+@shbm+'_Spsyzb(f_Bmbm,f_Djh,f_djlx),
     ConstraINT f'+@shbm+'_Spsycb_Sptm Foreign Key(f_Sptm) References tb'+@shbm+'_Spda(f_Sptm)
     )'

Execute(@sql)

---商品转移主表
set @sql='Create Table  tb'+@shbm+'_Spzyzb
(
      f_Zylx      VARCHAR(1)     NOT NULL ,                 	---转移类型  0移库 1出库（提货）2调拨 3拨入 4拨出  5原材料领用
      f_Djh       VARCHAR(10)    NOT NULL ,                 	---单据号
      f_Zdrq      VARCHAR(8)     NOT NULL ,                 	---制单日期
      f_Rzrq      VARCHAR(8)     NOT NULL ,                 	---入账日期
      f_Zdrbm     VARCHAR(8)     NOT NULL ,                 	---制单人编码
      f_Zdrmc     VARCHAR(50)    NOT NULL    DEFAULT(''''),    	---制单人名称            
      f_Fhrbm     VARCHAR(8)     NOT NULL    DEFAULT(''''),    	---复核人编码            
      f_Fhrmc     VARCHAR(50)    NOT NULL    DEFAULT(''''),    	---复核人名称            
      f_Zdbm      VARCHAR(12)    NOT NULL    DEFAULT(''''),    	---制单部门          
      f_Zcbm      VARCHAR(12)    NOT NULL    DEFAULT(''''),    	---转出部门           
      f_Zrbm      VARCHAR(12)    NOT NULL    DEFAULT(''''),   	---转入部门           
      f_Yrckbm    VARCHAR(12)    NOT NULL    DEFAULT(''''),    	---移入仓库编码           
      f_Ycckbm    VARCHAR(12)    NOT NULL    DEFAULT(''''),    	---移出仓库编码           
      f_Zrrbm     VARCHAR(12)    NOT NULL    DEFAULT(''''),    	---责任人编码           
      f_fgbz      VARCHAR(1)     NOT NULL    DEFAULT(''''),    	---分割标志 0否  1是           
      f_JZBZ      VARCHAR(1)     NOT NULL    DEFAULT(''''),    	---加载标志  0 未加载 1 已加载         
      f_Djbz      VARCHAR(650)   NOT NULL    DEFAULT(''''),    	---单据备注          
      f_ZZZT	  INT            NOT NULL    DEFAULT(0),     	---财务                           
      f_c_col1    VARCHAR(20)    NOT NULL    DEFAULT(''''),    	---备用的COL  打印标志            
      f_c_col2    VARCHAR(20)    NOT NULL    DEFAULT(''''),    	---备用的COL  单据状态  9 保存           
      f_c_col3    VARCHAR(20)    NOT NULL    DEFAULT(''''),    	---备用的COL           
      f_f_col1    FLOAT          NOT NULL    DEFAULT(0),     	---备用的COL  是否到货  0-未到货  1-已到货        
      f_f_col2    FLOAT          NOT NULL    DEFAULT(0),     	---备用的COL  装箱数量         
      f_f_col3    FLOAT          NOT NULL    DEFAULT(0),     	---备用的COL   
	  f_ckbm 	  VARCHAR(10) 	 NOT NULL 	 DEFAULT('')		---仓库编码      
      ConstraINT p'+@shbm+'_Spzyzb Primary Key(f_Zylx,f_Zdbm,f_Djh)
)'

Execute(@sql)


---商品转移从表
set @sql='Create Table  tb'+@shbm+'_Spzycb
(
     f_Zylx     VARCHAR(1)      NOT NULL ,                   	---转移类型 0移库 1出库（提货）2调拨 3拨入 4拨出  5原材料领用
     f_Djh      VARCHAR(10)     NOT NULL ,                   	---单据号
     f_Dnxh     INT             NOT NULL ,                   	---单内序号
     f_Zdbm     VARCHAR(12)     NOT NULL ,                   	---制单部门
     f_Sptm     VARCHAR(15)     NOT NULL ,                   	---商品编码
     f_ypzjh    VARCHAR(15)   	NOT NULL ,                     	---药品登记号
     f_Jldwlx   INT             NOT NULL     DEFAULT(0),      	---计量单位类型 一品多码的序号         
     f_Zhjj     FLOAT           NOT NULL     DEFAULT(0),      	---最后进价          
     f_Zysl     FLOAT           NOT NULL     DEFAULT(0),      	---转移数量          
     f_Zydj     FLOAT           NOT NULL     DEFAULT(0),     	---转移单价（无税）          
     f_Zyje     FLOAT           NOT NULL     DEFAULT(0),      	---转移金额（无税）         
     f_Zysj     FLOAT           NOT NULL     DEFAULT(0),      	---转移税金         
     f_Sl       FLOAT           NOT NULL     DEFAULT(0),      	---税率         
     f_Lsdj     FLOAT           NOT NULL     DEFAULT(0),      	---零售单价         
     f_Lsje     FLOAT           NOT NULL     DEFAULT(0),      	---零售金额         
     f_Dqrq     VARCHAR(8)      NOT NULL     DEFAULT(''''),     ---到期日期        
     f_Zyyybm   VARCHAR(4)      NOT NULL     DEFAULT(''''),     ---转移原因编码        
     f_Ytdrq    VARCHAR(8)      NOT NULL     DEFAULT(''''),     ---原提单日期          
     f_Ytdbm    VARCHAR(20)     NOT NULL     DEFAULT(''''),     ---原提单编码      
     f_Hth      VARCHAR(12)     NOT NULL     DEFAULT(''''),     ---合同号     
     f_Htdnxh   INT             NOT NULL     DEFAULT(0),      	---合同单内序号      
     f_Htbz     VARCHAR(60)     NOT NULL     DEFAULT(''''),     ---合同备注      
     f_Yrckbm   VARCHAR(12)     NOT NULL     DEFAULT(''''),     ---移入仓库编码       
     f_Ycckbm   VARCHAR(12)     NOT NULL     DEFAULT(''''),     ---移出仓库编码         
     f_Fph      VARCHAR(12)     NOT NULL     DEFAULT(''''),     ---发票号（配送提单号）         
     f_Thlx     VARCHAR(1)      NOT NULL     DEFAULT(''''),     ---退货类型  1冲红 2实物退货
     f_Thqdh    VARCHAR(12)     NOT NULL     DEFAULT(''''),     ---退货清单号       
     f_Pch      VARCHAR(30)     NOT NULL     DEFAULT(''''),     ---批次号        
     f_sgpch    VARCHAR(30)     NOT NULL     DEFAULT(''''),     ---手工批次号        
     f_Js       FLOAT           NOT NULL     DEFAULT(0),      	---件数           
     f_Spbz     VARCHAR(60)     NOT NULL     DEFAULT(''''),     ---单据备注          
     f_Splx     VARCHAR(2)      NOT NULL     DEFAULT(''0''),    ---商品类型 0：正常商品 1：赠品
     f_c_col1   VARCHAR(20)     NOT NULL     DEFAULT(''''),     ---备用的COL         
     f_c_col2   VARCHAR(20)     NOT NULL     DEFAULT(''''),     ---备用的COL   保存状态记录对应的tbwcpmx的ID号     
     f_c_col3   VARCHAR(20)     NOT NULL     DEFAULT(''''),     ---备用的COL   对应的代储单号  
     f_f_col1   FLOAT           NOT NULL     DEFAULT(0),      	---备用的COL   到货标志        
     f_f_col2   FLOAT           NOT NULL     DEFAULT(0),      	---备用的COL           
     f_f_col3   FLOAT           NOT NULL     DEFAULT(0),      	---备用的COL
	 f_hsbccb   FLOAT 			NOT NULL 	 DEFAULT(0)			---含税调拨成本
	 f_wsbccb   FLOAT 			NOT NULL 	 DEFAULT(0)			---无税调拨成本
	 f_bccj 	FLOAT 			NOT NULL 	 DEFAULT(0)			---调拨差价	 
	 f_ckbm 	VARCHAR(10) 	NOT NULL 	 DEFAULT('')		---仓库编码
	 f_drckbm   VARCHAR(10)  	NOT NULL  	 DEFAULT('')	 	---调入仓库编码
     ConstraINT p'+@shbm+'_Spzycb Primary Key(f_Zylx,f_Zdbm,f_Djh,f_Dnxh),
     ConstraINT f'+@shbm+'_Spzycb_Djh Foreign Key(f_Zylx,f_Zdbm,f_Djh) References tb'+@shbm+'_Spzyzb(f_Zylx,f_Zdbm,f_Djh),
     ConstraINT f'+@shbm+'_Spzycb_Sptm Foreign Key(f_Sptm) References tb'+@shbm+'_Spda(f_Sptm)
)'

Execute(@sql)

set @sql='alter table tb'+@shbm+'_Spzycb add f_hsbccb 	FLOAT		NOT NULL   DEFAULT(0)'		---含税调拨成本
Execute(@sql)

set @sql='alter table tb'+@shbm+'_Spzycb add f_wsbccb 	FLOAT		NOT NULL   DEFAULT(0)'		---无税调拨成本
Execute(@sql)

set @sql='alter table tb'+@shbm+'_Spzycb add f_bccj 	FLOAT		NOT NULL   DEFAULT(0)'		---调拨差价
Execute(@sql)


--商品库存表
set @sql='Create Table  tb'+@shbm+'_spkc 
(
   f_Rq        VARCHAR(8)           NOT NULL ,  --日期
   f_Bmbm      VARCHAR(12)          NOT NULL ,  --部门编码
   f_Sptm      VARCHAR(15)          NOT NULL ,  --商品编码
   f_pch       VARCHAR(30)          NOT NULL DEFAULT(''''),  --批次号
   f_Sgpch     VARCHAR(50)          NOT NULL DEFAULT('''') , --手工批次号
   f_kcsl      FLOAT                NOT NULL    DEFAULT(0),     --库存数量
   f_kcje      FLOAT                NOT NULL    DEFAULT(0),     --库存金额
   f_kcsj      FLOAT                NOT NULL    DEFAULT(0),     --库存税金
   ConstraINT p'+@shbm+'_spkc Primary Key(f_Rq,f_Bmbm,f_Sptm,f_pch),
   ConstraINT f'+@shbm+'_spkc_Sptm Foreign Key(f_Sptm) References tb'+@shbm+'_Spda(f_Sptm),
   ConstraINT f'+@shbm+'_spkc_Bmbm Foreign Key(f_Bmbm) References tb'+@shbm+'_Bmda(f_Bmbm),
)'

Execute(@sql)



--商品库存表
set @sql='Create Table  tb'+@shbm+'_sysparam 
(
   f_csmc     VARCHAR(50)           NOT NULL DEFAULT(''''),  --参数名称
   f_csz      VARCHAR(300)          NOT NULL DEFAULT(''''),  --参数值
   f_cssm     VARCHAR(100)          NOT NULL DEFAULT(''''),  --参数说明
   f_csxz     VARCHAR(500)          NOT NULL DEFAULT(''''),  --选择型值
   f_xh       int                   NOT NULL DEFAULT('''') , --显示顺序
   ConstraINT p'+@shbm+'_sysparam Primary Key(f_csmc)
)'

Execute(@sql)

set @sql='insert into tb'+@shbm+'_sysparam(f_csmc,f_csz,f_cssm,f_csxz,f_xh) values(''sljd'',''4'',''数量精度'','''',1)'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_sysparam(f_csmc,f_csz,f_cssm,f_csxz,f_xh) values(''djjd'',''4'',''单价精度'','''',1)'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_sysparam(f_csmc,f_csz,f_cssm,f_csxz,f_xh) values(''jejd'',''2'',''金额精度'','''',1)'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_sysparam(f_csmc,f_csz,f_cssm,f_csxz,f_xh) values(''spckkz'',''1'',''商品出库控制'',''0,不控制;1,控制;'',1)'
Execute(@sql)


--欠款明细表
set @sql='Create Table  tb'+@shbm+'_Qkmxb
   (
     f_Djh      VARCHAR(10)    NOT NULL ,             ---单据号
     f_Bmbm     VARCHAR(12)    NOT NULL ,             ---部门编码（柜组、连锁店）        
     f_Khbm     VARCHAR(20)    NOT NULL   DEFAULT(''''), ---客户编码            
     f_Qkrq     VARCHAR(12)    NOT NULL ,             ---欠款日期
     f_Qkje     FLOAT          NOT NULL   DEFAULT(0),  ---欠款金额            
	 f_Ysje     FLOAT          NOT NULL   DEFAULT(0),  ---已收金额     
	 f_Syje     FLOAT          NOT NULL   DEFAULT(0),  ---剩余金额     	
     f_Djbz     VARCHAR(650)   NOT NULL   DEFAULT(''''), ---单据备注           
     f_c_col1   VARCHAR(20)    NOT NULL   DEFAULT(''''), ---备用Col        
     f_c_col2   VARCHAR(20)    NOT NULL   DEFAULT(''''), ---备用Col  
     f_c_col3   VARCHAR(20)    NOT NULL   DEFAULT(''''), ---备用Col            
     f_f_col1   FLOAT          NOT NULL   DEFAULT(0),  ---备用Col           
     f_f_col2   FLOAT          NOT NULL   DEFAULT(0),  ---备用Col         
     f_f_col3   FLOAT          NOT NULL   DEFAULT(0),  ---备用Col                         
     ConstraINT p'+@shbm+'_Qkmxb Primary Key(f_bmbm,f_Djh)
   )'
Execute(@sql)

--报警库存表
set @sql='create table tb'+@shbm+'_Bjkc(
		f_Bmbm    VARCHAR(12)   NOT NULL  DEFAULT(''''),  ---部门编码      
		f_Sptm     VARCHAR(15)   NOT NULL ,             	--商品编码
		f_Bjkc     FLOAT         NOT NULL  default 0   	--报警库存 
)'
Execute(@sql)


--角色档案表
set @sql='Create Table tb'+@shbm+'_Jsdab
(
	f_jsbm	VARCHAR(12)	    NOT NULL  DEFAULT('') PRIMARY KEY,	--角色编码
	f_jsmc	VARCHAR(50)     NOT NULL  DEFAULT(''),				--角色名称
)'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Jsdab(f_jsbm,f_jsmc)values(''1000000001'',''超级管理员'')'
Execute(@sql)

--角色权限对照表
set @sql='Create Table tb'+@shbm+'_Jsqxdzb
(
	f_jsbm	VARCHAR(10)	    NOT NULL  DEFAULT(''),		--角色编码
	f_qxbm	VARCHAR(10)     NOT NULL  DEFAULT(''),		--权限编码
)'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Jsqxdzb 
select ''1000000001'',f_Qxbm from tb'+@shbm+'_Qx;'
Execute(@sql)

--角色职员对照表
set @sql='Create Table tb'+@shbm+'_Jszydzb
(
	f_jsbm	VARCHAR(10)	    NOT NULL  DEFAULT(''),		--角色编码
	f_zybm	VARCHAR(10)     NOT NULL  DEFAULT(''),		--职员编码
)'
Execute(@sql)


--类型统计维护表
set @sql='Create Table tb'+@shbm+'_tjlxwh
(
	f_tjlxmc		VARCHAR(50)	    NOT NULL  DEFAULT(''),		--统计类型名称
	f_flbm			VARCHAR(10)     NOT NULL  DEFAULT(''),		--分类编码，001
	f_sfzylx		VARCHAR(10)     NOT NULL  DEFAULT(''),		--是否种养类型，0否、1是
	f_sfsynh		VARCHAR(10)     NOT NULL  DEFAULT(''),		--是否适用农户，0否、1是
	f_sfsydh		VARCHAR(10)     NOT NULL  DEFAULT(''),		--是否适用大户，0否、1是
	f_sfsyhzs		VARCHAR(10)     NOT NULL  DEFAULT(''),		--是否适用合作社，0否、1是
)'
Execute(@sql)


--分类明细维护表
set @sql='Create Table tb'+@shbm+'_tjmxwh
(
	f_flbm		VARCHAR(10)	    NOT NULL  DEFAULT(''),		--分类编码，和上表显示序号关联，一级编码001，二级编码001001，三级编码001001001
	f_flmc		VARCHAR(50)     NOT NULL  DEFAULT(''),		--分类名称
	f_flmx		VARCHAR(10)     NOT NULL  DEFAULT(''),		--分类明细，0否、1是
	f_jb		VARCHAR(10)     NOT NULL  DEFAULT(''),		--级别，1、2、3级
	f_mj		VARCHAR(10)     NOT NULL  DEFAULT(''),		--末级，0否、1是
	f_dwmc		VARCHAR(10)     NOT NULL  DEFAULT(''),		--单位名称，亩、公斤...
)'
Execute(@sql)


--厂商统计明细对照表(厂商档案和类型统计维护表关联)
set @sql='Create Table tb'+@shbm+'_cstjmxdzb
(
	f_Csbm      VARCHAR(20)     NOT NULL	DEFAULT(''),   	--厂商编码
	f_flbm		VARCHAR(10)     NOT NULL	DEFAULT(''),	--分类编码，001
	f_sl		FLOAT           NOT NULL    DEFAULT(0),     --数量，默认0  
)'
Execute(@sql)


--厂商类型补贴标准（和统计类型维护表关联）
set @sql='Create Table tb'+@shbm+'_cslxbtbz
(
	f_flbm		VARCHAR(10)     NOT NULL	DEFAULT(''),	--分类编码，001
	f_mmje		FLOAT           NOT NULL    DEFAULT(0),     --每亩金额，默认0  
	f_Khlx 		VARCHAR(10) 	NOT NULL  	DEFAULT('')		--客户类型，0农户 1大户 2合作社
)'
Execute(@sql)



--农作物经营季设置
set @sql='Create Table tb'+@shbm+'_jyj
(
	f_jyjId			INT				NOT NULL,					--经营季id
	f_jyjName		VARCHAR(50) 	NOT NULL  	DEFAULT(''),	--经营季名称
	f_startTime		VARCHAR(10)		NOT NULL,					--开始时间
	f_endTime		VARCHAR(10)		NOT NULL, 					--结束时间
	f_Khlx 			VARCHAR(10) 	NOT NULL  	DEFAULT(''),	--客户类型，0农户 1大户 2合作社，增行时根据客户类型导入所有显示序号，并进行显示
	f_flbm			VARCHAR(10)     NOT NULL	DEFAULT(''),	--分类编码，增行时将种养类型中所有序号复制到表中。对种养类型选择时，修改state状态
	f_state			int				NOT NULL	DEFAULT(1),		--显示序号状态，0未选择1选择
)'
Execute(@sql)



--参数设置
set @sql='Create Table tb'+@shbm+'_Cssz
(
	f_csbm				VARCHAR(20)		NOT NULL	DEFAULT(''),	--参数编码
	f_csmc				VARCHAR(100)	NOT NULL	DEFAULT(''),	--参数名称
	f_csz				VARCHAR(100)	NOT NULL	DEFAULT(''),	--参数值
	f_csxz				VARCHAR(100)	NOT NULL	DEFAULT(''),	--参数选择
	f_cslx				INT				NOT NULL	DEFAULT(0),		--参数类型,用于判断客户输入数据是否合法，鼠标离开时进行判断(0,文本型;1,数字型;2,下拉框)
	f_px				INT				NOT NULL	DEFAULT(999),	--排序
	f_sylx				INT				NOT NULL	DEFAULT(0),		--适用类型(0通用 1只在常熟太仓江阴显示)
)'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_title'',''主标题'',''常熟市农药补贴与绿色防控'','''',0,1,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_xTitle'',''小标题'','''','''',0,2,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_cTitle'',''次标题'','''','''',0,3,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_djjd'',''单价精度'',''2'','''',1,4,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_sljd'',''数量精度'',''0'','''',1,5,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_jejd'',''金额精度'',''2'','''',1,6,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_dydjhs'',''打印单据行数'',''6'','''',1,7,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_xszdjkz'',''销售最低价控制'',''1'',''0,不控制;1,控制'',2,8,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_djdysfdytb'',''单据打印是否打印图标'',''1'',''0,否;1,是'',2,9,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_spxssfkz'',''商品销售是否控制'',''1'',''0,否;1,是'',2,10,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_psjgms'',''配送价格模式'',''1'',''0,可调整;1,销售价;2,成本价;3,最后进价'',2,11,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_xsddyxq'',''销售订单有效期'',''10'','''',1,12,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_sfyxsldjl'',''销售是否允许数量单价为零而金额不为零'',''1'',''0,否;1,是'',2,13,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_brcdmrck'',''拨入(出)单默认仓库'',''900001'','''',1,14,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_bzwsfyxbc'',''包装物是否允许保存'',''1'',''0,否;1,是'',2,15,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_bcdmrbrdw'',''拨出单默认拨入单位'',''901001'','''',1,16,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_bzwbrdbcwdsfjz'',''包装物拨入单拨出网点是否记账'',''0'',''0,否;1,是'',2,17,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_kjkhlbjb'',''快捷客户类别级别'',''4'','''',1,18,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_xsdsfxzbmkhdz'',''销售单是否限制部门客户对照'',''0'',''0,否;1,是'',2,19,0)'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_qysfzsk'',''启用身份证刷卡'',''0'',''0,否;1,是'',2,20,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_qyck'',''启用仓库'',''0'',''0,否;1,是'',2,21,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_dlxsxsd'',''登录显示销售单'',''0'',''0,否;1,是'',2,22,0);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_btbbypfw'',''补贴报表药品范围'',''2'','''',1,50,1);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_yxxgsjypfw'',''允许修改售价药品范围'',''6'','''',1,51,1);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_ysrksflrewm'',''验收入库是否录入二维码'',''0'',''0,否;1,是'',2,52,1);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_lrewmspfw'',''录入二维码商品范围'','''','''',0,53,1);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_pffbbcxbm'',''配方肥报表查询编码'',''7'','''',1,54,1);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_bzwnmsffklr'',''包装物、农膜是否分开录入'',''1'',''0,否;1,是'',2,55,1);'
Execute(@sql)

set @sql='insert into tb'+@shbm+'_Cssz(f_csbm,f_csmc,f_csz,f_csxz,f_cslx,f_px,f_sylx) VALUES(''f_qygmxe'',''启用购买限额'',''0'',''0,否;1,是'',2,56,1);'
Execute(@sql)



--仓库档案维护
set @sql='Create Table tb'+@shbm+'_ckdawh
(
	f_ckbm		VARCHAR(10)	    NOT NULL  DEFAULT(''),		--仓库编码，和上表显示序号关联，一级编码001，二级编码001001，三级编码001001001
	f_ckmc		VARCHAR(50)     NOT NULL  DEFAULT(''),		--仓库名称
	f_ckmj		INT				NOT NULL  DEFAULT(0),		--仓库面积(平方米)
	f_dz		VARCHAR(100)    NOT NULL  DEFAULT(''),		--地址
	f_dh		VARCHAR(50)     NOT NULL  DEFAULT(''),		--电话
	f_fzr		VARCHAR(20)	    NOT NULL  DEFAULT(''),		--负责人
	f_cksx		INT				NOT NULL  DEFAULT(0),		--仓库属性(0,正常仓库;1,退货仓库;2,原料仓库)
	f_jb		VARCHAR(10)     NOT NULL  DEFAULT(''),		--级别，1、2、3级
	f_mj		VARCHAR(10)     NOT NULL  DEFAULT(''),		--末级，0否、1是
)'
Execute(@sql)
--仓库档案表默认生成001仓库
set @sql='insert into tb'+@shbm+'_ckdawh(f_ckbm,f_ckmc,f_cksx,f_jb,f_mj) values(''001'',''公司1号仓库'',''0'',''1'',''1'');'
Execute(@sql)


--仓库数据表
set @sql='Create Table  tb'+@shbm+'_cksjb 
(
   f_Rq        	VARCHAR(8)      NOT NULL ,  					--日期
   f_Bmbm      	VARCHAR(12)     NOT NULL ,  					--部门编码
   f_Sptm      	VARCHAR(15)     NOT NULL ,  					--商品编码
   f_pch       	VARCHAR(30)     NOT NULL 	DEFAULT(''''),  	--批次号
   f_Sgpch     	VARCHAR(50)     NOT NULL	DEFAULT('''') , 	--手工批次号
   f_kcsl      	FLOAT           NOT NULL   	DEFAULT(0),     	--库存数量
   f_kcje      	FLOAT           NOT NULL   	DEFAULT(0),     	--库存金额
   f_kcsj      	FLOAT           NOT NULL    DEFAULT(0),     	--库存税金
   f_ckbm		VARCHAR(10)	    NOT NULL  	DEFAULT(''),		--仓库编码，和上表显示序号关联，一级编码001，二级编码001001，三级编码001001001
)'
Execute(@sql)


--客户类型表
set @sql='Create Table  tb'+@shbm+'_Khlxb 
(
   f_Khlx       VARCHAR(10)     NOT NULL 	DEFAULT(''),  		--客户类型，0农户 1大户 2合作社
   f_Khmc      	VARCHAR(50)     NOT NULL 	DEFAULT(''), 		--客户名称   
)'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Khlxb(f_Khlx,f_Khmc) values(''0'',''农户'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Khlxb(f_Khlx,f_Khmc) values(''1'',''大户'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Khlxb(f_Khlx,f_Khmc) values(''2'',''合作社'');'
Execute(@sql)


--毒性表
set @sql='Create Table  tb'+@shbm+'_Dxb 
(
   f_dxbm       VARCHAR(10)     NOT NULL 	DEFAULT(''),  		--毒性编码
   f_dxmc      	VARCHAR(50)     NOT NULL 	DEFAULT(''), 		--毒性名称 
)'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''1'',''低毒(原药中等毒)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''2'',''中等毒'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''3'',''低毒'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''4'',''低毒(原药高毒)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''5'',''微毒(原药高毒)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''6'',''微毒'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''7'',''剧毒'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''8'',''高毒'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''8'',''微毒(原药中等毒)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''8'',''中等毒(原药剧毒)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''8'',''微毒(原药低毒)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''8'',''高毒(小鼠)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''8'',''中等毒(原药高毒)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''8'',''低毒(原药剧毒)'');'
Execute(@sql)
set @sql='insert into tb'+@shbm+'_Dxb(f_dxbm,f_dxmc) values(''8'',''高毒(原药剧毒)'');'
Execute(@sql)


--插入信息管理相关表
--信息分类
set @sql='create table tb'+@shbm+'_type(
  f_id          int          identity(1,1),   --主键
  f_name        varchar(80),                  --名称
  f_sid         int,                          --上级id
  f_mj          int          default(1),      --是否末级
--  f_lb          varchar(50),                  --类别（1公文/0新闻/2供求/）
--  f_path        varchar(100),                 --具体的页面
--  f_max         varchar(50),                  --0不可发，1发一条,其他多发
--  f_syxs        int          default(0),	  --首页是否显示(0:否,1:是)
--  f_xg          int 		 default(0),  	  --审核后是否允许修改(0:不能修改，1:可以修改）
--  f_flow        int	         default(0),  --是否走流程(0否1是)
--  f_sub         int          default(0),      --是否可以增加子级
  constraint pk_tb'+@shbm+'_type primary key(f_id)
)'
Execute(@sql)

---信息主表
set @sql='CREATE TABLE tb'+@shbm+'_news (
	f_tid     int   identity(1, 1) primary key NOT NULL, --自增长的主键
	f_head    varchar(200) NOT NULL,                     --标题
    f_mast    varchar(200) default(''),                  --摘要
	f_body    image,                                     --正文
	f_id      int,                                       --类别(对应相应的分类)
	f_zybm    varchar(50),                               --发布人编码
	f_top     int      default(0),                       --是否置顶(0否1是)
	f_time    varchar(30),                               --发布时间
	constraint fk_'+@shbm+'_news_cid foreign key (f_id) references tb'+@shbm+'_type(f_id)
)'
Execute(@sql)

---信息附件表---
set @sql='CREATE TABLE tb'+@shbm+'_annex (
	f_tid     int,                          --信息ID（外键）
    f_xh      int  default(0),               --附件序号
	f_name    varchar(200),              --原上传的文件名称
	f_path    varchar(300),               --上传到服务器后的路径名称
	f_size    int,                        --文件大小
	constraint pk_tb'+@shbm+'_annex primary key(f_tid,f_xh),
	constraint fk_tb'+@shbm+'_annex_tid foreign key (f_tid) references tb'+@shbm+'_news(f_tid)
)'
Execute(@sql)


if @@error<>0
   rollback tran
else
   commit tran
   
   
SET NOCOUNT OFF
