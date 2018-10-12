/*
 * AssetsController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年7月26日 下午9:00:05
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.assets;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.assets.wlw;
import team.nercita.manage.cms.service.assets.WlwService;

/**
 * 物联网卡控制器
 */
@Controller
@RequestMapping("/assets/wlw")
public class WlwController {
	
	@Autowired
	WlwService wlwService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="sim") String sim, @ModelAttribute(value="cgperson") String cgperson ,@ModelAttribute(value="dd") String dd){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("sim", sim);
		paramMap.put("cgperson", cgperson);
		paramMap.put("dd", dd);
		
		ModelAndView view = new ModelAndView("assets/wlw/list");
		view.addAllObjects(wlwService.doJoinTranswlwList(goPage, paramMap));
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("assets/wlw/add");
		
		return view;
	}
	
	@RequestMapping("/add")
	public String add(wlw wlw, RedirectAttributes attr){
		wlwService.doTransSavewlw(wlw);
		attr.addFlashAttribute("msg", "添加成功!");
		return "redirect:/assets/wlw/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("assets/wlw/edit");
		view.addObject("wlw", wlwService.doJoinTransFindwlwById(id));
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(wlw wlw, RedirectAttributes attr){
		wlwService.doTransUpdatewlw(wlw);
		attr.addFlashAttribute("msg", "修改成功!");
		return "redirect:/assets/wlw/list";
	}
	
	@RequestMapping("/detail/{id}")
	public ModelAndView detail(@PathVariable String id){
		ModelAndView view = new ModelAndView("assets/wlw/detail");
		view.addObject("wlw", wlwService.doJoinTransFindwlwById(id));
		
		return view;
	}
	
}
