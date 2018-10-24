/*
 * SignServiceImpl.java
 * 创建者：侯建玮
 * 创建日期：2017年12月18日 下午3:54:29
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.service.sign.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.joda.time.DateTime;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyLeave;
import team.nercita.manage.cms.po.form.ApplyOvertime;
import team.nercita.manage.cms.po.form.ApplyTrval;
import team.nercita.manage.cms.po.form.TrvalDetail;
import team.nercita.manage.cms.po.sign.Absent;
import team.nercita.manage.cms.po.sign.Attendance;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.sign.SignService;
import team.nercita.manage.cms.util.Generator;

/**
 * 
 * @author 侯建玮
 * @date： 2017年12月18日 下午3:54:29
 */
@Component
public class SignServiceImpl extends BaseService implements SignService {
	static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdf = new SimpleDateFormat("HH");
	/*@SuppressWarnings("unchecked")
	@Override
	public void doTransSaveSign(User user, String addr) {
		String sql = "select a from Attendance a where a.attendanceTime >= :NOWDATE and a.user.id = :USERID";
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("NOWDATE", DateTime.parse(DateTime.now().toString("yyyy-MM-dd")).toDate());
		queryMap.put("USERID", user.getId());
		
		List<Attendance> attendanceList = (List<Attendance>) baseDao.findObjectList(sql, queryMap);
		
		int times = 1;
		if(attendanceList != null && attendanceList.size() >= 1) {
			times = 2;
			for (Attendance attendance : attendanceList) {
				if(attendance.getTimes() != 1) {
					baseDao.delete(attendance);
				}
			}
		}
		Date nowDate = new Date();
		
		Attendance attendance = new Attendance();
		attendance.setId(Generator.getUUID());
		attendance.setUser(user);
		attendance.setAddr(addr);
		attendance.setTimes(times);
		attendance.setAttendanceTime(nowDate);
		nowDate  = DateTime.parse(DateTime.now().minusDays(0).toString("yyyy-MM-dd")).toDate();
		attendance.setDkTime(nowDate);
		
		baseDao.save(attendance);
		
		sql = "select a from AttendanceGroup a where a.user.id = :USERID and a.user.useStatus = :USESTATUS";
		
		queryMap.clear();
		queryMap.put("USERID", user.getId());
		queryMap.put("USESTATUS", User.UseStatus.normal.getValue());
		
		AttendanceGroup group = baseDao.findObject(sql, queryMap);
		
		if(group != null && times == 1) {//在考勤组内
			sql = "select a from AttendanceStat a where a.user.id = :USERID and a.statTime = :STATTIME";
			
			queryMap.clear();
			queryMap.put("USERID", user.getId());
			queryMap.put("STATTIME", DateTime.parse(DateTime.now().toString("yyyy-MM-dd")).toDate());
			
			AttendanceStat attendanceStat = baseDao.findObject(sql, queryMap);
			
			String attTimeStr = new SimpleDateFormat("HH:mm:ss").format(attendance.getAttendanceTime());
			Date attTime = null;
			try {
				attTime = new SimpleDateFormat("HH:mm:ss").parse(attTimeStr);
			} catch (Exception e) {
			}
			
			if(attendanceStat == null) {
				Date startTime = group.getAttendanceSet().getStartTime();
				attendanceStat = new AttendanceStat();
				attendanceStat.setId(Generator.getUUID());
				attendanceStat.setUser(user);
				attendanceStat.setStatTime(nowDate);
				
				if(attTime.before(startTime)) {
					attendanceStat.setZaodaka(0);//正常
				} else {
					attendanceStat.setZaodaka(1);//异常
				}
				
				baseDao.save(attendanceStat);
			} else {
				if(attendanceStat.getZaodaka() != null) {
					Date endTime = group.getAttendanceSet().getEndTime();
					if(attTime.after(endTime)) {
						attendanceStat.setZaodaka(0);//正常
					} else {
						attendanceStat.setZaodaka(1);//异常
					}
				}
				baseDao.update(attendanceStat);
			}
		}
	}*/
	@SuppressWarnings("unchecked")
	@Override
	public void doTransSaveSign(User user, String addr) {
		String sql = "select a from Attendance a where a.attendanceTime >= :NOWDATE and a.user.id = :USERID";
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("NOWDATE", DateTime.parse(DateTime.now().toString("yyyy-MM-dd")).toDate());
		queryMap.put("USERID", user.getId());
		
		List<Attendance> attendanceList = (List<Attendance>) baseDao.findObjectList(sql, queryMap);
		
		int times = 1;
		if(attendanceList != null && attendanceList.size() >= 1) {//签退
			for (Attendance attendance : attendanceList) {
				Date nowDate = new Date();
				Integer xb = Integer.parseInt(sdf.format(nowDate).toString());
				if(xb<17){
					attendance.setIszt(1);
				}else{
					attendance.setIszt(0);
				}
				
				attendance.setAddr(attendance.getAddr());
				attendance.setAddr2(addr);
				attendance.setTimes(2);
				attendance.setAttendanceTime(attendance.getAttendanceTime());//签到时间
				attendance.setAttendanceTime2(nowDate);//签退时间
				nowDate  = DateTime.parse(DateTime.now().minusDays(0).toString("yyyy-MM-dd")).toDate();
				attendance.setDkTime(nowDate);
				
				baseDao.update(attendance);
			}
		}else{//签到
			Date nowDate = new Date();
			
			Attendance attendance = new Attendance();
			Integer sb = Integer.parseInt(sdf.format(nowDate).toString());
			if(sb>9){
				attendance.setIscd(1);
			}else{
				attendance.setIscd(0);
			}
			
			attendance.setId(Generator.getUUID());
			attendance.setUser(user);
			attendance.setAddr(addr);
			attendance.setTimes(times);
			attendance.setAttendanceTime(nowDate);
			nowDate  = DateTime.parse(DateTime.now().minusDays(0).toString("yyyy-MM-dd")).toDate();
			attendance.setDkTime(nowDate);
			
			baseDao.save(attendance);
		}
	}
	
