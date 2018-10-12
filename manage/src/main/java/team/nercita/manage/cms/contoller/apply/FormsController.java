/*
 * FormController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月5日 上午8:36:55
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.apply;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.CommonFormss;
import team.nercita.manage.cms.service.apply.FormService;
import team.nercita.manage.cms.util.Generator;

/**
 * 部门管理--文件上传
 */
@Controller
@RequestMapping("/apply/forms")
public class FormsController {
	
	@Autowired
	FormService formService; 
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="title") String title, @ModelAttribute(value="fileName") String fileName){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("title", title);
		paramMap.put("fileName", fileName);
		
		ModelAndView view = new ModelAndView("apply/forms/list");
		view.addAllObjects(formService.doJoinTransFindCommonFormsList(goPage, paramMap));
		return view;
	}
	
	@RequestMapping("/toadd")
	public String toadd(){
		return "apply/forms/add";
	}
	
	@RequestMapping("/add")
	public String add(CommonFormss commonFormss, @RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		if(file != null && file.getOriginalFilename() != null && file.getSize() > 0){
			String fileName = file.getOriginalFilename();
			String newFileName = Generator.getUUID() + fileName.substring(fileName.lastIndexOf("."));
			File uploadFile = new File(request.getSession().getServletContext().getRealPath("/upload"), newFileName);
			try {
				file.transferTo(uploadFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			commonFormss.setFileName(fileName);
			commonFormss.setUser(user);
			commonFormss.setAddTime(new Date());
			commonFormss.setFilePath(newFileName);
		}
		
		formService.doTransSaveCommonForms(commonFormss);
		attr.addFlashAttribute("msg", "添加成功！");
		return "redirect:/apply/forms/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("apply/forms/edit");
		
		view.addObject("commonFormss", formService.doJoinTransFindCommonForms(id));
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(CommonFormss commonFormss, @RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, RedirectAttributes attr){
		if(file != null && file.getOriginalFilename() != null && file.getSize() > 0){
			String fileName = file.getOriginalFilename();
			String newFileName = Generator.getUUID() + fileName.substring(fileName.lastIndexOf("."));
			File uploadFile = new File(request.getSession().getServletContext().getRealPath("/upload"), newFileName);
			try {
				file.transferTo(uploadFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			commonFormss.setFileName(fileName);
			
			commonFormss.setFilePath(newFileName);
		}
		formService.doTransUpdateCommonForms(commonFormss);
		attr.addFlashAttribute("msg", "修改成功！");
		return "redirect:/apply/forms/list";
	}
}
