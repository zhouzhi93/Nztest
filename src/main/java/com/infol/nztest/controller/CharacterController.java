package com.infol.nztest.controller;

import com.infol.nztest.service.CharacterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/character")
public class CharacterController {
    @Autowired
    private CharacterService characterService ;

    @RequestMapping("/gotoChara")
    public String gotoCommodity(Model model){
        return "initialValue/character";
    }

    @RequestMapping("/getChara")
    @ResponseBody
    public String getChara(String jsbm, HttpServletRequest request){
        return characterService.getJsmx(jsbm,request);
    }

    @RequestMapping("/addJsmx")
    @ResponseBody
    public String addJsmx(String jsmc,String jslx,String jsqx,String sfkj, HttpServletRequest request){
        return characterService.addJsmx(jsmc,jslx,jsqx,sfkj,request);
    }

    @RequestMapping("/removeJsmx")
    @ResponseBody
    public String removeJsmx(String jsbm, HttpServletRequest request){
        return characterService.removeJsmx(jsbm,request);
    }

    @RequestMapping("/updateJsmx")
    @ResponseBody
    public String updateJsmx(String jsbm,String jsmc,String jslx,String jsqx,String sfkj, HttpServletRequest request){
        return characterService.updateJsmx(jsbm,jsmc,jslx,jsqx,sfkj,request);
    }

    @RequestMapping("/getQxmx")
    @ResponseBody
    public String getQxmx(String qxbm,HttpServletRequest request){
        return characterService.getQxmx(qxbm,request);
    }

    /**
     * 跳转角色维护jsp
     * @param model
     * @return
     */
    @RequestMapping("/gotoJswh")
    public String gotoJswhTree(Model model){
        return "initialValue/jswh";
    }

    /**
     * 获取角色档案表
     * @param jsbm 角色编码
     * @param request
     * @return
     */
    @RequestMapping("/getJsdab")
    @ResponseBody
    public String getJsdab(String jsbm, HttpServletRequest request){
        return characterService.getJsdab(jsbm,request);
    }

    /**
     * 获取角色已有的权限
     * @param jsbm 角色编码
     * @param request
     * @return
     */
    @RequestMapping("/getJsqx")
    @ResponseBody
    public String getJsqx(String jsbm, HttpServletRequest request){
        return characterService.getJsqx(jsbm,request);
    }

    /**
     * 获取所有角色权限
     * @param request
     * @return
     */
    @RequestMapping("/queryAllJsqx")
    @ResponseBody
    public String queryAllJsqx(HttpServletRequest request){
        return characterService.queryAllJsqx(request);
    }

    /**
     * 修改角色权限
     * @param jsbm
     * @param qxbmList
     * @param noqxbmList
     * @param request
     * @return
     */
    @RequestMapping("/updateJsqx")
    @ResponseBody
    public String updateJsqx(String jsbm,String qxbmList, String noqxbmList,HttpServletRequest request){
        return characterService.updateJsqx(jsbm,qxbmList,noqxbmList,request);
    }

    /**
     * 修改角色职员
     * @param jsbm
     * @param zybmList
     * @param nozybmList
     * @param request
     * @return
     */
    @RequestMapping("/updateJszy")
    @ResponseBody
    public String updateJszy(String jsbm,String zybmList, String nozybmList,HttpServletRequest request){
        return characterService.updateJszy(jsbm,zybmList,nozybmList,request);
    }


    /**
     * 增加角色
     * @param jsbm
     * @param jsmc
     * @param request
     * @return
     */
    @RequestMapping("/addjs")
    @ResponseBody
    public String addjs(String jsbm,String jsmc, HttpServletRequest request){
        return characterService.addjs(jsbm,jsmc,request);
    }

    /**
     * 查询最大角色编码+1
     * @param request
     * @return
     */
    @RequestMapping("/queryMaxJsbm")
    @ResponseBody
    public String queryMaxJsbm(HttpServletRequest request){
        return characterService.queryMaxJsbm(request);
    }

    /**
     * 修改角色
     * @param jsbm
     * @param jsmc
     * @param request
     * @return
     */
    @RequestMapping("/updateJs")
    @ResponseBody
    public String updateJs(String jsbm, String jsmc, HttpServletRequest request){
        return characterService.updateJs(jsbm,jsmc,request);
    }

    /**
     * 删除角色
     * @param jsbm
     * @param request
     * @return
     */
    @RequestMapping("/deleteJs")
    @ResponseBody
    public String deleteJs(String jsbm, HttpServletRequest request){
        return characterService.deleteJs(jsbm,request);
    }

    /**
     * 获取职员档案
     * @param jsbm
     * @param request
     * @return
     */
    @RequestMapping("/getZyda")
    @ResponseBody
    public String getZyda(String jsbm, HttpServletRequest request){
        return characterService.getZyda(jsbm,request);
    }
}
