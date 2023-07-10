package com.infol.nztest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends  HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object o) throws Exception {
        String path2 = request.getRequestURI();
        if(request.getRequestURI().equals("/login")||request.getRequestURI().equals("/regist")||request.getRequestURI().equals("/checkLogin")
                ||request.getRequestURI().equals("/SendMsg")||request.getRequestURI().equals("/registUser")||request.getRequestURI().equals("/error")
                ||request.getRequestURI().startsWith("/approve")||request.getRequestURI().startsWith("/registration")||request.getRequestURI().startsWith("/manage/gotoAdminLogin")||request.getRequestURI().startsWith("/manage/checkLogin")
                ||request.getRequestURI().startsWith("/JGClerk")||request.getRequestURI().startsWith("/forgetPwd")||request.getRequestURI().startsWith("/getShlx")||request.getRequestURI().startsWith("/edit")
                ||request.getRequestURI().startsWith("/swagger")||request.getRequestURI().startsWith("/doc.html")
                ||request.getRequestURI().startsWith("/service-worker.js")||request.getRequestURI().startsWith("/swagger-resources")
                ){
            return true;
        }else{
            Object obj=request.getSession().getAttribute("f_zymc");
            Object obj2 = request.getSession().getAttribute("glf_zymc");
            String type = request.getHeader("X-Requested-With");// XMLHttpRequest
            if(obj==null){
                String path = request.getContextPath();
                String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
                if (("XMLHttpRequest").equals(type)) {
                    // ajax请求
                    response.setHeader("SESSIONSTATUS", "logintimeout");
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);//403 禁止
                    return false;
                } else {
                    if(request.getRequestURI().startsWith("/manage/gotoAdminIndex")){
                        response.sendRedirect("/manage/gotoAdminLogin");
                    }else{
                        response.sendRedirect("/login");
                    }
                    return false;
                }
            }else{
                if(obj2 == null && request.getRequestURI().startsWith("/manage/gotoAdminIndex")){
                    response.sendRedirect("/manage/gotoAdminLogin");
                    return false;
                }
            }
            return true;
       }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
