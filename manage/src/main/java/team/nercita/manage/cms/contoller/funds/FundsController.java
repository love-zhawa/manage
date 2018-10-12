/*
 * FundsController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月26日 上午11:13:30
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.funds;

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
import team.nercita.manage.cms.po.finance.FundsIncome;
import team.nercita.manage.cms.service.funds.FundsService;
import team.nercita.manage.cms.service.project.ProjectService;

/**
 * 经费到账
 * @author 侯建玮
 * @date 2017年11月26日 上午11:13:30
 */
@Controller
@RequestMapping("/funds")
public class FundsController{
	@Autowired
	FundsService fundsService;
	
	@Autowired 
	ProjectService projectService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="projectId") String projectId, @ModelAttribute(value="financialNumber") String financialNumber){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("projectId", projectId);
		paramMap.put("financialNumber", financialNumber);
		
		ModelAndView view = new ModelAndView("funds/income/list");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("roleid",user.getRole().getId());
		
		view.addAllObjects(fundsService.doJoinTransQueryFundsList(goPage, paramMap));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("funds/income/add");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/add")
	public String add(FundsIncome fundsIncome, RedirectAttributes attr,@ModelAttribute(value="project.id") String projectid){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		fundsIncome.setAddUser(user.getId());
		fundsService.doTransSaveFundsIncome(fundsIncome);
		
		attr.addFlashAttribute("msg", "添加成功!");
		return "redirect:/funds/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/income/edit");
		view.addObject("fundsIncome",fundsService.doJoinTransFindFundsIncomeById(id));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	} 
	
	@RequestMapping("/edit")
	public String edit(FundsIncome fundsIncome, RedirectAttributes attr,@ModelAttribute(value="project.id") String projectid){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		fundsIncome.setAddUser(user.getId());
		//fundsService.doTransUpdateFundsIncome1(fundsIncome);
		fundsService.doTransUpdateFundsIncome(fundsIncome);
		
		attr.addFlashAttribute("msg", "修改成功!");
		return "redirect:/funds/list";
	}
	//提交审核
	@RequestMapping("/sub/{id}")
	public String sub(@PathVariable String id, RedirectAttributes attr){
		fundsService.doTransFundsIncome(id, 0);
		attr.addFlashAttribute("msg", "提交成功！");
		return "redirect:/funds/list";
	}
	//跳转到审核页面
	@RequestMapping("/toaudit/{id}")
	public ModelAndView toaudit(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/income/audit");
		view.addObject(fundsService.doJoinTransFindFundsIncome(id));
		return view;
	}
	//审核
	@RequestMapping("/audit")
	public String audit(String id, int status, RedirectAttributes attr){
		fundsService.doTransFundsIncome(id, status);
		attr.addFlashAttribute("msg", "审核成功！");
		return "redirect:/funds/list";
	}
}
