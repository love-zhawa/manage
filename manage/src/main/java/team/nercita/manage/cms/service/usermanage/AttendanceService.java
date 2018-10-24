/*
 * AttendanceService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年7月16日 下午8:26:06
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.usermanage;

import java.util.Date;
import java.util.List;

import team.nercita.manage.cms.po.deptmanage.AttendanceGroup;
import team.nercita.manage.cms.po.deptmanage.AttendanceSet;
import team.nercita.manage.cms.po.deptmanage.AttendanceStat;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.sign.Attendance;
import team.nercita.manage.cms.vo.AbsentVo;
import team.nercita.manage.cms.vo.AttendanceVo;

/**
 * 出勤service
 * @author 侯建玮
 * @date 2017年7月16日 下午8:26:06
 */
public interface AttendanceService {
	
	//public Map<String, Object> doJoinTransFindStats(Integer goPage, Map<String, Object> paramMap);
	
	public List<AttendanceGroup> doJoinTransQueryGroup();
	
	public void doTransAttendanceSet(AttendanceSet attendanceSet, String ids);
	
	public AttendanceSet doJoinTransAttendanceSet();
	
	public List<AttendanceVo> doJoinTransCurrStat(Date date);
	
	public List<AttendanceVo> doJoinTransCurrYestoday(Date date);
	
	public List<AttendanceStat> doJoinTransFindStat(Date date);
	
	public List<AbsentVo> doJoinTransFindAbsent(Date date);
	
	
	public List<Attendance> doJoinTransAtt(Date date,User user);
	public List<Attendance> doJoinTransAtt(Date date,String userid);
	
	public List<Attendance> doJoinTransAtts(Date date);
	
	public int doJoinTransFindTs(String userid,Date bztime);
	
	public int doJoinTransFindTs2(String userid,Date begin,Date end);
	
	public int doJoinTransFindTs2(Date begin,Date end);//工作日
	
	public int doJoinTransFindCdts(String userid,Date begin,Date end);//迟到
	public int doJoinTransFindZtts(String userid,Date begin,Date end);//早退
}
