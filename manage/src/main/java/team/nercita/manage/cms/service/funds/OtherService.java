/*
 * OtherService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2018年1月1日 下午12:48:49
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.funds;

import java.util.Map;

import team.nercita.manage.cms.po.projectmanage.DialOutFund;
import team.nercita.manage.cms.po.projectmanage.OtherFund;

/**
 *
 * @author 侯建玮
 * @date 2018年1月1日 下午12:48:49
 */
public interface OtherService {
	public Map<String, Object> doJoinTransQueryFundsList(Integer goPage, Map<String, Object> paramMap);
	
	public void doTransSaveOther(OtherFund OtherFund);
	
	public OtherFund doJoinTransFindOtherById(String id);
	
	public OtherFund doTransUpdateOther(OtherFund OtherFund);
	public void doTransUpdateOther1(OtherFund OtherFund);
	
	public void doTransOther(String id, int status);
	public OtherFund doJoinTransFindOther(String id);
	
	public OtherFund doTransCommonDel(String id);
	public void doTransCommonDel1(String id);
}
