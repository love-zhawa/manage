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
import team.nercita.manage.cms.service.apply.ReimbursementService;
import team.nercita.manage.cms.service.funds.FundsService;
import team.nercita.manage.cms.service.project.ProjectService;

/**
 * 查询管理
 */
@Controller
@RequestMapping("/funds/cx")
public class CxController{
	@Autowired
	ReimbursementService reimbursementService; 
	
	@Autowired 
	ProjectService projectService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="applyUser") String applyUser , @ModelAttribute(value="projectId") String projectId, @ModelAttribute(value="status") String status){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("applyUser", applyUser);
		paramMap.put("projectId", projectId);
		paramMap.put("status", status);
		
		ModelAndView view = new ModelAndView("funds/cx/list");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("roleid",user.getRole().getId());
		
		view.addAllObjects(reimbursementService.doJoinTransFindApplyReimbursementList1(goPage, paramMap));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	@RequestMapping("/todetail/{id}")
	public ModelAndView todetail(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/cx/xiangxi");
		
		view.addAllObjects(reimbursementService.doJoinTransFindApplyReimbursement(id));
		return view;
	}
}
