/*
 * OvertimeService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月13日 上午10:29:48
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply;

import java.util.Date;
import java.util.List;
import java.util.Map;

import team.nercita.manage.cms.po.form.ApplyOvertime;

/**
 * 加班service
 * @author 侯建玮
 * @date 2017年8月13日 上午10:29:48
 */
public interface OvertimeService {
	public Map<String, Object> doJoinTransFindApplyOvertimeList(Integer goPage, Map<String, Object> paramMap);
	 
	public void doTransSaveApplyOvertime(ApplyOvertime applyOvertime);

	public ApplyOvertime doJoinTransFindApplyOvertime(String id);
	 
	public void doTransUpdateApplyOvertime(ApplyOvertime applyOvertime);
	
	 List<ApplyOvertime> doJoinTransOvertime(Date date,String userid);
}
