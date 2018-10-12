/*
 * TrvalService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月8日 上午11:33:01
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply;

import java.util.Date;
import java.util.List;
import java.util.Map;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyTrval;

/**
 *
 * @author 侯建玮
 * @date 2017年11月8日 上午11:33:01
 */
public interface TrvalService {
	public Map<String, Object> doJoinTransFindApplyTrvalList(Integer goPage, Map<String, Object> paramMap);
	 
	 public void doTransSaveApplyTrval(ApplyTrval applyTrval, User user);
	 
	 public ApplyTrval doJoinTransFindApplyTrval(String id);
	 
	 public ApplyTrval doJoinTransFindApplyTrvalById(String id);
	 
	 public ApplyTrval doTransUpdateApplyTrval(ApplyTrval applyTrval, User user);//修改
	 public void doTransUpdateApplyTrval1(ApplyTrval applyTrval, User user);//审核通过的修改
	 public void doTransUpdateApplyTrval2(ApplyTrval applyTrval, User user);//在线填报修改
	 
	 public void doTransApplyAudit(String id, int status);
	 
	 public ApplyTrval doTransCommonDel(String id);
	 public void doTransCommonDel1(String id);
	 
	 List<ApplyTrval> doJoinTransTrval(Date date,String userid);
}
