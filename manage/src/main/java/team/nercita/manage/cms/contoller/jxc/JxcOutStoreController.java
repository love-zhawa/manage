/*
 * JxcOutStoreController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年12月24日 下午12:12:10
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.jxc;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.deptmanage.PlanLog;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.jxc.IncomeLog;
import team.nercita.manage.cms.po.jxc.OutStoreApply;
import team.nercita.manage.cms.po.jxc.ProductStore;
import team.nercita.manage.cms.po.jxc.ProductStoreItem;
import team.nercita.manage.cms.service.jxc.OutStoreService;
import team.nercita.manage.cms.service.jxc.ProductStoreService;
import team.nercita.manage.cms.service.project.ProjectService;
import team.nercita.manage.cms.vo.AlertWinVo;
import team.nercita.manage.cms.vo.ValueVo;

/**
 *
 * @author 侯建玮
 * @date 2017年12月24日 下午12:12:10
 */
@Controller
@RequestMapping("/jxc/out")
public class JxcOutStoreController {
	
	@Autowired
	ProductStoreService productStoreService;
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	OutStoreService outStoreService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="typeid") String typeid, @ModelAttribute(value="purpose") String purpose){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("typeid", typeid);
		paramMap.put("purpose", purpose);
		
		ModelAndView view = new ModelAndView("jxc/out/list");
		view.addAllObjects(outStoreService.doJoinTransFindOutStoreList(goPage, user, paramMap));
		view.addObject("typeList", productStoreService.doJoinTransFindProductType());
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("jxc/out/add");
		view.addObject("typeList", productStoreService.doJoinTransFindProductType());
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	
	@RequestMapping("/add")
	public String add(OutStoreApply outStoreApply, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		outStoreApply.setUseMan(user.getName());
		outStoreService.doTransSaveOutStoreApply(outStoreApply);
		attr.addFlashAttribute("msg", "添加成功！");
		return "redirect:/jxc/out/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("jxc/out/edit");
		
		OutStoreApply outStoreApply = outStoreService.doJoinTransFindOutStoreApply(id);
		
		List<ProductStore> productStoreList = productStoreService.doJoinTransFindStoreByTypeId(outStoreApply.getProductType().getId());
		
		List<ValueVo> voList = new ArrayList();
		
		for (ProductStore productStore : productStoreList) {
			ValueVo vo = new ValueVo();
			vo.setPid(productStore.getId());
			
			String value = "";
			for (ProductStoreItem item : productStore.getItemList()) {
				value += item.getPropertyName() + "-" + item.getPropertyValue();
			}
			
			vo.setPname(value);
			
			voList.add(vo);
		}
		
		view.addObject("typeList", productStoreService.doJoinTransFindProductType());
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		view.addObject("apply", outStoreApply);
		view.addObject("valueList", voList);
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(OutStoreApply outStoreApply, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		outStoreApply.setUseMan(user.getName());
		outStoreService.doTransUpdateOutStoreApply(outStoreApply);
		attr.addFlashAttribute("msg", "修改成功！");
		return "redirect:/jxc/out/list";
	}
	
	@RequestMapping("/model/amount/{id}")
	@ResponseBody
	public int modelamount(@PathVariable String id){
		ProductStore productStore = productStoreService.doJoinTransFindStoreById(id);
		
		return productStore.getAmount();
	}
	
	@RequestMapping("/subaudit/{id}")
	public String subaudit(@PathVariable String id, RedirectAttributes attr){
		outStoreService.doTransSubAuditStoreApply(id);
		attr.addFlashAttribute("msg", "提交成功！");
		return "redirect:/jxc/out/list";
	}
	
	@RequestMapping("/toaudit/{id}")
	public ModelAndView toaudit(@PathVariable String id){
		ModelAndView view = new ModelAndView("jxc/out/audit");
		OutStoreApply outStoreApply = outStoreService.doJoinTransFindOutStoreApply(id);
		view.addObject("apply", outStoreApply);
		return view;
	}
	
	@RequestMapping("/audit")
	public String audit(String id, int status, String auditMsg, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		outStoreService.doTransAuditOutStore(id, status,user, auditMsg);
		attr.addFlashAttribute("msg", "审核成功！");
		return "redirect:/jxc/out/list";
	}
	
	@RequestMapping("/out/{id}")
	public String out(@PathVariable String id, RedirectAttributes attr){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		try {
			outStoreService.doTransOutStore(id, user);
			attr.addFlashAttribute("msg", "出库成功！");
		} catch (Exception e) {
			attr.addFlashAttribute("msg", e.getMessage());
		}
		return "redirect:/jxc/out/list";
	}
	
	
	@RequestMapping("/model/{id}")
	@ResponseBody
	public List<AlertWinVo> model(@PathVariable String id){
		List<AlertWinVo> voList = new ArrayList();
		OutStoreApply outStore = outStoreService.doJoinTransFindOutStoreApply(id);
		if(outStore !=null){
			AlertWinVo vo = new AlertWinVo();
			vo.setStr1(outStore.getProductType().getTypeName());
			vo.setStr2(outStore.getModel());
			vo.setStr3(outStore.getAmount().toString());
			vo.setStr4(outStore.getPurpose());
			vo.setStr5(outStore.getRemark());
			
			voList.add(vo);
		}
		return voList;
	}
	/*
	 * 查看入库 历史过程
	 */
	@ResponseBody
	@RequestMapping("/show/{id}")
	public List<AlertWinVo> show(@PathVariable String id){
		List<AlertWinVo> voList = new ArrayList();
		List<IncomeLog> logs = outStoreService.doTransFindIncomeLog(id);
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		if(logs !=null && !logs.isEmpty()){
			for (IncomeLog log : logs) {
				AlertWinVo vo = new AlertWinVo();
				vo.setStr1(log.getCpname());
				vo.setStr2(df.format(log.getCreateTime()));
				vo.setStr3(log.getAmount().toString());
				if(log.getRktype().equals("1")){
					vo.setStr4("借用返还");
				}else if(log.getRktype().equals("2")){
					vo.setStr4("其他");
				}
				vo.setStr5(log.getHome());
				vo.setStr6(log.getBz());
				
				voList.add(vo);
			}
		}
		return voList;
	}
	
}
