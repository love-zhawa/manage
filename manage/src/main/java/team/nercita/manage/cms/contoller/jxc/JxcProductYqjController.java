package team.nercita.manage.cms.contoller.jxc;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.jxc.ProductYqj;
import team.nercita.manage.cms.service.jxc.ProductYqjService;
import team.nercita.manage.cms.util.Generator;

@Controller
@RequestMapping("/jxc/yqj")
public class JxcProductYqjController {
	
	@Autowired
	ProductYqjService productYqjService;
	
	@RequestMapping("/list")
	public ModelAndView list(Integer goPage, @ModelAttribute(value="name") String name, @ModelAttribute(value="lx") String lx){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("name", name);
		paramMap.put("lx", lx);
		
		ModelAndView view = new ModelAndView("jxc/yqj/list");
		view.addAllObjects(productYqjService.doJoinTransFindList(goPage, paramMap));
		return view;
	}
	
	@RequestMapping("/toadd")
	public String toadd(){
		return "jxc/yqj/add";
	}
	
	@RequestMapping("/add")
	public String add(ProductYqj productYqj, @RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, RedirectAttributes attr){
		if(file != null && file.getOriginalFilename() != null  && file.getSize() > 0){
			String fileName = file.getOriginalFilename();
			String newFileName = Generator.getUUID() + fileName.substring(fileName.lastIndexOf("."));
			File uploadFile = new File(request.getSession().getServletContext().getRealPath("/productImage"), newFileName);
			try {
				file.transferTo(uploadFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			productYqj.setFile(newFileName);
		}
		
		productYqjService.doTransSaveProductYqj(productYqj);
		attr.addFlashAttribute("msg", "添加成功！");
		return "redirect:/jxc/yqj/list";
	}
	
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("jxc/yqj/edit");
		view.addObject("yqj", productYqjService.doJoinTransFindYqjById(id));
		return view;
	}
	
	@RequestMapping("/edit")
	public String edit(ProductYqj productYqj, @RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, RedirectAttributes attr){
		if(file != null && file.getOriginalFilename() != null  && file.getSize() > 0){
			String fileName = file.getOriginalFilename();
			String newFileName = Generator.getUUID() + fileName.substring(fileName.lastIndexOf("."));
			File uploadFile = new File(request.getSession().getServletContext().getRealPath("/productImage"), newFileName);
			try {
				file.transferTo(uploadFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			productYqj.setFile(newFileName);
		}
		
		productYqjService.doTransUpdateDealer(productYqj);
		attr.addFlashAttribute("msg", "修改成功！");
		return "redirect:/jxc/yqj/list";
	}
	
	@RequestMapping("/detail/{id}")
	public ModelAndView detail(@PathVariable String id){
		ModelAndView view = new ModelAndView("jxc/yqj/detail");
		
		view.addObject("yqj", productYqjService.doJoinTransFindYqjById(id));
		return view;
	}
	@RequestMapping("/del/{id}")
	public String del(@PathVariable String id, RedirectAttributes attr){
		productYqjService.doTransDelete(id);
		attr.addFlashAttribute("msg", "删除成功!");
		return "redirect:/jxc/yqj/list";
	}
}
