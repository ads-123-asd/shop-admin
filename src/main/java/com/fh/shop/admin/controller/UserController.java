package com.fh.shop.admin.controller;

import com.fh.shop.admin.biz.user.UserService;
import com.fh.shop.admin.common.ReposeEnum;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.User;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;
    @RequestMapping("login")
    @ResponseBody
    public ServerResponse login(String userName, String password, HttpServletRequest request){
            if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)){
                return ServerResponse.error(ReposeEnum.USERNAME_PASSWORD_IS_NULL);
            }
        User user = userService.queryUserByName(userName, password);
        if (user.equals(userName)){
            return ServerResponse.error(ReposeEnum.USERNAME_IS_NOT_EXISTS);
        }
        if (user.equals(password)){
            return ServerResponse.error(ReposeEnum.PASSWORD_IS_ERROR);
        }
        request.getSession().setAttribute("user",user);
            return ServerResponse.success();
    }
}
