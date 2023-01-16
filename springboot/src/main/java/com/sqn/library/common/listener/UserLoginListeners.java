package com.sqn.library.common.listener;

import com.sqn.library.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Component
public class UserLoginListeners implements HttpSessionListener, ServletContextListener {

    private ServletContext application = null;

    @Autowired
    private IUserService iUserService;

    @Override
    public void contextDestroyed(ServletContextEvent s) {
        System.out.println("context Destroyed");
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("context init");
        application = sce.getServletContext();
        Set<String> onlineUserSet = new HashSet<>();
        application.setAttribute("onlineUserSet", onlineUserSet);
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {

        System.out.println("session create");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        Set<String> onlineUserSet = (Set<String>)application.getAttribute("onlineUserSet");
        Integer userId = (Integer) session.getAttribute("userId");
        onlineUserSet.remove(userId);
        application.setAttribute("onlineUserSet",onlineUserSet);

        //设置离线状态
        final Boolean status = iUserService.setStatusOffline(userId);
        if(Boolean.TRUE.equals(status)){
            System.out.println("离线成功");
        }
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println(formatter.format(date));
        onlineUserSet = (Set<String>)application.getAttribute("onlineUserSet");
        System.out.println("当前在线用户:"+onlineUserSet.toString());
        System.out.println(userId + "-->超时退出");
    }

}