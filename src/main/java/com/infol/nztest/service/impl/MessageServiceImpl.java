package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.MessageService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {
    private SqlServerOperator sqlOperator = null;

    public MessageServiceImpl(){
        openConnection();
    }
    void openConnection() {
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //判断是否为空
    private boolean isEmpty(String str) {
        return str==null || "".equals(str.trim());
    }

    /**
     * @deprecated 检查名称是否已存在
     * @param f_name
     * @return
     * @throws Exception
     */
    @Override
    public boolean existsName(String f_shbm,String f_id, String f_name) throws  Exception{
        String sql = null;
        String[] args = null;
        if(this.isEmpty(f_id)) {
            sql = "select f_id from tb"+f_shbm+"_type where f_name=?";
            args = new String[]{f_name};
        } else {
            sql = "select f_id from tb"+f_shbm+"_type where f_id!=? and f_name=?";
            args = new String[]{f_id,f_name};
        }
        String id = sqlOperator.queryOneRecorderData(sql,args);
        return !this.isEmpty(id);
    }
    /**
     * @deprecated  信息分类维护（新增与修改）
     * @param f_id
     * @param f_name
     * @param f_sid
     * @return
     * @throws Exception
     */
    @Override
    public String saveType(String f_shbm,String f_id, String f_name, String f_sid) throws Exception{
        StringBuilder sql = new StringBuilder();
        String[] args = null;
        boolean add = this.isEmpty(f_id);
        JSONArray jarr = null;
        String json = null;
        if(!add) {
            //检查是否存在
            json = sqlOperator.RunSQL_JSON("select * from tb"+f_shbm+"_type where f_id=?",new String[]{f_id});
            jarr = new JSONArray(json);
            if(jarr.length()==0) throw new Exception("没有指定数据");
            if(this.existsName(f_shbm,f_id,f_name))throw new Exception("名称不能重复");
            String sid = jarr.getJSONObject(0).getString("F_SID");
            if(this.isEmpty(f_sid))f_sid = sid;
            sql.append("update tb"+f_shbm+"_type set f_name=?,f_sid=? where f_id=?");
            args = new String[]{f_name,f_sid,f_id};
        } else {
            if(this.existsName(f_shbm,null,f_name)) throw new Exception("名称不能重复!");
            if(this.isEmpty(f_sid))f_sid="0";
            sql.append("insert into tb"+f_shbm+"_type(f_name,f_sid,f_mj)values(?,?,1)");
            args = new String[]{f_name,f_sid};
        }

        sqlOperator.ExecSQL(sql.toString(),args);
        if(add) {
            if(!"0".equals(f_sid)){
                sqlOperator.ExecSQL("update tb"+f_shbm+"_type set f_mj=0 where f_id=?",new String[]{f_sid});
            }
            f_id = sqlOperator.queryOneRecorderData("select f_id from tb"+f_shbm+"_type where f_name=?",new String[]{f_name});

        }
        //sqlOperator.closeConnection();
        return f_id;
    }

    /**
     * @deprecated 信息分类删除
     * @param f_id
     * @throws Exception
     */
    @Override
    public void delete(String f_shbm,String f_id) throws Exception {
        String[] args = new String[]{f_id};
        String sid = sqlOperator.queryOneRecorderData("select f_sid from tb"+f_shbm+"_type where f_id=?",args);
        if(sid==null||"".equals(sid))throw new Exception("找不到数据");
        List<String> sqls = new ArrayList();
        if(!"0".equals(sid)) {
            String len = sqlOperator.queryOneRecorderData("select count(*) from tb"+f_shbm+"_type where f_id!=? and f_sid=?",new String[]{f_id,sid});
            if(!this.isEmpty(len) && "0".equals(len)) {
                //sqlOperator.ExecSQL("update tb"+f_shbm+"_type set f_mj=1 where f_id=?",new String[]{sid});
                sqls.add("update tb"+f_shbm+"_type set f_mj=1 where f_id="+sid);
            }
        }
        //sqlOperator.ExecSQL("delete from tb"+f_shbm+"_type where f_id=?",args);
        sqls.add("delete from tb"+f_shbm+"_type where f_id="+f_id);
        sqlOperator.execSqls(sqls);
        //sqlOperator.closeConnection();
    }

    /**
     * @deprecated 查询信息分类
     * @param f_id
     * @param f_sid
     * @return
     * @throws Exception
     */
    @Override
    public String query(String f_shbm,String f_id, String f_sid) throws Exception {
        StringBuilder sql = new StringBuilder();
        String[] args = null;
        sql.append("select f_id,f_name,f_sid,f_mj from tb"+f_shbm+"_type z ");
        if(!this.isEmpty(f_id)){
            sql.append(" where z.f_id=?");
            args = new String[]{f_id};
        }
        else if(!this.isEmpty(f_sid)){
            sql.append(" where z.f_sid=? order by f_sid");
            args = new String[]{f_sid};
        } else args = new String[]{};

        return sqlOperator.RunSQL_JSON(sql.toString(),args);
    }

    /**
     * @deprecated 查询自己的所有末级
     * @param f_id
     * @param chk
     * @return
     * @throws Exception
     */
    private String findMj(String f_shbm,String f_id,boolean chk) throws Exception {
        if(chk) {
            String mj = sqlOperator.queryOneRecorderData("select f_mj from tb"+f_shbm+"_type where f_id=?", new String[]{f_id});
            if (mj != null && "1".equals(mj)) return f_id;
        }
        List<String> lst = sqlOperator.queryOneColumnDataByArgs("select f_id from tb"+f_shbm+"_type where f_mj=1 and f_sid=?",new String[]{f_id});
        int s = lst.size();
        int i = 0;
        StringBuilder sql = new StringBuilder();
        for(i=0; i<s; i++) {
            sql.append(",").append(lst.get(i));
        }
        lst = sqlOperator.queryOneColumnDataByArgs("select f_id from tb"+f_shbm+"_type where f_mj=0 and f_sid=?",new String[]{f_id});
        s = lst.size();
        for(i=0; i<s; i++) {
            sql.append(",").append(this.findMj(f_shbm,(String)lst.get(i),false));
        }
        String str = sql.toString().replaceAll(",,",",");
        if(str.startsWith(","))str = str.substring(1);
        return str;
    }

    /**
     * @deprecated 字符集合转数组
     * @param lst
     * @return
     */
    private String[] lst2Array(List<String> lst) {
        int s = lst==null?0:lst.size();
        if(s==0)return null;
        String[] args = new String[s];
        for(int i=0; i<s; i++) {
            args[i] = (String)lst.get(i);
        }
        return args;
    }
    /**
     * @deprecated 信息查询
     * @param f_tid
     * @param f_id
     * @param f_title
     * @param f_zybm
     * @return
     * @throws Exception
     */
    @Override
    public String queryNews(String f_shbm,String f_tid, String f_id, String f_title, String f_zybm, String top,String f_ksrq,String f_jsrq) throws Exception {
        StringBuilder sql = new StringBuilder();
        List<String> lst = new ArrayList<String>();
        sql.append("select ");
        if(!this.isEmpty(top))sql.append(" top ").append(top);
        boolean one = !this.isEmpty(f_tid);
        if(one)sql.append("z.f_body,");
        sql.append("z.f_tid,z.f_head,z.f_mast,z.f_id,z.f_zybm,z.f_top,z.f_time,zy.f_zymc,isnull((select f_name from tb"+f_shbm+"_type where f_id=z.f_id),'') f_name from tb"+f_shbm+"_news z inner join tbptzyda zy on zy.f_zybm=z.f_zybm where z.f_tid=z.f_tid ");
        if(!this.isEmpty(f_zybm)){
            sql.append(" and z.f_zybm=?");
            lst.add(f_zybm);
        }
        if(one) {
            sql.append(" and z.f_tid=?");
            lst.add(f_tid);
        }
        if(!this.isEmpty(f_id)) {
            sql.append(" and z.f_id in(?)");
            lst.add(this.findMj(f_shbm,f_id,true));
        }
        if(!this.isEmpty(f_title)) {
            sql.append(" and (f_head like '%").append(f_title).append("%' or f_mast like '%").append(f_title).append("%')");
            //lst.add(f_title);   %?%不认
            //lst.add(f_title);
        }
        if(!this.isEmpty(f_ksrq)) {
            sql.append(" and z.f_time>?");
            lst.add(f_ksrq.replaceAll("-",""));
        }
        if(!this.isEmpty(f_jsrq)) {
            sql.append(" and replace(left(z.f_time,10),'-','')<=?");
            lst.add(f_jsrq.replaceAll("-",""));
        }
        sql.append(" order by z.f_top desc,f_tid desc");
        return sqlOperator.RunSQL_JSON(sql.toString(),this.lst2Array(lst),one?"F_BODY,":null);
    }

    /**
     * @deprecated 查询信息附件
     * @param f_id
     * @return
     * @throws Exception
     */
    @Override
    public String queryAnnex(String f_shbm,String f_id) throws Exception {
        return sqlOperator.RunSQL_JSON("select z.* from tb"+f_shbm+"_annex z where f_tid=?",new String[]{f_id});
    }

    /**
     * @deprecated 删除信息
     * @param f_tid
     * @throws Exception
     */
    @Override
    public void deleteNews(String f_shbm,String f_tid) throws Exception {
        if(this.isEmpty(f_tid))throw new Exception("参数不合法");
        List sqls = new ArrayList();
        sqls.add("delete from tb"+f_shbm+"_annex where f_tid="+f_tid);
        sqls.add("delete from tb"+f_shbm+"_news where f_tid="+f_tid);
        sqlOperator.execSqls(sqls);
        //sqlOperator.closeConnection();
    }
    //查询出数据
    private String[] paramFromJson(JSONObject json,String[] names,boolean xh) throws Exception{
        int s = names.length;
        String[] vals = new String[s+(xh?1:0)];
        System.out.println(json.toString());
        for (int i=0; i<s; i++) {
            try {
                if (json.has(names[i])) {//"f_id":"18","f_head":"","f_mast":"","f_top":"0","f_body"
                    vals[i] = json.getString(names[i]);
                } else vals[i] = "";
            }catch (Exception e){}
        }
        return vals;
    }

    /**
     * @deprecated 信息发布｜修改
     * @param info
     * @param annex
     * @return
     * @throws Exception
     */
    @Override
    public String saveNews(String f_shbm,String info, String annex) throws Exception {
        JSONObject json = new JSONObject(info);
        JSONArray jarr = null;
        if(!this.isEmpty(annex) && annex.trim().startsWith("[")&& annex.trim().endsWith("]")){
            jarr = new JSONArray(annex);
        }
        String f_tid = null;
        if(json.has("f_tid")) {
            f_tid = json.getString("f_tid");
        }
        boolean add = this.isEmpty(f_tid);
        StringBuilder sql = new StringBuilder();
        String[] args = null;

        if(add) {
            sql.append("insert into tb"+f_shbm+"_news(f_head,f_mast,f_body,f_id,f_zybm,f_top,f_time)values(?,?,?,?,?,?,convert(varchar(20),getdate(),121))");
            args = "f_head,f_mast,f_body,f_id,f_zybm,f_top".split(",");

        } else {
            sql.append("update tb"+f_shbm+"_news set f_head=?,f_mast=?,f_body=?,f_id=?,f_zybm=?,f_top=? where f_tid=?");
            args = "f_head,f_mast,f_body,f_id,f_zybm,f_top,f_tid".split(",");
        }
        java.util.Map<String,String> cols = new HashMap<String,String>();
        cols.put("2","");//特殊字段
        sqlOperator.ExecSQL(sql.toString(),this.paramFromJson(json,args,false),cols);
        sql.setLength(0);
        if(add) {
            String[] params = new String[]{args[0],args[1],args[3],args[4]};
            sql.append("select f_tid from tb"+f_shbm+"_news z where f_head=? and f_title=? and f_zybm=? and f_top=?  and left(f_time,10)=convert(varchar(10),getdate(),121) and not exists(select * from tb"+f_shbm+"_annex where f_tid=z.f_tid) order by f_time desc");
            f_tid = sqlOperator.queryOneRecorderData(sql.toString(),params);
        } else {
            sqlOperator.ExecSQL("delete from tb"+f_shbm+"_annex where f_tid=?",new String[]{f_tid});
        }
        List<String[]> sqls = new ArrayList<String[]>();
        int s = jarr.length();
        String[] arr = null;
        sql.append("insert into tb"+f_shbm+"_annex(f_tid,f_xh,f_name,f_path,f_size)values(?,?,?,?,?)");
        for(int i=0; i<s; i++) {
            json = jarr.getJSONObject(i);
            arr = new String[5];//this.paramFromJson(json,args,false);
            arr[0] = f_tid;
            arr[1] = String.valueOf(i+1);
            arr[2] = json.getString("f_name");
            arr[3] = json.getString("f_path");
            arr[4] = json.getString("f_size");
            sqls.add(arr);
        }
        sqlOperator.ExecSQL(sql.toString(),sqls);
        return f_tid;
    }


    /*---信息主表
CREATE TABLE tb000001_news (
	f_tid     int   identity(1, 1) primary key NOT NULL, --自增长的主键
	f_head    varchar(200) NOT NULL,                     --标题
    f_mast    varchar(200) default(''),                  --摘要
	f_body    image,                                     --正文
	f_id      int,                                       --类别(对应相应的分类)
	f_zybm    varchar(50),                               --发布人编码
	f_top     int      default(0),                       --是否置顶(0否1是)
	f_time    varchar(30),                               --发布时间
	constraint fk_000001_news_cid foreign key (f_id) references tb000001_type(f_id)
)
---信息附件表---
CREATE TABLE tb000001_annex (
	f_tid     int,                          --信息ID（外键）
    f_xh      int  default(0),               --附件序号
	f_name    varchar(200),              --原上传的文件名称
	f_path    varchar(300),               --上传到服务器后的路径名称
	f_size    int,                        --文件大小
	constraint pk_tb000001_annex primary key(f_tid,f_xh),
	constraint fk_tb000001_annex_tid foreign key (f_tid) references tb000001_news(f_tid)
)
--信息分类
create table tb000001_type(
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
  constraint pk_tb000001_type primary key(f_id)
)*/
}
