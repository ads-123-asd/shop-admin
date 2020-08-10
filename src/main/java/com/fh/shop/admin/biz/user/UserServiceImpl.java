package com.fh.shop.admin.biz.user;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.shop.admin.mapper.user.UserMapper;
import com.fh.shop.admin.po.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    @Override
    public User queryUserByName(String userName, String password) {
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("userName",userName);
        queryWrapper.eq("password",password);
        User user = userMapper.selectOne(queryWrapper);

        return user;
    }
}
