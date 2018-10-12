/*
 * StartUpController.java
 * 创建者：侯建玮
 * 创建日期：2017年12月28日 下午3:31:28
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.contoller.project;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.project.ProjectXmsh;
import team.nercita.manage.cms.service.project.ProjectService;
import team.nercita.manage.cms.service.project.ProjectXmshService;

/**
 * 项目售后
 */
@Controller
@RequestMapping("/project/xmsh")
public class ProjectXmshController {
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	ProjectXmshService projectXmshService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="projectid") String projectid, @ModelAttribute(value="number") String number ){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("projectid", projectid);
		paramMap.put("number", number);
		
		ModelAndView view = new ModelAndView("project/xmsh/list");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		view.addAllObjects(projectXmshService.doJoinTransProjectXmshList(goPage, paramMap));
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("project/xmsh/add");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		
		return view;
	}
	
	@RequestMapping("/add")
	public String add(ProjectXmsh xmsh, RedirectAttributes attr){
		projectXmshService.doTransSaveProjectXmsh(xmsh);
		attr.addFlashAttribute("msg", "添加成功!");
		return "redirect:/project/xmsh/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("project/xmsh/edit");
		view.addObject("xmsh", projectXmshService.doJoinTransFindProjectXmshById(id));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(ProjectXmsh xmsh, RedirectAttributes attr){
		projectXmshService.doTransUpdateProjectXmsh(xmsh);
		attr.addFlashAttribute("msg", "修改成功!");
		return "redirect:/project/xmsh/list";
	}
	
	@RequestMapping("/detail/{id}")
	public ModelAndView detail(@PathVariable String id){
		ModelAndView view = new ModelAndView("project/xmsh/detail");
		view.addObject("xmsh", projectXmshService.doJoinTransFindProjectXmshById(id));
		
		return view;
	}
	
}
