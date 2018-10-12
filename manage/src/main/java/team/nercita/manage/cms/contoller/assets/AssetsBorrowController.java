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

import team.nercita.manage.cms.po.assets.AssetsBorrow;
import team.nercita.manage.cms.service.assets.AssetsBorrowService;
import team.nercita.manage.cms.service.assets.AssetsService;

/**
 * 固定资产控制器
 * @author 侯建玮
 * @date 2017年7月26日 下午9:00:05
 */
@Controller
@RequestMapping("/assets/borrow")
public class AssetsBorrowController {
	
	@Autowired
	AssetsService assetsService;
	
	@Autowired
	AssetsBorrowService assetsborrowService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="assetsname") String assetsname, @ModelAttribute(value="person") String person ,@ModelAttribute(value="dd") String dd){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("assetsname", assetsname);
		paramMap.put("person", person);
		paramMap.put("dd", dd);
		
		ModelAndView view = new ModelAndView("assets/borrow/list");
		view.addObject("lists", assetsService.doJoinTransFindAssetsAll());
		view.addAllObjects(assetsborrowService.doJoinTransAssetsBorrowList(goPage, paramMap));
		return view;
	}
	
	@RequestMapping("/toadd")
	public ModelAndView toadd(){
		ModelAndView view = new ModelAndView("assets/borrow/add");
		view.addObject("lists", assetsService.doJoinTransFindAssetsAll());
		
		return view;
	}
	
	@RequestMapping("/add")
	public String add(AssetsBorrow assets, RedirectAttributes attr){
		assetsborrowService.doTransSaveAssetsBorrow(assets);
		attr.addFlashAttribute("msg", "添加成功!");
		return "redirect:/assets/borrow/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("assets/borrow/edit");
		view.addObject("assets", assetsborrowService.doJoinTransFindAssetsBorrowById(id));
		view.addObject("lists", assetsService.doJoinTransFindAssetsAll());
		return view;
	}
	
	@RequestMapping("/detail/{id}")
	public ModelAndView detail(@PathVariable String id){
		ModelAndView view = new ModelAndView("assets/borrow/detail");
		view.addObject("assets", assetsborrowService.doJoinTransFindAssetsBorrowById(id));
		
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(AssetsBorrow assets, RedirectAttributes attr){
		assetsborrowService.doTransUpdateAssetsBorrow(assets);
		attr.addFlashAttribute("msg", "修改成功!");
		return "redirect:/assets/borrow/list";
	}
}
