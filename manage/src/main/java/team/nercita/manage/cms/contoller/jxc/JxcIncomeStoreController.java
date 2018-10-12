/*
 * JxcIncomeStoreController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年12月24日 上午10:33:50
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.jxc;

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
import team.nercita.manage.cms.po.jxc.OutStoreApply;
import team.nercita.manage.cms.po.jxc.PurchaseDetail;
import team.nercita.manage.cms.service.jxc.OutStoreService;
import team.nercita.manage.cms.service.jxc.ProductStoreService;
import team.nercita.manage.cms.service.jxc.PurchaseService;

/**
 *
 * @author 侯建玮
 * @date 2017年12月24日 上午10:33:50
 */
@Controller
@RequestMapping("/jxc/income")
public class JxcIncomeStoreController {
	
	@Autowired
	PurchaseService purchaseService;
	
	@Autowired
	ProductStoreService productStoreService;
	
	@Autowired
	OutStoreService outStoreService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="typeid") String typeid, @ModelAttribute(value="purpose") String purpose){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("typeid", typeid);
		paramMap.put("purpose", purpose);
		
		ModelAndView view = new ModelAndView("jxc/income/list");
		view.addAllObjects(purchaseService.doJoinTransQueryDetail(goPage, paramMap));
		view.addObject("typeList", productStoreService.doJoinTransFindProductType());
		return view;
	}
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("jxc/income/add");
		view.addObject("outList", outStoreService.doTransFindAll());
		return view;
	}
	
	@RequestMapping("/add")
	public String add(PurchaseDetail detail, RedirectAttributes attr){
		purchaseService.doTransSavePurchaseDetail(detail);
		attr.addFlashAttribute("msg", "添加成功！");
		return "redirect:/jxc/income/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("jxc/income/edit");
		view.addObject("detail", purchaseService.doJoinTransPurchaseDetailById(id));
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(String id, int amount, RedirectAttributes attr){
		purchaseService.doTransUpdatePurchaseDetail(id, amount);
		attr.addFlashAttribute("msg", "修改成功！");
		return "redirect:/jxc/income/list";
	}
	
	@RequestMapping("/toedits/{id}")//手动添加后的修改
	public ModelAndView toedits(@PathVariable String id){
		ModelAndView view = new ModelAndView("jxc/income/edits");
		view.addObject("detail", purchaseService.doJoinTransPurchaseDetailById(id));
		view.addObject("outList", outStoreService.doTransFindAll());
		return view;
	}
	@RequestMapping("/edits")
	public String edits(PurchaseDetail detail, RedirectAttributes attr){
		purchaseService.doTransUpdatePurchaseDetails(detail);
		attr.addFlashAttribute("msg", "修改成功！");
		return "redirect:/jxc/income/list";
	}
	@RequestMapping("/plus/{id}")
	public String plus(@PathVariable String id, RedirectAttributes attr){
		purchaseService.doTransPlusStore(id);
		attr.addFlashAttribute("msg", "入库成功！");
		return "redirect:/jxc/income/list";
	}
	
	@RequestMapping("/cancel/{id}")
	public String cancel(@PathVariable String id, RedirectAttributes attr){
		purchaseService.doTransCancelDetail(id);
		attr.addFlashAttribute("msg", "取消成功！");
		return "redirect:/jxc/income/list";
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public String del(String id, String entry){
		try {
			purchaseService.doTransIncomeDel(id);
			return "0";
		} catch (Exception e) {
			return "1";
		}
	}
	
}
