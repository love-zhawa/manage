/*
 * DialotherController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2018年1月1日 下午12:44:43
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.projectmanage.OtherFund;
import team.nercita.manage.cms.service.funds.OtherService;
import team.nercita.manage.cms.service.project.ProjectService;

/**
 *
 * @author 侯建玮
 * @date 2018年1月1日 下午12:44:43
 */
@Controller
@RequestMapping("/funds/other")
public class OtherController {
	@Autowired
	OtherService otherService;
	@Autowired 
	ProjectService projectService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="unit") String unit, @ModelAttribute(value="projectId") String projectId, @ModelAttribute(value="financialNumber") String financialNumber){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("unit", unit);
		paramMap.put("projectId", projectId);
		paramMap.put("financialNumber", financialNumber);
		
		ModelAndView view = new ModelAndView("funds/other/list");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("roleid",user.getRole().getId());
		
		view.addAllObjects(otherService.doJoinTransQueryFundsList(goPage, paramMap));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("funds/other/add");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/add")
	public String add(OtherFund otherFund, RedirectAttributes attr){
		otherService.doTransSaveOther(otherFund);
		attr.addFlashAttribute("msg", "添加成功!");
		return "redirect:/funds/other/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/other/edit");
		view.addObject("other",otherService.doJoinTransFindOtherById(id));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	} 
	
	@RequestMapping("/edit")
	public String edit(OtherFund otherFund, RedirectAttributes attr){
		if(otherFund.getStatus()==null||otherFund.getStatus()==0||otherFund.getStatus()==2){
			otherService.doTransUpdateOther1(otherFund);
		}else if(otherFund.getStatus()==1){
			otherService.doTransUpdateOther(otherFund);
			otherService.doTransUpdateOther1(otherFund);
		}
		attr.addFlashAttribute("msg", "修改成功!");
		return "redirect:/funds/other/list";
	}
	
	//提交审核
	@RequestMapping("/sub/{id}")
	public String sub(@PathVariable String id, RedirectAttributes attr){
		otherService.doTransOther(id, 0);
		attr.addFlashAttribute("msg", "提交成功！");
		return "redirect:/funds/other/list";
	}
	//跳转到审核页面
	@RequestMapping("/toaudit/{id}")
	public ModelAndView toaudit(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/other/audit");
		view.addObject(otherService.doJoinTransFindOther(id));
		return view;
	}
	//审核
	@RequestMapping("/audit")
	public String audit(String id, int status, RedirectAttributes attr){
		otherService.doTransOther(id, status);
		attr.addFlashAttribute("msg", "审核成功！");
		return "redirect:/funds/other/list";
	}
	/**
	 * 删除
	 * @param id
	 * @param entry
	 * @return
	 */
	@RequestMapping("/del")
	@ResponseBody
	public String del(String id){
		try {
			otherService.doTransCommonDel(id);
			otherService.doTransCommonDel1(id);
			return "0";
		} catch (Exception e) {
			return "1";
		}
	}
}
