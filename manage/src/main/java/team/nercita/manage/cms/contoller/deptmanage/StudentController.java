/*
 * UserManageController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年6月17日 下午8:49:46
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.deptmanage;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.deptmanage.Student;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.project.ProjectService;
import team.nercita.manage.cms.service.usermanage.AttendanceService;
import team.nercita.manage.cms.service.usermanage.StudentService;
import team.nercita.manage.cms.service.usermanage.UserService;
import team.nercita.manage.cms.util.NumberToCN;

/**
 * 学生管理
 */
@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	UserService userService;
	@Autowired
	ProjectService projectService;
	@Autowired
	StudentService stuService;
	@Autowired
	AttendanceService dkService;

	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,@ModelAttribute(value="tutor") String tutor){
		ModelAndView view = new ModelAndView("deptmanage/student/list");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tutor", tutor);
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		if(tutor==null || tutor.equals("")){
			view.addObject("lists",stuService.doJoinTransFindStudent());
			/*List<User> users = userService.doJoinTransQueryUserByTutor(user.getName());
			if(users.size()>0){
				tutor=user.getName();
				paramMap.put("tutor", tutor);
			}*/
		}else{
			view.addObject("lists",stuService.doJoinTransFindUserByTutorName(tutor));
		}
		
		view.addObject("tutors",userService.doJoinTransQueryTutor());
		request.setAttribute("username",user.getName());
		request.setAttribute("user",user);
		request.setAttribute("tutor",tutor);
		return view;
	}
	
	@RequestMapping("/toadd/{tutor}")
	public ModelAndView toadd(@PathVariable String tutor){
		ModelAndView view = new ModelAndView("deptmanage/student/add");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		
		view.addObject("user", user);
		view.addObject("userid", user.getId());
		view.addObject("tutor", tutor);
		List<User> lists = userService.doJoinTransQueryUserByTutor(tutor);//学生列表
		if(lists.size()>0){
			view.addObject("groupname",lists.get(0).getUserGroupName());
		}
		view.addObject("lists",lists);
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		return view;
	}
	@RequestMapping("/add")
	public String add(Student stu, RedirectAttributes attr){
		stuService.doTransSaveStu(stu);
		attr.addFlashAttribute("msg", "添加成功!");
		return "redirect:/student/list";
	}

	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(@PathVariable String id){
		ModelAndView view = new ModelAndView("deptmanage/student/edit");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		
		view.addObject("user", user);
		view.addObject("userid", user.getId());
		view.addObject("projectList", projectService.doJoinTransQueryProject());
		Student stu = stuService.doJoinTransFindUserById(id);
		if(stu!=null){
			List<User> lists = userService.doJoinTransQueryUserByTutor(stu.getTutor());//学生列表
			if(lists.size()>0){
				view.addObject("groupname",lists.get(0).getUserGroupName());
			}
		}
		view.addObject("stu", stu);
		return view;
	}
	@RequestMapping("/edit")
	public String edit(Student stu, RedirectAttributes attr){
		stuService.doTransUpdateStu(stu);
		attr.addFlashAttribute("msg", "修改成功!");
		return "redirect:/student/list";
	}
	
	@RequestMapping("/detail/{id}")
	public ModelAndView detail(@PathVariable String id){
		ModelAndView view = new ModelAndView("deptmanage/student/detail");
		
		view.addObject("stu", stuService.doJoinTransFindUserById(id));
		return view;
	}
	//打印
	@RequestMapping("/toprint/{id}")
	public ModelAndView toprint(@PathVariable String id){
		ModelAndView view = new ModelAndView("deptmanage/student/print");
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		
		view.addObject("user", user);
		Student stu = stuService.doJoinTransFindUserById(id);
		view.addObject("stu", stu);
		if(stu.getSummoney() != null) {
			view.addObject("EN", stu.getSummoney());
			view.addObject("CN", NumberToCN.number2CNMontrayUnit(new BigDecimal(stu.getSummoney())));
		}
		return view;
	}
	//审核页面
	@RequestMapping("/toaudit/{id}")
	public ModelAndView toaudit(@PathVariable String id){
		ModelAndView view = new ModelAndView("deptmanage/student/audit");
		
		view.addObject("stu", stuService.doJoinTransFindUserById(id));
		return view;
	}
	//审核
	@RequestMapping("/audit")
	public String audit(String id, int status, RedirectAttributes attr){
		stuService.doTransAudit(id, status);
		attr.addFlashAttribute("msg", "审核成功！");
		return "redirect:/student/list";
	}
	//提交审核
	@RequestMapping("/sub/{id}")
	public String sub(@PathVariable String id, RedirectAttributes attr){
		stuService.doTransAudit(id, 0);
		attr.addFlashAttribute("msg", "提交成功！");
		return "redirect:/student/list";
	}
	/**
	 * 根据时间查考勤天数
	 * @throws ParseException 
	 */
	@RequestMapping("/cx")
	@ResponseBody
	public List<String> cx(String stuid,String tutor,String year,String month,String date,@RequestParam("userids[]") List<Object> userids) throws ParseException{
		List<String> lists = new ArrayList<String>();
		String bztime = year+"-"+month+"-"+date;
		if(userids.size()>0){
			for (int i = 0; i < userids.size(); i++) {
				int ts = dkService.doJoinTransFindTs(userids.get(i).toString(),DateTime.parse(bztime).toDate());
				lists.add(String.valueOf(ts));
			}
		}
		if(stuid==null||stuid.equals("")){//添加
			List<Student> stulist = stuService.doJoinTransFindbz(tutor, DateTime.parse(bztime).toDate());
			if(stulist.size()>0){
				return null;
			}else{
				return lists;
			}
		}else{//修改时
			List<Student> stulist = stuService.doJoinTransFindbz(stuid,tutor, DateTime.parse(bztime).toDate());
			if(stulist.size()>0){
				return null;
			}else{
				return lists;
			}
		}
		
	}
	@RequestMapping("/cxs")
	@ResponseBody
	public List<String> cxs(String stuid,String tutor,String time,String date,@RequestParam("userids[]") List<Object> userids) throws ParseException{
		List<String> lists = new ArrayList<String>();
		String bztime = time+"-"+date;
		if(userids.size()>0){
			for (int i = 0; i < userids.size(); i++) {
				int ts = dkService.doJoinTransFindTs(userids.get(i).toString(),DateTime.parse(bztime).toDate());
				lists.add(String.valueOf(ts));
			}
		}
		if(stuid==null||stuid.equals("")){//添加
			List<Student> stulist = stuService.doJoinTransFindbz(tutor, DateTime.parse(bztime).toDate());
			if(stulist.size()>0){
				return null;
			}else{
				return lists;
			}
		}else{//修改时
			List<Student> stulist = stuService.doJoinTransFindbz(stuid,tutor, DateTime.parse(bztime).toDate());
			if(stulist.size()>0){
				return null;
			}else{
				return lists;
			}
		}
		
	}
}
