/*
 * UseCarController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月6日 下午12:51:29
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.apply;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyUseCar;
import team.nercita.manage.cms.service.apply.UseCardService;

/**
 *
 * @author 侯建玮
 * @date 2017年8月6日 下午12:51:29
 */
@Controller
@RequestMapping("/apply/online/usecar")
public class UseCarController {
	@Autowired
	UseCardService useCardService; 
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="userName") String userName){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userName", userName);
		
		ModelAndView view = new ModelAndView("apply/online/usecar/list");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("roleid",user.getRole().getId());
		view.addAllObjects(useCardService.doJoinTransFindUseCarList(goPage, paramMap));
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("apply/online/usecar/add");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("username",user.getName());
		view.addObject("groupname",user.getUserGroup().getGroupName());
		return view;
	}
	
	@RequestMapping("/add")
	public String add(ApplyUseCar applyUseCar, String[] special, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		
		String specialInfo = "";
		if(special !=null && special.length > 0) {
			for (int i = 0; i < special.length; i++) {
				specialInfo += special[i];
			}
		}
		
		applyUseCar.setSpecialInfo(specialInfo);
		applyUseCar.setUser(user);
		useCardService.doTransSaveUseCar(applyUseCar);
		attr.addFlashAttribute("msg", "添加成功！");
		return "redirect:/apply/online/usecar/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("apply/online/usecar/edit");
		
		view.addObject("usecar", useCardService.doJoinTransFindApplyUseCar(id));
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("username",user.getName());
		view.addObject("groupname",user.getUserGroup().getGroupName());
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(ApplyUseCar applyUseCar, String[] special, RedirectAttributes attr){
		String specialInfo = "";
		for (int i = 0; i < special.length; i++) {
			specialInfo += special[i];
		}
		
		applyUseCar.setSpecialInfo(specialInfo);
		useCardService.doTransUpdateApplyUseCar(applyUseCar);
		attr.addFlashAttribute("msg", "修改成功！");
		return "redirect:/apply/online/usecar/list";
	}
	
	@RequestMapping("/toprint/{id}")
	public ModelAndView toprint(@PathVariable String id){
		ModelAndView view = new ModelAndView("apply/online/usecar/print");
		
		view.addObject("usecar", useCardService.doJoinTransFindApplyUseCar(id));
		return view;
	}
}
