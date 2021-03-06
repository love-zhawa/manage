/*
 * UseCardService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月6日 下午12:13:46
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply;

import java.util.Date;
import java.util.List;
import java.util.Map;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyLeave;

/**
 *
 * @author 侯建玮
 * @date 2017年8月6日 下午12:13:46
 */
public interface LeaveService {
	 public Map<String, Object> doJoinTransFindApplyLeaveList(Integer goPage, Map<String, Object> paramMap);
	 
	 public void doTransSaveApplyLeave(ApplyLeave applyLeave);
	 
	 public ApplyLeave doJoinTransFindApplyLeave(String id);
	 
	 public void doTransUpdateApplyLeave(ApplyLeave applyLeave);
	 
	 List<ApplyLeave> doJoinTransLeave(Date date,String userid);
	 
	 public List<ApplyLeave> doJoinTransFindTs(String userid,Date begin,Date end);//请假天数
}
