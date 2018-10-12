/*
 * StartUpController.java
 * 创建者：侯建玮
 * 创建日期：2017年12月28日 下午3:31:28
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.contoller.project;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

/**
 * 项目实施
 * @author 侯建玮
 * @date： 2017年12月28日 下午3:31:28
 */
@Controller
@RequestMapping("/project/startup")
public class FileUploadController {
	@RequestMapping(value="/upload",method=RequestMethod.POST)
    public void load(HttpServletResponse response ,MultipartFile fileLocalFile) throws Exception {

        //获取文件的名称
        String fileName = fileLocalFile.getOriginalFilename();

        //获取文件夹路径
        String path = this.getSession().getServletContext().getRealPath("resources/upload");
        //当文件夹不存在就创建
        File outFile = new File(path+File.separator +fileName);
        if(!outFile.getParentFile().exists()) {
            outFile.getParentFile().mkdirs();
        }
        //输出到服务器上
        FileUtils.copyInputStreamToFile(fileLocalFile.getInputStream(), outFile);

        //设定编码 
        response.setCharacterEncoding("UTF-8"); 
        //表示是json类型的数据 
        response.setContentType("application/json");

        //写json数据到客户端
        Map<String,Object> result = new HashMap<String, Object>();
        result.put("fileName", fileName);
        result.put("filePath", path+File.separator +fileName);
        result.put("error", false);
        ObjectMapper mapper = new ObjectMapper(); 
        //转换器 //获取到转化后的JSON 数据 
        String json = mapper.writeValueAsString(result);
        response.getWriter().write(json);
    }

    /**
     * 在SpringMvc中获取到Session
     * @return
     */ 
    public HttpSession getSession(){ 
         //获取到ServletRequestAttributes 里面有 
         ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes(); 
         //获取到Request对象
         HttpServletRequest request = attrs.getRequest(); 
         //获取到Session对象 
         HttpSession session = request.getSession(); 
         return session; 
    }

}
