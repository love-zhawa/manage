/*
 * AttendanceController.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年7月16日 下午8:22:26
 * 创业小团队-后台
 */
package team.nercita.manage.cms.contoller.deptmanage;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import team.nercita.manage.cms.po.deptmanage.AttendanceGroup;
import team.nercita.manage.cms.po.deptmanage.AttendanceSet;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyLeave;
import team.nercita.manage.cms.po.form.ApplyOvertime;
import team.nercita.manage.cms.po.form.ApplyTrval;
import team.nercita.manage.cms.po.sign.Attendance;
import team.nercita.manage.cms.service.apply.LeaveService;
import team.nercita.manage.cms.service.apply.OvertimeService;
import team.nercita.manage.cms.service.apply.TrvalService;
import team.nercita.manage.cms.service.sign.SignService;
import team.nercita.manage.cms.service.usermanage.AttendanceService;
import team.nercita.manage.cms.service.usermanage.UserService;
import team.nercita.manage.cms.vo.AlertWinVo;

/**
 * 靠前管理
 * @author 侯建玮
 * @date 2017年7月16日 下午8:22:26
 */
@Controller
@RequestMapping("/attendance")
public class AttendanceController {
	@Autowired
	SignService signService;
	
	@Autowired
	AttendanceService attendanceService;
	@Autowired
	UserService userService;
	@Autowired
	LeaveService qjService;
	@Autowired
	TrvalService ccService;
	@Autowired
	OvertimeService jbService;
	@Autowired
	AttendanceService dkService;
	@RequestMapping("/stat")
	public ModelAndView stat(HttpServletRequest request,Integer goPage,@ModelAttribute(value="startTime") String startTime) {
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("startTime", startTime);
		Date date = DateTime.parse(DateTime.now().minusDays(0).toString("yyyy-MM-dd")).toDate();
		String dataTime = DateTime.now().minusDays(0).toString("yyyy-MM-dd");
		if(StringUtils.isNotBlank(startTime)) {
			date = DateTime.parse(startTime).toDate();
			dataTime = startTime;
			
		}
		
		ModelAndView view = new ModelAndView("deptmanage/attendance/stat");
		view.addObject("curr", attendanceService.doJoinTransCurrStat(DateTime.parse(DateTime.now().toString("yyyy-MM-dd")).toDate()));
		view.addObject("yestoday", attendanceService.doJoinTransFindAbsent(DateTime.parse(DateTime.now().toString("yyyy-MM-dd")).toDate()));
		
		view.addObject("dk", attendanceService.doJoinTransAtt(date,user));
		
		List<Attendance> dkmx = attendanceService.doJoinTransAtts(date);
		view.addObject("dkmx",dkmx);
		
		Map<String,Object> qjmap = new HashMap<String, Object>();
		Map<String,Object> ccmap = new HashMap<String, Object>();
		Map<String,Object> jbmap = new HashMap<String, Object>();
		
		if(dkmx.size()>0){
			for (int i = 0; i < dkmx.size(); i++) {
				//是否请假
				List<ApplyLeave> qjlist = qjService.doJoinTransLeave(date,dkmx.get(i).getUser().getId());
				if(qjlist.size()>0){
					for (int j = 0; j < qjlist.size(); j++) {
						qjmap.put(dkmx.get(i).getUser().getId(),"请假");
					}
				}
				//出差
				List<ApplyTrval> cclist = ccService.doJoinTransTrval(date, dkmx.get(i).getUser().getId());
				if(cclist.size()>0){
					for (int j = 0; j < cclist.size(); j++) {
						ccmap.put(dkmx.get(i).getUser().getId(),"出差");
					}
				}
				//加班
				List<ApplyOvertime> jblist = jbService.doJoinTransOvertime(date, dkmx.get(i).getUser().getId());
				if(jblist.size()>0){
					for (int j = 0; j < jblist.size(); j++) {
						jbmap.put(dkmx.get(i).getUser().getId(),"加班");
					}
				}
			}
		}
		request.setAttribute("qjmap",qjmap);
		request.setAttribute("ccmap",ccmap);
		request.setAttribute("jbmap",jbmap);
		String day = "3000-01-01 00:00:00";
		request.setAttribute("day",day);
		return view;
	}
	@RequestMapping("/tj/{beginTime},{endTime}")
	@ResponseBody
	public List<AlertWinVo> tj(@PathVariable String beginTime,@PathVariable String endTime) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginTime", beginTime);
		paramMap.put("endTime", endTime);
		
