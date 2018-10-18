/*
 * DialOutController.java
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
import team.nercita.manage.cms.po.projectmanage.DialOutFund;
import team.nercita.manage.cms.service.funds.DialOutService;
import team.nercita.manage.cms.service.project.ProjectService;

/**
 *
 * @author 侯建玮
 * @date 2018年1月1日 下午12:44:43
 */
@Controller
@RequestMapping("/funds/out")
public class DialOutController {
	@Autowired
	DialOutService dialOutService;
	
	@Autowired 
	ProjectService projectService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="projectId") String projectId){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("projectId", projectId);
		
		ModelAndView view = new ModelAndView("funds/out/list");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("roleid",user.getRole().getId());
		
		view.addAllObjects(dialOutService.doJoinTransQueryFundsList(goPage, paramMap));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("funds/out/add");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/add")
	public String add(DialOutFund dialOutFund, RedirectAttributes attr){
		dialOutService.doTransSaveDialOut(dialOutFund);
		attr.addFlashAttribute("msg", "添加成功!");
		return "redirect:/funds/out/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/out/edit");
		view.addObject("fundsout",dialOutService.doJoinTransFindDialOutById(id));
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	} 
	
	@RequestMapping("/edit")
	public String edit(DialOutFund dialOutFund, RedirectAttributes attr){
		if(dialOutFund.getStatus()==null||dialOutFund.getStatus()==0||dialOutFund.getStatus()==2){
			dialOutService.doTransUpdateDialOut1(dialOutFund);
		}else if(dialOutFund.getStatus()==1){
			dialOutService.doTransUpdateDialOut(dialOutFund);
			dialOutService.doTransUpdateDialOut1(dialOutFund);
		}
		
		attr.addFlashAttribute("msg", "修改成功!");
		return "redirect:/funds/out/list";
	}
	//提交审核
	@RequestMapping("/sub/{id}")
	public String sub(@PathVariable String id, RedirectAttributes attr){
		dialOutService.doTransDialOut(id, 0);
		attr.addFlashAttribute("msg", "提交成功！");
		return "redirect:/funds/out/list";
	}
	//跳转到审核页面
	@RequestMapping("/toaudit/{id}")
	public ModelAndView toaudit(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/out/audit");
		view.addObject(dialOutService.doJoinTransFindDialOut(id));
		return view;
	}
	//审核
	@RequestMapping("/audit")
	public String audit(String id, int status, RedirectAttributes attr){
		dialOutService.doTransDialOut(id, status);
		attr.addFlashAttribute("msg", "审核成功！");
		return "redirect:/funds/out/list";
	}
	/**
	 * 删除
	 * @param id
	 * 
	 * 
	 * @param entry
	 * @return
	 */
	@RequestMapping("/del")
	@ResponseBody
	public String del(String id){
		DialOutFund dialOutFund = dialOutService.doJoinTransFindDialOutById(id);
		try {
			if(dialOutFund.getStatus()==null||dialOutFund.getStatus()==0||dialOutFund.getStatus()==2){
				dialOutService.doTransCommonDel1(id);
			}else if(dialOutFund.getStatus()==1){
				dialOutService.doTransCommonDel(id);
				dialOutService.doTransCommonDel1(id);
			}
			return "0";
		} catch (Exception e) {
			return "1";
		}
	}
}
