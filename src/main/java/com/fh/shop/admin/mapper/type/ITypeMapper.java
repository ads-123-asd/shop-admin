package com.fh.shop.admin.mapper.type;

import com.fh.shop.admin.po.Type;


import java.util.List;

public interface ITypeMapper {

    List<Type> queryTypeList();

    void addType(Type type);

    void deleteNodes(List<Long> idList);

    Type findType(Long id);

    void updateType(Type type);

    List<Type> findTypeSelect(Long id);
}
