/*
 * ApplyReimbursementController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月8日 上午11:31:44
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.apply;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import team.nercita.manage.cms.po.form.ApplyReimbursement;
import team.nercita.manage.cms.po.form.ReimbursementDetail;
import team.nercita.manage.cms.service.apply.ReimbursementService;
import team.nercita.manage.cms.service.project.ProjectService;
import team.nercita.manage.cms.util.NumberToCN;

/**
 * 日常报销
 * @author 侯建玮
 * @date 2017年11月8日 上午11:31:44
 */
@Controller
@RequestMapping("/apply/online/reimbursement")
public class ApplyReimbursementController {
	@Autowired
	ReimbursementService reimbursementService; 
	
	@Autowired
	ProjectService projectService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="payUnit") String payUnit , @ModelAttribute(value="projectId") String projectId){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("payUnit", payUnit);
		paramMap.put("projectId", projectId);
		
		ModelAndView view = new ModelAndView("apply/online/reimbursement/list");
		view.addAllObjects(reimbursementService.doJoinTransFindApplyReimbursementList(goPage, paramMap));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("apply/online/reimbursement/add");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("username",user.getName());
		view.addObject("groupname",user.getUserGroup().getGroupName());
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/add")
	public String add(ApplyReimbursement applyReimbursement, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		
		applyReimbursement.setAddUser(user);
		reimbursementService.doTransSaveApplyReimbursement(applyReimbursement, applyReimbursement.getDetailList());
		attr.addFlashAttribute("msg", "添加成功！");

		return "redirect:/apply/online/reimbursement/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("apply/online/reimbursement/edit");
		
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		view.addAllObjects(reimbursementService.doJoinTransFindApplyReimbursement(id));
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(ApplyReimbursement applyReimbursement, RedirectAttributes attr){
		ApplyReimbursement oldApplyReimbursement = reimbursementService.doJoinTransFindApplyReimbursementById(applyReimbursement.getId());
		
		applyReimbursement.setAddUser(oldApplyReimbursement.getAddUser());
		applyReimbursement.setCreator(oldApplyReimbursement.getCreator());
		applyReimbursement.setCreateTime(oldApplyReimbursement.getCreateTime());
		
		reimbursementService.doTransUpdateApplyReimbursement1(applyReimbursement, applyReimbursement.getDetailList());
		attr.addFlashAttribute("msg", "修改成功！");
		return "redirect:/apply/online/reimbursement/list";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/toprint/{id}")
	public ModelAndView toprint(@PathVariable String id){
		ModelAndView view = new ModelAndView("apply/online/reimbursement/print");
		
		Map<String, Object> resultMap = reimbursementService.doJoinTransFindApplyReimbursement(id);
		view.addAllObjects(resultMap);
		Double amount = 0.0;
		List<ReimbursementDetail> detailList = (List<ReimbursementDetail>)resultMap.get("detailList");
		
		if(detailList == null || detailList.size() < 5){
			if(detailList == null) {
				detailList = new ArrayList<ReimbursementDetail>();
			}
			
			int bc = 5 - detailList.size();
			for (int i = 0; i < bc; i++) {
				detailList.add(new ReimbursementDetail());
			}
		}
		
		for (ReimbursementDetail detail : detailList) {
			if(detail.getAmount() != null) {
				amount += detail.getAmount();
			}
		}
		
		view.addObject("detailList", detailList);
		if(amount != null) {
			view.addObject("EN", amount);
			view.addObject("CN", NumberToCN.number2CNMontrayUnit(new BigDecimal(amount)));
		}
		return view;
	}
}
