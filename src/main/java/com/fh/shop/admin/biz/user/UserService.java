package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.po.User;

public interface UserService {

    public User queryUserByName(String userName,String password);


}
