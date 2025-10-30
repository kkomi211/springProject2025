package com.example.springProject2025.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // Spring MVC Model
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.springProject2025.dao.ProductService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;   // ← jakarta로 통일
import jakarta.servlet.http.HttpServletResponse;  // ← jakarta로 통일

@Controller
public class ProductController {

    @Autowired
    ProductService productService;

    @RequestMapping("admin/product-add.do")
    public String refundReturn(Model model) throws Exception {
        return "admin/product-add"; // .jsp 빠진 형태
    }

    @RequestMapping("admin/product-info.do")
    public String productInfo(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        request.setAttribute("productNo", map.get("productNo"));
        request.setAttribute("rating", map.get("rating"));
        return "admin/product-info"; // .jsp 빠진 형태
    }
    
    @RequestMapping(value = "/product/user/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String productInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.getProductUserInfo(map);
        return new Gson().toJson(resultMap);
    }
    
    @RequestMapping(value = "/product/inquiry/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String inquiryList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.getInquiryList(map);
        return new Gson().toJson(resultMap);
    }
    

    @RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String productList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.getProductList(map);
        return new Gson().toJson(resultMap);
    }

    @RequestMapping(value = "/product/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String productView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.getProductInfo(map);
        return new Gson().toJson(resultMap);
    }

    @RequestMapping(value = "/product/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String productEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.EditProduct(map);
        return new Gson().toJson(resultMap);
    }

    @RequestMapping(value = "/product/delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String productDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.DeleteProduct(map);
        return new Gson().toJson(resultMap);
    }

    @RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String productInsert(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.InsertProduct(map);
        return new Gson().toJson(resultMap);
    }
    
    @RequestMapping(value = "/product/img/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String productImgList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.getProductImgList(map);
        return new Gson().toJson(resultMap);
    }
    
    @RequestMapping(value = "/product/user/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String userProductList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.getUserProductList(map);
        return new Gson().toJson(resultMap);
    }
    
    @RequestMapping(value = "/review/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String ReviewList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = productService.getReviewList(map);
        return new Gson().toJson(resultMap);
    }

    // ===== 파일 업로드(JSON 응답) =====
    @RequestMapping(value = "/product/fileUpload.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String result(
            @RequestParam("file1") MultipartFile multi,
            @RequestParam("productNo") int productNo,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {

        Map<String, Object> res = new HashMap<>();
        try {
            if (multi == null || multi.isEmpty() || multi.getOriginalFilename() == null) {
                res.put("ok", false);
                res.put("msg", "파일이 비어있습니다.");
                return new Gson().toJson(res);
            }

            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf(".")); // 점 포함
            long size = multi.getSize();
            String saveFileName = genSaveFileName(extName);

            // 실제 저장 경로(프로젝트 내 webapp/img)
            String baseDir = System.getProperty("user.dir") + File.separator + "src"
                    + File.separator + "main" + File.separator + "webapp" + File.separator + "img";

            File dir = new File(baseDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File file = new File(dir, saveFileName);
            multi.transferTo(file);

            HashMap<String, Object> map = new HashMap<>();
            map.put("fileName", saveFileName);
            map.put("path", "/img/" + saveFileName);
            map.put("productNo", productNo);
            map.put("orgName", originFilename);
            map.put("size", size);
            map.put("ext", extName);
            System.out.println(map);
            // DB insert
            productService.addProductImg(map);

            // JSON 응답
            res.put("ok", true);
            res.put("fileName", saveFileName);
            res.put("path", "/img/" + saveFileName);
            res.put("productNo", productNo);
            return new Gson().toJson(res);

        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("msg", e.getMessage());
            return new Gson().toJson(res);
        }
    }

    // 현재 시간을 기준으로 파일 이름 생성
    private String genSaveFileName(String extName) {
        StringBuilder fileName = new StringBuilder();
        Calendar calendar = Calendar.getInstance();
        fileName.append(calendar.get(Calendar.YEAR));
        fileName.append(String.format("%02d", calendar.get(Calendar.MONTH) + 1)); // ← +1
        fileName.append(String.format("%02d", calendar.get(Calendar.DATE)));
        fileName.append(String.format("%02d", calendar.get(Calendar.HOUR_OF_DAY)));
        fileName.append(String.format("%02d", calendar.get(Calendar.MINUTE)));
        fileName.append(String.format("%02d", calendar.get(Calendar.SECOND)));
        fileName.append(String.format("%03d", calendar.get(Calendar.MILLISECOND)));
        fileName.append(extName);
        return fileName.toString();
    }
}
