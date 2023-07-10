package com.infol.nztest.service;

public interface MessageService {
    /**
     * @deprecated 检查名称是否已存在
     * @param f_name
     * @return
     * @throws Exception
     */
    boolean existsName(String f_shbm,String f_id, String f_name) throws Exception;
    /**
     * @deprecated  信息分类维护（新增与修改）
     * @param f_id
     * @param f_name
     * @param f_sid
     * @return
     * @throws Exception
     */
    String saveType(String f_shbm,String f_id, String f_name, String f_sid) throws Exception;
    /**
     * @deprecated 信息分类删除
     * @param f_id
     * @throws Exception
     */
    void delete(String f_shbm,String f_id) throws Exception;
    /**
     * @deprecated 查询信息分类
     * @param f_id
     * @param f_sid
     * @return
     * @throws Exception
     */
    String query(String f_shbm,String f_id, String f_sid) throws Exception;
    /**
     * @deprecated 信息查询
     * @param f_tid
     * @param f_id
     * @param f_title
     * @param f_zybm
     * @return
     * @throws Exception
     */
    String queryNews(String f_shbm,String f_tid, String f_id, String f_title, String f_zybm, String top,String f_ksrq,String f_jsrq) throws Exception;
    /**
     * @deprecated 查询信息附件
     * @param f_id
     * @return
     * @throws Exception
     */
    String queryAnnex(String f_shbm,String f_id) throws Exception;
    /**
     * @deprecated 删除信息
     * @param f_tid
     * @throws Exception
     */
    void deleteNews(String f_shbm,String f_tid) throws Exception;
    /**
     * @deprecated 信息发布｜修改
     * @param info
     * @param annex
     * @return
     * @throws Exception
     */
    String saveNews(String f_shbm,String info, String annex) throws Exception;
}
