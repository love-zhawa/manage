/*
 * AttendanceServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年7月16日 下午8:38:50
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.usermanage.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.AttendanceGroup;
import team.nercita.manage.cms.po.deptmanage.AttendanceSet;
import team.nercita.manage.cms.po.deptmanage.AttendanceStat;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.sign.Attendance;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.usermanage.AttendanceService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;
import team.nercita.manage.cms.vo.AbsentVo;
import team.nercita.manage.cms.vo.AttendanceVo;

/**
 *
 * @author 侯建玮
 * @date 2017年7月16日 下午8:38:50
 */
@Component
public class AttendanceServiceImpl extends BaseService implements AttendanceService {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	@SuppressWarnings("unchecked")
	@Override
	public List<AbsentVo> doJoinTransFindAbsent(Date date) {

		String sql = "select count(a) from AttendanceGroup a where a.user.useStatus = :USESTATUS";
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("USESTATUS", User.UseStatus.normal.getValue());
		
		int count = baseDao.queryObjectCount(sql, paramMap);
		
		if(count == 0) {
			return null;
		}
		
		sql = "select count(a) from AttendanceStat a where a.statTime = :NOWDATE";
		
		paramMap.clear();
		paramMap.put("NOWDATE", date);
		
		int num = baseDao.queryObjectCount(sql, paramMap);
		
		List<AbsentVo> voList = new ArrayList();
		
		List<AttendanceGroup> groupList = doJoinTransQueryGroup();
		
		if(num == 0) {
			for (AttendanceGroup group : groupList) {
				AbsentVo vo = new AbsentVo();
				vo.setUsername(group.getUser().getName());
				vo.setReason("未打卡");
				voList.add(vo);
			}
			return voList;
		}
		
		sql = "select a from AttendanceStat a left join fetch a.user where a.statTime = :NOWDATE";
		
		List<AttendanceStat> statList = (List<AttendanceStat>) baseDao.findObjectList(sql, paramMap);
		Map<String, String> alMap = new HashMap();
		
		for (AttendanceStat attendanceStat : statList) {
			alMap.put(attendanceStat.getUser().getId(), attendanceStat.getUser().getName());
			AbsentVo vo = new AbsentVo();
			vo.setUsername(attendanceStat.getUser().getName());
			
			if(attendanceStat.getZaodaka() != null && 1 == attendanceStat.getZaodaka()) {
				vo.setReason("异常");
			}
			
			if(attendanceStat.getQingjia() != null && 1 == attendanceStat.getQingjia()) {
				vo.setReason("请假");
			}
			if(attendanceStat.getWaichu() != null && 1 == attendanceStat.getWaichu()) {
				vo.setReason("外出");
			}
			if(attendanceStat.getChuchai() != null && 1 == attendanceStat.getChuchai()) {
				vo.setReason("出差");
			}
			if(StringUtils.isNotBlank(vo.getReason())) {
				voList.add(vo);
			}
		}
		
		for (AttendanceGroup attendanceGroup : groupList) {
			if(!alMap.containsKey(attendanceGroup.getUser().getId())){
				AbsentVo vo = new AbsentVo();
				vo.setUsername(attendanceGroup.getUser().getName());
				vo.setReason("未打卡");
				voList.add(vo);
			}
		}
		
		return voList;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AttendanceStat> doJoinTransFindStat(Date date) {
		String sql = "select a from AttendanceStat a left join fetch a.user where a.statTime = :STATTIME";
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("STATTIME", date);
		
		return (List<AttendanceStat>) baseDao.findObjectList(sql, paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AttendanceGroup> doJoinTransQueryGroup() {
		String sql = "select a from AttendanceGroup a left join fetch a.user where a.user.useStatus = :USERSTATUS";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("USERSTATUS", User.UseStatus.normal.getValue());
		
		return (List<AttendanceGroup>) baseDao.findObjectList(sql, queryMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void doTransAttendanceSet(AttendanceSet attendanceSet, String ids) {
		AttendanceSet set =  doJoinTransAttendanceSet();
		if(set == null) {
			attendanceSet.setId(Generator.getUUID());
			baseDao.save(attendanceSet);
		} else {
			set.setStartTime(attendanceSet.getStartTime());
			set.setEndTime(attendanceSet.getEndTime());
			set.setLunchStartTime(attendanceSet.getLunchStartTime());
			set.setLunchEndTime(attendanceSet.getLunchEndTime());
			baseDao.update(set);
			attendanceSet = set;
		}
		
		String sql = "select a from  AttendanceGroup a ";
		
		List<AttendanceGroup> groupList = (List<AttendanceGroup>) baseDao.findObjectList(sql, null);
		
		if(groupList !=null && !groupList.isEmpty()) {
			for (AttendanceGroup attendanceGroup : groupList) {
				baseDao.delete(attendanceGroup);
			}
		}
		
		String[] idarr = ids.split(",");
		
		if(idarr != null && idarr.length >0) {
			for (int i = 0; i < idarr.length; i++) {
				if(StringUtils.isNotBlank(idarr[i])) {
					AttendanceGroup group = new AttendanceGroup();
					group.setId(Generator.getUUID());
					group.setAttendanceSet(attendanceSet);
					group.setUser(new User(idarr[i]));
					
					baseDao.save(group);
				}
			}
		}
	}
	
	@Override
	public AttendanceSet doJoinTransAttendanceSet() {
		String sql = "select a from AttendanceSet a ";
		return baseDao.findObject(sql, null);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AttendanceVo> doJoinTransCurrStat(Date date) {
		String sql = "select count(a) from AttendanceGroup a where a.user.useStatus = :USESTATUS";
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("USESTATUS", User.UseStatus.normal.getValue());
		
		int count = baseDao.queryObjectCount(sql, paramMap);
		
		if(count == 0) {
			return null;
		}
		
		sql = "select count(a) from AttendanceStat a where a.statTime = :NOWDATE";
		
		paramMap.clear();
		paramMap.put("NOWDATE", date);
		
		int num = baseDao.queryObjectCount(sql, paramMap);
		
		List<AttendanceVo> voList = new ArrayList();
		
		if(num == 0) {
			AttendanceVo vo = new AttendanceVo();
			vo.setCount(count);
			vo.setName("未打卡");
			voList.add(vo);
			
			return voList;
		}
		
		if(count > num) {
			AttendanceVo vo = new AttendanceVo();
			vo.setCount(count - num);
			vo.setName("未打卡");
			voList.add(vo);
		}
		
		sql = "select a from AttendanceStat a where a.statTime = :NOWDATE";
		
		List<AttendanceStat> statList = (List<AttendanceStat>) baseDao.findObjectList(sql, paramMap);
		
		int dakazhengc = 0;
		int dakayic = 0 ;
		int qingjia = 0;
		int waichu = 0;
		int chuchai = 0;
		int jiaban = 0;
		
		for (AttendanceStat attendanceStat : statList) {
			if(attendanceStat.getZaodaka() != null && 0 == attendanceStat.getZaodaka()) {
				dakazhengc += 1;
			} else if(attendanceStat.getZaodaka() != null && 1 == attendanceStat.getZaodaka()) {
				dakayic += 1;
			}
			
			if(attendanceStat.getQingjia() != null && 1 == attendanceStat.getQingjia()) {
				qingjia += 1;
			}
			if(attendanceStat.getWaichu() != null && 1 == attendanceStat.getWaichu()) {
				waichu += 1;
			}
			if(attendanceStat.getChuchai() != null && 1 == attendanceStat.getChuchai()) {
				chuchai += 1;
			}
			if(attendanceStat.getJiaban() != null && 1 == attendanceStat.getJiaban()) {
				jiaban += 1;
			}
		}
		if(dakazhengc != 0) {
			AttendanceVo zc = new AttendanceVo();
			zc.setCount(dakazhengc);
			zc.setName("正常");
			voList.add(zc);
		}
		if(dakayic != 0) {
			AttendanceVo yc = new AttendanceVo();
			yc.setCount(dakayic);
			yc.setName("异常");
			voList.add(yc);
		}
		
		if(qingjia != 0) {
			AttendanceVo qj = new AttendanceVo();
			qj.setCount(qingjia);
			qj.setName("请假");
			voList.add(qj);
		}
		if(waichu != 0) {
			AttendanceVo wc = new AttendanceVo();
			wc.setCount(waichu);
			wc.setName("外出");
			voList.add(wc);
		}
		if(chuchai != 0) {
			AttendanceVo cc = new AttendanceVo();
			cc.setCount(chuchai);
			cc.setName("出差");
			voList.add(cc);
		}
		if(jiaban != 0) {
			AttendanceVo jb = new AttendanceVo();
			jb.setCount(jiaban);
			jb.setName("加班");
			voList.add(jb);
		}
		
		return voList;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AttendanceVo> doJoinTransCurrYestoday(Date date) {
		String sql = "select count(a) from AttendanceGroup a where a.user.useStatus = :USESTATUS";
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("USESTATUS", User.UseStatus.normal.getValue());
		
		int count = baseDao.queryObjectCount(sql, paramMap);
		
		if(count == 0) {
			return null;
		}
		
		
		paramMap.clear();
		paramMap.put("NOWDATE", date);
		
		List<AttendanceVo> voList = new ArrayList();
		sql = "select a from AttendanceStat a where a.statTime = :NOWDATE";
		
		List<AttendanceStat> statList = (List<AttendanceStat>) baseDao.findObjectList(sql, paramMap);
		
		int dakazhengc = 0;
		int dakayic = 0 ;
		int qingjia = 0;
		int waichu = 0;
		int chuchai = 0;
		int jiaban = 0;
		int kuangg = 0;
		int dakawanzc = 0;
		int dakawanyc = 0;
		
		for (AttendanceStat attendanceStat : statList) {
			if(attendanceStat.getZaodaka() != null && 0 == attendanceStat.getZaodaka()) {
				dakazhengc += 1;
			} else if(attendanceStat.getZaodaka() != null && 1 == attendanceStat.getZaodaka()) {
				dakayic += 1;
			}
			
			if(attendanceStat.getWandaka() != null && 0 == attendanceStat.getWandaka()) {
				dakawanzc += 1;
			} else if(attendanceStat.getWandaka() != null && 1 == attendanceStat.getWandaka()) {
				dakawanyc += 1;
			}
			
			if(attendanceStat.getQingjia() != null && 1 == attendanceStat.getQingjia()) {
				qingjia += 1;
			}
			if(attendanceStat.getWaichu() != null && 1 == attendanceStat.getWaichu()) {
				waichu += 1;
			}
			if(attendanceStat.getChuchai() != null && 1 == attendanceStat.getChuchai()) {
				chuchai += 1;
			}
			if(attendanceStat.getJiaban() != null && 1 == attendanceStat.getJiaban()) {
				jiaban += 1;
			}
			
			if(attendanceStat.getKuanggong() != null && 1 == attendanceStat.getKuanggong()) {
				kuangg += 1;
			}
		}
		if(dakazhengc != 0) {
			AttendanceVo zc = new AttendanceVo();
			zc.setCount(dakazhengc);
			zc.setName("早正常");
			voList.add(zc);
		}
		if(dakayic != 0) {
			AttendanceVo yc = new AttendanceVo();
			yc.setCount(dakayic);
			yc.setName("早异常");
			voList.add(yc);
		}
		
		if(qingjia != 0) {
			AttendanceVo qj = new AttendanceVo();
			qj.setCount(qingjia);
			qj.setName("请假");
			voList.add(qj);
		}
		if(waichu != 0) {
			AttendanceVo wc = new AttendanceVo();
			wc.setCount(waichu);
			wc.setName("外出");
			voList.add(wc);
		}
		if(chuchai != 0) {
			AttendanceVo cc = new AttendanceVo();
			cc.setCount(chuchai);
			cc.setName("出差");
			voList.add(cc);
		}
		
		if(dakawanzc != 0) {
			AttendanceVo wdk = new AttendanceVo();
			wdk.setCount(dakawanzc);
			wdk.setName("晚正常");
			voList.add(wdk);
		}
		
		if(dakawanyc != 0) {
			AttendanceVo wdk = new AttendanceVo();
			wdk.setCount(dakawanyc);
			wdk.setName("晚异常");
			voList.add(wdk);
		}
		
		if(kuangg != 0) {
			AttendanceVo kg = new AttendanceVo();
			kg.setCount(kuangg);
			kg.setName("旷工");
			voList.add(kg);
		}
		
		
		if(jiaban != 0) {
			AttendanceVo jb = new AttendanceVo();
			jb.setCount(jiaban);
			jb.setName("加班");
			voList.add(jb);
		}
		
		return voList;
	}

	@Override
	public List<Attendance> doJoinTransAtt(Date date,User user) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from Attendance a left join fetch a.user where a.user.id = :USERID and a.dkTime = :NOWDATE order by a.times asc";
		
		paramMap.put("USERID", user.getId());
		paramMap.put("NOWDATE", date);
		List<Attendance> lists = (List<Attendance>) baseDao.findObjectList(sql, paramMap);
		
		return lists;
	}

	@Override
	public List<Attendance> doJoinTransAtts(Date date) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map<String, Object> paramMap1 = new HashMap<String, Object>();
		List<Attendance> lists = new ArrayList<Attendance>();
		paramMap.put("STATUS", 1);
		String sql = "select u from User u where u.status = :STATUS";
		List<User> userlist = (List<User>) baseDao.findObjectList(sql, paramMap);
		if(userlist.size()>0){
			for (int i = 0; i < userlist.size(); i++) {
				paramMap1.put("NOWDATE", date);
				paramMap1.put("USERID",userlist.get(i).getId());
				String sql1 = "select a from Attendance a left join fetch a.user where a.user.id = :USERID and a.dkTime = :NOWDATE";
				Attendance att = baseDao.findObject(sql1, paramMap1);
				if(att!=null&&!att.equals("")){
					lists.add(att);
				}else{
					Attendance atts = new Attendance();
					atts.setUser(userlist.get(i));
					String time = "3000-01-01";
					try {
						atts.setAttendanceTime(sdf.parse(time));
					} catch (ParseException e) {
						e.printStackTrace();
					}
					lists.add(atts);
				}
				Collections.sort(lists, new Comparator<Attendance>(){   
					@Override       
					public int compare(Attendance arg0, Attendance arg1) {
						int mark = 1;	   
						Date date0 = arg0.getAttendanceTime();
						Date date1 = arg1.getAttendanceTime();
						if(date0.getTime() < date1.getTime()){    
							mark =  -1;
						}
						if(arg0.getAttendanceTime().equals(arg1.getAttendanceTime())){
							mark =  0;
						}
						return mark;
					}
				});
			}
		}
		return lists;
	}

	
	@Override
	public List<Attendance> doJoinTransAtt(Date date,String userid) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from Attendance a left join fetch a.user where a.user.id = :USERID and a.dkTime = :NOWDATE order by a.attendanceTime,a.attendanceTime2";
		paramMap.put("USERID", userid);
		paramMap.put("NOWDATE", date);
		List<Attendance> lists = (List<Attendance>) baseDao.findObjectList(sql, paramMap);
		
		return lists;
	}

	@Override
	public int doJoinTransFindTs(String userid,Date bztime) {
		Map<String,Object> paramMap = new HashMap();
		Date begintime = null;
		Date endtime = null;
		
		try {
			begintime = subMonth(bztime);//开始时间
			endtime = endtime(bztime);//结束时间
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String sql = "select count(*) from Attendance a,workingcalendar w where w.status = :ZT and a.user.id = :USERID and a.dkTime <= :ENDTIME and a.dkTime >= :BEGINTIME and a.dkTime = w.time";
		paramMap.put("ZT", 1);
		paramMap.put("USERID", userid);
		paramMap.put("BEGINTIME", begintime);
		paramMap.put("ENDTIME",endtime);
		int ts = baseDao.queryObjectCount(sql, paramMap);
		return ts;
	}
	
	
	/**** 
     * 传入具体日期 ，返回具体日期减一个月。 上个月19号
     * @throws ParseException 
     */  
    private Date subMonth(Date date) throws ParseException {  
        Calendar rightNow = Calendar.getInstance();  
        rightNow.setTime(date);  
        rightNow.add(Calendar.MONTH, -1);
        rightNow.add(Calendar.DATE, 18);//加18天,19号
        Date dt1 = rightNow.getTime();  
        return dt1;  
    }
    private Date endtime(Date date) throws ParseException {  
        Calendar rightNow = Calendar.getInstance();  
        rightNow.setTime(date);  
        rightNow.add(Calendar.DATE, 17);//加17天,这月18号
        Date dt1 = rightNow.getTime();  
        return dt1;  
    }
	/*@Override
	public Map<String, Object> doJoinTransFindStats(Integer goPage,Map<String, Object> paramMap) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String startTime = MapUtils.getString(paramMap, "startTime");
		
		String sql = "select a from AttendanceStat a left join fetch a.user where 1=1 ";
		String countSql = "select count(a) from AttendanceStat a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(startTime)){
			sql += " and a.startTime = :ASSETSNAME";
			countSql += " and a.startTime = :STATTIME";
			try {
				queryMap.put("STATTIME",sdf.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("dklist", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		return paramMap;
	}*/
}
