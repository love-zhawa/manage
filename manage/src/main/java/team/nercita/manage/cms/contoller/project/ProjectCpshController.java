
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

import team.nercita.manage.cms.po.project.ProjectCpsh;
import team.nercita.manage.cms.service.project.ProjectService;
import team.nercita.manage.cms.service.project.ProjectCpshService;

/**
 * 产品售后
 */
@Controller
@RequestMapping("/project/cpsh")
public class ProjectCpshController {
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	ProjectCpshService projectCpshService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="sbname") String sbname, @ModelAttribute(value="sbtype") String sbtype, @ModelAttribute(value="sbhome") String sbhome ){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("sbname", sbname);
		paramMap.put("sbtype", sbtype);
		paramMap.put("sbhome", sbhome);
		
		ModelAndView view = new ModelAndView("project/cpsh/list");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		view.addAllObjects(projectCpshService.doJoinTransProjectCpshList(goPage, paramMap));
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("project/cpsh/add");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		
		return view;
	}
	
	@RequestMapping("/add")
	public String add(ProjectCpsh cpsh, RedirectAttributes attr){
		projectCpshService.doTransSaveProjectCpsh(cpsh);
		attr.addFlashAttribute("msg", "添加成功!");
		return "redirect:/project/cpsh/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("project/cpsh/edit");
		view.addObject("cpsh", projectCpshService.doJoinTransFindProjectCpshById(id));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(ProjectCpsh cpsh, RedirectAttributes attr){
		projectCpshService.doTransUpdateProjectCpsh(cpsh);
		attr.addFlashAttribute("msg", "修改成功!");
		return "redirect:/project/cpsh/list";
	}
	
	@RequestMapping("/detail/{id}")
	public ModelAndView detail(@PathVariable String id){
		ModelAndView view = new ModelAndView("project/cpsh/detail");
		view.addObject("cpsh", projectCpshService.doJoinTransFindProjectCpshById(id));
		
		return view;
	}
	
}
