package com.fh.shop.admin.po;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


@Data
public class Member implements Serializable {
    private Long id;

    private String memberName;//  【会员名】

    private String password;//    【密码】

    private String realName;//    【真实姓名】

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date birthday;//    【出生日期】

    private String mail;//	    【邮箱】

    private String phone;//       【电话】

    private Long shengId;

    private Long shiId;

    private Long xianId;

    private String areaName;


}
