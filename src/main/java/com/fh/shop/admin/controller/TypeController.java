package com.fh.shop.admin.controller;

import com.fh.shop.admin.biz.type.ITypeService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.Type;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/type")
public class TypeController {
    @Resource(name = "typeService")
    private ITypeService  typeService;
    //跳转展示分类页面
    @RequestMapping("/toTypeList")
    public  String  toTypeList(){
        return "type/typeList";
    }
    //跳转操作分类页面
    @RequestMapping("/toType")
    public  String  toType(){
        return "type/type";
    }
    //查询分类所有数据
    @RequestMapping("/queryTypeList")
    @ResponseBody
    public ServerResponse  queryTypeList(){
        return typeService.queryTypeList();
    }
    //增加类型
    @RequestMapping("/addType")
    @ResponseBody
    public ServerResponse  addType(Type type){
        return typeService.addType(type);
    }
    //删除类型
    @RequestMapping("/deleteNodes")
    @ResponseBody
    public ServerResponse deleteNodes(@RequestParam("ids[]") Long[] ids){
        return typeService.deleteNodes(ids);
    }
    //回显数据
    @RequestMapping("/findType")
    @ResponseBody
    public ServerResponse findType(Long id){
        return typeService.findType(id);
    }
    //修改类型
    @RequestMapping("/update")
    @ResponseBody
    public ServerResponse updateType(Type type){
        return typeService.updateType(type);
    }
    //查询顶级目录
    @RequestMapping("/findTypeSelect")
    @ResponseBody
    public ServerResponse findTypeSelect(Long id){
        return typeService.findTypeSelect(id);
    }
}