		Date begin = DateTime.parse(DateTime.now().minusDays(30).toString("yyyy-MM-dd")).toDate();
		Date end = DateTime.parse(DateTime.now().minusDays(0).toString("yyyy-MM-dd")).toDate();
		String dataTime = DateTime.now().minusDays(30).toString("yyyy-MM-dd");
		String dataTimes = DateTime.now().minusDays(0).toString("yyyy-MM-dd");
		if(StringUtils.isNotBlank(beginTime)) {
			begin = DateTime.parse(beginTime).toDate();
			dataTime = beginTime;
		}
		if(StringUtils.isNotBlank(endTime)) {
			end = DateTime.parse(endTime).toDate();
			dataTimes = endTime;
		}
		List<Attendance> dkmx = attendanceService.doJoinTransAtts(begin);//打卡明细
		List<AlertWinVo> voList = new ArrayList();
		if(dkmx.size()>0){
			for (int i = 0; i < dkmx.size(); i++) {
				int ts = dkService.doJoinTransFindTs2(dkmx.get(i).getUser().getId(),begin,end);//出勤天数
				int gzr = dkService.doJoinTransFindTs2(begin,end);//工作日
				int cdts = dkService.doJoinTransFindCdts(dkmx.get(i).getUser().getId(),begin,end);//迟到天数
				int ztts = dkService.doJoinTransFindZtts(dkmx.get(i).getUser().getId(),begin,end);//早退天数
				List<ApplyLeave> qjtss = qjService.doJoinTransFindTs(dkmx.get(i).getUser().getId(),begin,end);//请假天数
				int qjts = 0;
				if(qjtss.size()>0){
					for (ApplyLeave app : qjtss) {
						if(app.getTs()!=null&&!app.getTs().equals("")){
							qjts+=app.getTs();
						}
					}
				}
				
				AlertWinVo vo = new AlertWinVo();
				vo.setStr1(dkmx.get(i).getUser().getName());
				vo.setStr2(String.valueOf(ts));
				vo.setStr3(String.valueOf(cdts));
				vo.setStr4(String.valueOf(ztts));
				vo.setStr5(String.valueOf(qjts));
				vo.setStr6(String.valueOf(gzr-ts));
				voList.add(vo);
			}
		}
		return voList;
	}
	@RequestMapping("/toadd")
	public String toadd(){
		return "deptmanage/attendance/add";
	}
	
	@RequestMapping("/add")
	public String add(String startTime, String endTime, int absentType, String reason){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		signService.doTransSaveAbsent(user, reason, absentType, DateTime.parse(startTime).toDate(), DateTime.parse(endTime).toDate(), "");
		return "redirect:/attendance/stat";
	}
	
	@RequestMapping("/toset")
	public ModelAndView toset(){
		ModelAndView view = new ModelAndView("deptmanage/attendance/set");
		
		List<AttendanceGroup> groupList = attendanceService.doJoinTransQueryGroup();
		List<User> userList = userService.doJoinTransQueryUserList();
		
		Map<String, User> userMap = new HashMap();
		for (User user : userList) {
			userMap.put(user.getId(), user);
		}
		
		for (AttendanceGroup attendanceGroup : groupList) {
			if(userMap.containsKey(attendanceGroup.getUser().getId())){
				userMap.remove(attendanceGroup.getUser().getId());
			}
		}
		
		List<User> notAttList = new ArrayList();
		
		if(!userMap.isEmpty()) {
			for(Map.Entry<String, User> maps : userMap.entrySet()){
				notAttList.add(maps.getValue());
			}
		}
		view.addObject("notList", notAttList);
		view.addObject("groupList", groupList);
		view.addObject("setinfo", attendanceService.doJoinTransAttendanceSet());
		
		return view;
	}
	
	@RequestMapping("/set")
	public String set(AttendanceSet attendanceSet, String ids, RedirectAttributes attr){
		attendanceService.doTransAttendanceSet(attendanceSet, ids);
		attr.addFlashAttribute("msg", "考勤组设置成功！");
		return "redirect:/attendance/toset";
	}
}
