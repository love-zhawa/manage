/*
 * ExpertFeeService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月8日 上午11:33:01
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply;

import java.util.Map;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyExpertFee;

/**
 *
 * @author 侯建玮
 * @date 2017年11月8日 上午11:33:01
 */
public interface ExpertFeeService {
	public Map<String, Object> doJoinTransFindApplyExpertFeeList(Integer goPage, Map<String, Object> paramMap);
	 
	 public void doTransSaveApplyExpertFee(ApplyExpertFee applyExpertFee, User user);
	 public void doTransSaveApplyExpertFee1(ApplyExpertFee applyExpertFee, User user);
	 
	 public ApplyExpertFee doJoinTransFindApplyExpertFee(String id);
	 public Map<String, Object> doJoinTransFindApplyExpertFees(String id);
	 
	 public ApplyExpertFee doJoinTransFindApplyExpertFeeById(String id);
	 
	 public ApplyExpertFee doTransUpdateApplyExpertFee(ApplyExpertFee applyExpertFee, User user);
	 public void doTransUpdateApplyExpertFee1(ApplyExpertFee applyExpertFee, User user);
	 public void doTransUpdateApplyExpertFee2(ApplyExpertFee applyExpertFee, User user);
	 
	 public void doTransApplyAudit(String id, int status);
	 
	 public ApplyExpertFee doTransCommonDel(String id);
	 public void doTransCommonDel1(String id);
}
