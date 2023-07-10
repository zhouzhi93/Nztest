package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface CharacterService {

    String getJsmx(String jsbm, HttpServletRequest request);

    String addJsmx(String jsmc, String jslx, String jsqx, String sfkj, HttpServletRequest request);

    String removeJsmx(String jsbm, HttpServletRequest request);

    String updateJsmx(String jsbm, String jsmc, String jslx, String jsqx, String sfkj, HttpServletRequest request);

    String getQxmx(String qxbm,HttpServletRequest request);

    /**
     * 获取角色档案表
     * @param jsbm 角色编码
     * @param request
     * @return
     */
    String getJsdab(String jsbm, HttpServletRequest request);

    /**
     * 获取角色已有的权限
     * @param jsbm 角色编码
     * @param request
     * @return
     */
    String getJsqx(String jsbm, HttpServletRequest request);

    /**
     * 获取所有角色权限
     * @return
     */
    String queryAllJsqx(HttpServletRequest request);

    /**
     * 增加角色
     * @param jsbm
     * @param jsmc
     * @param request
     * @return
     */
    String addjs(String jsbm, String jsmc, HttpServletRequest request);

    /**
     * 查询最大角色编码+1
     * @param request
     * @return
     */
    String queryMaxJsbm(HttpServletRequest request);

    /**
     * 修改角色
     * @param jsbm
     * @param jsmc
     * @param request
     * @return
     */
    String updateJs(String jsbm, String jsmc, HttpServletRequest request);

    /**
     * 删除角色
     * @param jsbm
     * @param request
     * @return
     */
    String deleteJs(String jsbm, HttpServletRequest request);

    /**
     * 修改角色权限
     * @param jsbm
     * @param qxbmList
     * @param noqxbmList
     * @param request
     * @return
     */
    String updateJsqx(String jsbm, String qxbmList, String noqxbmList, HttpServletRequest request);

    /**
     * 修改角色职员
     * @param jsbm
     * @param zybmList
     * @param nozybmList
     * @param request
     * @return
     */
    String updateJszy(String jsbm, String zybmList, String nozybmList, HttpServletRequest request);

    /**
     * 获取职员档案
     * @param jsbm
     * @param request
     * @return
     */
    String getZyda(String jsbm, HttpServletRequest request);
}
