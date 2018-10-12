/*
 * DialOutService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2018年1月1日 下午12:48:49
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.funds;

import java.util.Map;

import team.nercita.manage.cms.po.projectmanage.DialOutFund;

/**
 *
 * @author 侯建玮
 * @date 2018年1月1日 下午12:48:49
 */
public interface DialOutService {
	public Map<String, Object> doJoinTransQueryFundsList(Integer goPage, Map<String, Object> paramMap);
	
	public void doTransSaveDialOut(DialOutFund dialOutFund);
	
	public DialOutFund doJoinTransFindDialOutById(String id);
	//修改
	public DialOutFund doTransUpdateDialOut(DialOutFund dialOutFund);
	public void doTransUpdateDialOut1(DialOutFund dialOutFund);
	//审核
	public void doTransDialOut(String id, int status);
	public DialOutFund doJoinTransFindDialOut(String id);
	//删除
	public DialOutFund doTransCommonDel(String id);
	public void doTransCommonDel1(String id);
}
