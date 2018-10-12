/*
 * RemunerationService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月8日 上午11:33:01
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply;

import java.util.Map;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyRemuneration;

/**
 *
 * @author 侯建玮
 * @date 2017年11月8日 上午11:33:01
 */
public interface RemunerationService {
	public Map<String, Object> doJoinTransFindApplyRemunerationList(Integer goPage, Map<String, Object> paramMap);
	 
	 public void doTransSaveApplyRemuneration(ApplyRemuneration applyRemuneration, User user);
	 
	 public ApplyRemuneration doJoinTransFindApplyRemuneration(String id);
	 public Map<String, Object> doJoinTransFindApplyRemunerations(String id);
	 
	 public ApplyRemuneration doJoinTransFindApplyRemunerationById(String id);
	 
	 public ApplyRemuneration doTransUpdateApplyRemuneration(ApplyRemuneration applyRemuneration, User user);
	 public void doTransUpdateApplyRemuneration1(ApplyRemuneration applyRemuneration, User user);
	 
	 public void doTransApplyAudit(String id, int status);
	 
	 
	 public ApplyRemuneration doTransCommonDel(String id);
	 public void doTransCommonDel1(String id);
}
