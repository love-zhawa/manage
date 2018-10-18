/*
 * ApplyExpertFeeController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月8日 下午4:35:35
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.funds;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
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

import team.nercita.manage.cms.po.deptmanage.Experts;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyExpertFee;
import team.nercita.manage.cms.po.form.ExpertFeeDetail;
import team.nercita.manage.cms.service.apply.ExpertFeeService;
import team.nercita.manage.cms.service.project.ProjectService;
import team.nercita.manage.cms.service.usermanage.ExpertsService;
import team.nercita.manage.cms.util.NumberToCN;

/**
 * 专家费
 * @author 侯建玮
 * @date 2017年11月8日 下午4:35:35
 */
@Controller
@RequestMapping("/funds/expertfee")
public class ExpertFeeController {
	@Autowired
	ExpertFeeService expertFeeService; 
	@Autowired 
	ProjectService projectService;//项目
	@Autowired
	ExpertsService expertsService;//专家
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="title") String title , @ModelAttribute(value="keyWords") String keyWords){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("keyWords", keyWords);
		paramMap.put("title", title);
		
		ModelAndView view = new ModelAndView("funds/expertFee/list");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		view.addObject("roleid",user.getRole().getId());
		
		view.addAllObjects(expertFeeService.doJoinTransFindApplyExpertFeeList(goPage, paramMap));
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("funds/expertFee/add");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		view.addObject("zjlist", expertsService.doJoinTransQueryExperts());
		return view;
	}
	
	@RequestMapping("/add")
	public String add(ApplyExpertFee applyExpertFee, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		expertFeeService.doTransSaveApplyExpertFee(applyExpertFee, user);
		attr.addFlashAttribute("msg", "添加成功！");
		return "redirect:/funds/expertfee/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/expertFee/edit");
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		view.addObject("zjlist", expertsService.doJoinTransQueryExperts());
		view.addObject("expertFee", expertFeeService.doJoinTransFindApplyExpertFee(id));
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(ApplyExpertFee applyExpertFee, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		
		ApplyExpertFee oldApplyExpertFee = expertFeeService.doJoinTransFindApplyExpertFeeById(applyExpertFee.getId());
		
		applyExpertFee.setCreateTime(oldApplyExpertFee.getCreateTime());
		applyExpertFee.setCreator(oldApplyExpertFee.getCreator());
		if(applyExpertFee.getStatus()==null||applyExpertFee.getStatus()==0||applyExpertFee.getStatus()==2){
			expertFeeService.doTransUpdateApplyExpertFee1(applyExpertFee, user);
		}else if(applyExpertFee.getStatus()==1){
			expertFeeService.doTransUpdateApplyExpertFee(applyExpertFee, user);
			expertFeeService.doTransUpdateApplyExpertFee1(applyExpertFee, user);
		}
		
		attr.addFlashAttribute("msg", "修改成功！");
		return "redirect:/funds/expertfee/list";
	}
	
	@RequestMapping("/toprint/{id}")
	public ModelAndView toprint(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/expertFee/print");
		
		ApplyExpertFee fee = expertFeeService.doJoinTransFindApplyExpertFee(id);
		
		int amount = 0;
		
		if(fee.getDetailList() != null) {
			for (ExpertFeeDetail detail : fee.getDetailList()) {
				if(detail.getAmount() != null) {
					amount += detail.getAmount();
				}
			}
		}
		view.addObject("CN", NumberToCN.number2CNMontrayUnit(new BigDecimal(amount)));
		view.addObject("expertFee", fee);
		
		return view;
	}
	
	@RequestMapping("/toaudit/{id}")
	public ModelAndView toaudit(@PathVariable String id){
		ModelAndView view = new ModelAndView("funds/expertFee/audit");
		view.addAllObjects(expertFeeService.doJoinTransFindApplyExpertFees(id));
		return view;
	}

	@RequestMapping("/audit")
	public String audit(String id, int status, RedirectAttributes attr){
		expertFeeService.doTransApplyAudit(id, status);
		attr.addFlashAttribute("msg", "审核成功！");
		return "redirect:/funds/expertfee/list";
	}
	
	@RequestMapping("/sub/{id}")
	public String sub(@PathVariable String id, RedirectAttributes attr){
		expertFeeService.doTransApplyAudit(id, 0);
		attr.addFlashAttribute("msg", "提交成功！");
		return "redirect:/funds/expertfee/list";
	}
	
	@RequestMapping("/view/{id}")
	@ResponseBody
	public Experts view(@PathVariable String id){
		Experts zj = expertsService.doJoinTransFindExperts(id);
		Experts view = new Experts();
		view.setIdCard(zj.getIdCard());
		view.setUnit(zj.getUnit());
		view.setTitle(zj.getTitle());
		view.setBankCard(zj.getBankCard());
		view.setBankName(zj.getBankName());
		
		return view;
	}
	@RequestMapping("/allzj")
	@ResponseBody
	public List<Experts> getAllZj(){
		List<Experts> zj = expertsService.doJoinTransQueryExperts();
		
		return zj;
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
			ApplyExpertFee fee = expertFeeService.doJoinTransFindApplyExpertFee(id);
			if(fee.getStatus()==null||fee.getStatus()==0||fee.getStatus()==2){
				expertFeeService.doTransCommonDel1(id);
			}else if(fee.getStatus()==1){
				expertFeeService.doTransCommonDel(id);
			}
			return "0";
		} catch (Exception e) {
			return "1";
		}
	}
	
}
