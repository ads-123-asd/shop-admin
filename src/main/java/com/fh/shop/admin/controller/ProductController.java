package com.fh.shop.admin.controller;

import com.fh.shop.admin.biz.product.IProductService;
import com.fh.shop.admin.common.RedisUtil;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.common.SystemFinal;
import com.fh.shop.admin.param.DataTableResult;
import com.fh.shop.admin.param.ProductParam;
import com.fh.shop.admin.po.Product;
import com.fh.shop.admin.util.AliyunOSSUtil;
import com.fh.shop.admin.util.FileUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

@Controller
@RequestMapping("product")
public class ProductController {

    @Resource(name="productService")
    private IProductService productService;

    @RequestMapping("index")
    public String index(){
        return "product/index";
    }

    @RequestMapping("findList")
    @ResponseBody
    public DataTableResult findList(ProductParam productParam){
        DataTableResult dataTableResult= productService.findList(productParam);
        return dataTableResult;
    }

    @RequestMapping("toAdd")
    public String toAdd(){
        return "product/add";
    }


    @RequestMapping("addProduct")
    @ResponseBody
    public ServerResponse addProduct(Product product){
        RedisUtil.delete("hotProductList");
        productService.addProduct(product);
        return ServerResponse.success();
    }

    @RequestMapping("updateProduct")
    @ResponseBody
    public ServerResponse updateProduct(Product product, HttpServletRequest request){
        RedisUtil.delete("hotProductList");
        Product product1 = productService.findBProductyId(product.getId());
        if (!product1.getImage().equals(product.getImage())){
            AliyunOSSUtil.deleteFile(product1.getImage());
        }
        productService.updateProduct(product);
        return ServerResponse.success();
    }

    @RequestMapping("deleteProduct")
    @ResponseBody
    public ServerResponse deleteProduct(Long id,HttpServletRequest request){
        RedisUtil.delete("hotProductList");
        Product byId = productService.findBProductyId(id);
        AliyunOSSUtil.deleteFile(byId.getImage());
        productService.deleteProduct(id);

        return ServerResponse.success();
    }
    @RequestMapping("toUpdate")
    public String toUpdate(Long id){

        return "product/update";
    }
    @RequestMapping("findProductById")
    @ResponseBody
    public ServerResponse findProductById(Long id){
        return productService.findById(id);
    }

    //修改热销
    @RequestMapping("updateIsHotStatus")
    @ResponseBody
    public ServerResponse updateIsHotStatus(Long id,int status){
        productService.updateIsHotStatus(id,status);
        return ServerResponse.success();
    }

    //修改上下架
    @RequestMapping("updatesStatus")
    @ResponseBody
    public ServerResponse updatesStatus(Long id,int status){
        productService.updatesStatus(id,status);
        return ServerResponse.success();
    }
}
