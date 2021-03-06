/*
 * LeaveServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月6日 下午3:39:08
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyLeave;
import team.nercita.manage.cms.po.sign.Attendance;
import team.nercita.manage.cms.service.apply.LeaveService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2017年8月6日 下午3:39:08
 */
@Component
public class LeaveServiceImpl extends BaseService implements LeaveService {
	static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	static SimpleDateFormat sdf = new SimpleDateFormat("yyyy,MM,dd");
	@Override
	public Map<String, Object> doJoinTransFindApplyLeaveList(Integer goPage, Map<String, Object> paramMap) {
		String userName = MapUtils.getString(paramMap, "userName");
		Integer applyType = MapUtils.getInteger(paramMap, "applyType");
		String sql = "select a from ApplyLeave a left join fetch a.user where 1=1 ";
		String countSql = "select count(a) from ApplyLeave a  where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		//申请管理普通用户只能看自己的
		if(user.getPost()==2 || user.getPost()==3){
			sql += " and a.user.id = :USERID";
			countSql += " and a.user.id = :USERID";
			queryMap.put("USERID", user.getId());
		}
		if(StringUtils.isNotBlank(userName)){
			sql += " and a.user.name like :USERNAME";
			countSql += " and a.user.name like :USERNAME";
			queryMap.put("USERNAME", "%" + userName + "%");
		}
		
		if (applyType != null) {
			sql += " and a.applyType = :APPLYTYPE";
			countSql += " and a.applyType = :APPLYTYPE";
			queryMap.put("APPLYTYPE", applyType);
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("leaveList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveApplyLeave(ApplyLeave applyLeave) {
		applyLeave.setId(Generator.getUUID());
		String begin = sdf.format(applyLeave.getBeginTime()).toString();
		String end = sdf.format(applyLeave.getEndTime()).toString();
		Date calr1;
		Date calr2;
		try {
			calr1 = sdf.parse(begin);
			calr2 = sdf.parse(end);
			Long n=calr2.getTime()-calr1.getTime();
			int a=(int)(n/(1000*60*60*24));
			applyLeave.setTs(a);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		baseDao.save(applyLeave);
	}
	
	@Override
	public ApplyLeave doJoinTransFindApplyLeave(String id) {
		ApplyLeave Leave = baseDao.findObject(ApplyLeave.class, id);
		Leave.getUser().getName();
		
		return Leave;
	}

	@Override
	public void doTransUpdateApplyLeave(ApplyLeave applyLeave) {
		String begin = sdf.format(applyLeave.getBeginTime()).toString();
		String end = sdf.format(applyLeave.getEndTime()).toString();
		Date calr1;
		Date calr2;
		try {
			calr1 = sdf.parse(begin);
			calr2 = sdf.parse(end);
			Long n=calr2.getTime()-calr1.getTime();
			int a=(int)(n/(1000*60*60*24));
			applyLeave.setTs(a);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		baseDao.update(applyLeave);
	}
	
	@Override
	public List<ApplyLeave> doJoinTransLeave(Date date, String userid) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from ApplyLeave a left join fetch a.user where a.user.id = :USERID and a.beginTime <= :NOWDATE and a.endTime >= :NOWDATE";
		paramMap.put("USERID", userid);
		paramMap.put("NOWDATE", date);
		List<ApplyLeave> lists = (List<ApplyLeave>) baseDao.findObjectList(sql, paramMap);
		
		return lists;
	}

	@Override
	public List<ApplyLeave> doJoinTransFindTs(String userid, Date begin, Date end) {
		Map<String,Object> paramMap = new HashMap();
		String sql = "select a from ApplyLeave a where a.user.id = :USERID and a.applyTime <= :ENDTIME and a.applyTime >= :BEGINTIME";
		paramMap.put("USERID", userid);
		paramMap.put("BEGINTIME", begin);
		paramMap.put("ENDTIME",end);
		List<ApplyLeave> lists = (List<ApplyLeave>) baseDao.findObjectList(sql, paramMap);
		return lists;
	}
	
}
