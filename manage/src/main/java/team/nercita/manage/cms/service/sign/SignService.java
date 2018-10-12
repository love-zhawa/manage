/*
 * SignService.java
 * 创建者：侯建玮
 * 创建日期：2017年12月18日 下午3:53:37
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.service.sign;

import java.util.Date;
import java.util.List;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.sign.Attendance;

/**
 * 
 * @author 侯建玮
 * @date： 2017年12月18日 下午3:53:37
 */
public interface SignService {
	public void doTransSaveSign(User user, String addr);
	
	public void doTransSaveAbsent(User user, String reason, int absentType, Date startTime, Date endTime, String duration);
	
	public List<Attendance> doJoinTransFinddk(String userid);
}
