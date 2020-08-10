package com.fh.shop.admin.biz.type;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.type.ITypeMapper;
import com.fh.shop.admin.po.Type;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service("typeService")
public class ITypeServiceImpl implements ITypeService {

    @Autowired
    private ITypeMapper  typeMapper;
    //查询分类
    @Override
    public ServerResponse queryTypeList() {
        List<Type>  typeList=typeMapper.queryTypeList();
        return ServerResponse.success(typeList);
    }
    //增加分类
    @Override
    public ServerResponse addType(Type type) {
        typeMapper.addType(type);
        return ServerResponse.success();
    }
    //删除分类
    @Override
    public ServerResponse deleteNodes(Long[] ids) {
        List<Long> idList = Arrays.asList(ids);
        typeMapper.deleteNodes(idList);
        return ServerResponse.success();
    }
    //回显分类
    @Override
    public ServerResponse findType(Long id) {
        Type type=typeMapper.findType(id);
        return ServerResponse.success(type);
    }
    //修改类型
    @Override
    public ServerResponse updateType(Type type) {
        typeMapper.updateType(type);
        return ServerResponse.success();
    }
    //查询顶级目录
    @Override
    public ServerResponse findTypeSelect(Long id) {
        List<Type>  typeList=typeMapper.findTypeSelect(id);
        return ServerResponse.success(typeList);
    }
}
