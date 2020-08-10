package com.fh.shop.admin.biz.type;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.Type;


public interface ITypeService {

    ServerResponse queryTypeList();

    ServerResponse addType(Type type);

    ServerResponse deleteNodes(Long[] ids);

    ServerResponse findType(Long id);

    ServerResponse updateType(Type type);

    ServerResponse findTypeSelect(Long id);
}