	/*@Override
	public void doTransSaveAbsent(User user, String reason, int absentType, Date startTime, Date endTime, String duration) {
		Absent absent = new Absent();
		absent.setId(Generator.getUUID());
		absent.setAbsentType(absentType);
		absent.setStartTime(startTime);
		absent.setEndTime(endTime);
		absent.setReason(reason);
		absent.setUser(user);
		absent.setDuration(duration);
		
		baseDao.save(absent);
		
		String sql = "select a from AttendanceGroup a where a.user.id = :USERID and a.user.useStatus = :USESTATUS";
		
		Map<String, Object> queryMap = new HashMap();
		queryMap.put("USERID", user.getId());
		queryMap.put("USESTATUS", User.UseStatus.normal.getValue());
		
		AttendanceGroup group = baseDao.findObject(sql, queryMap);
		
		if(group != null) {//在考勤组内
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			List<Date> dateList = getDate(df.format(startTime), df.format(endTime));
			
			for (Date date : dateList) {
				sql = "select a from AttendanceStat a where a.user.id = :USERID and a.statTime = :STATTIME";
				
				queryMap.clear();
				queryMap.put("USERID", user.getId());
				queryMap.put("STATTIME", date);
				
				AttendanceStat attendanceStat = baseDao.findObject(sql, queryMap);
				
				if(attendanceStat != null) {
					if(absentType == 1) {
						attendanceStat.setQingjia(1);
					} else if(absentType == 2) {
						attendanceStat.setWaichu(1);
					} else if(absentType == 3) {
						attendanceStat.setChuchai(1);
					} else if(absentType == 4) {
						attendanceStat.setJiaban(1);
					}
					
					baseDao.update(attendanceStat);
				} else {
					attendanceStat = new AttendanceStat();
					attendanceStat.setId(Generator.getUUID());
					attendanceStat.setStatTime(date);
					attendanceStat.setUser(user);
					if(absentType == 1) {
						attendanceStat.setQingjia(1);
					} else if(absentType == 2) {
						attendanceStat.setWaichu(1);
					} else if(absentType == 3) {
						attendanceStat.setChuchai(1);
					} else if(absentType == 4) {
						attendanceStat.setJiaban(1);
					}
					
					baseDao.save(attendanceStat);
				}
			}
		}
	}*/
	@Override
	public void doTransSaveAbsent(User user, String reason, int absentType, Date startTime, Date endTime, String duration) {
		Absent absent = new Absent();
		absent.setId(Generator.getUUID());
		absent.setAbsentType(absentType);
		absent.setStartTime(startTime);
		absent.setEndTime(endTime);
		absent.setReason(reason);
		absent.setUser(user);
		absent.setDuration(duration);
		baseDao.save(absent);
		if(absentType == 1){//1是请假  2 外出  3 出差 4加班
			ApplyLeave qingjia = new ApplyLeave();
			qingjia.setId(Generator.getUUID());
			qingjia.setUser(user);
			qingjia.setBeginTime(startTime);
			qingjia.setEndTime(endTime);
			qingjia.setReason(reason);
			qingjia.setApplyTime(new Date());
			if(user.getPost()==3){//员工
				qingjia.setApplyType(1);
			}else{
				qingjia.setApplyType(0);
			}
			baseDao.save(qingjia);
			
		}else if(absentType == 3){
			ApplyTrval chuchai = new ApplyTrval();
			chuchai.setId(Generator.getUUID());
			chuchai.setName(user.getName());
			chuchai.setAddUser(user);
			chuchai.setReason(reason);
			chuchai.setTravelDate(new Date());
			baseDao.save(chuchai);
			
			TrvalDetail detail = new TrvalDetail();
			detail.setApplyTrval(chuchai);
			detail.setOutDate(startTime);
			detail.setArriveDate(endTime);
			detail.setId(Generator.getUUID());
			baseDao.save(detail);
		}else if(absentType == 4){
			ApplyOvertime jiaban = new ApplyOvertime();
			jiaban.setId(Generator.getUUID());
			jiaban.setUser(user);
			jiaban.setBeginTime(startTime);
			jiaban.setEndTime(endTime);
			jiaban.setReason(reason);
			jiaban.setApplyTime(new Date());
			baseDao.save(jiaban);
		}
		
	}
	private List<Date> getDate(String startDate, String endDate){
		List<Date> resultList = new ArrayList();
		long startTime = DateTime.parse(startDate).toDate().getTime();
		long endTime = DateTime.parse(endDate).toDate().getTime();
		
		if(startTime == endTime) {
			resultList.add(new Date(startTime));
		} else {
			boolean flag = true;
			while (flag){
				if(startTime < endTime){
					resultList.add(new Date(startTime));
					startTime += 24 * 60 * 60 * 1000;
				} else {
					resultList.add(new Date(startTime));
					flag = false;
				}
			}
		}
		
		return resultList;
	}

	@Override
	public List<Attendance> doJoinTransFinddk(String userid) {
		String sql = "select w from Attendance w where w.user.id = :USERID";
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("USERID", userid);
		
		List<Attendance> dkList = (List<Attendance>) baseDao.findObjectList(sql, paramMap);
		
		List<Attendance> voList = new ArrayList();
		
		if(dkList != null && !dkList.isEmpty()) {
			for (Attendance dk : dkList) {
				Attendance vo = new Attendance();
				vo.setTimes(dk.getTimes());
				vo.setAttendanceTime(dk.getAttendanceTime());
				vo.setAttendanceTime2(dk.getAttendanceTime2());
				voList.add(vo);
			}
		}
		return voList;
	}
	
}
