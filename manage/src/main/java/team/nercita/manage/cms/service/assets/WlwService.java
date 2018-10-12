/*
 * AssetsBorrowService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年7月26日 下午9:06:49
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.assets;

import java.util.Map;

import team.nercita.manage.cms.po.assets.wlw;
public interface WlwService {
	
	public Map<String, Object> doJoinTranswlwList(Integer goPage, Map<String, Object> paramMap);
	
	public void doTransSavewlw(wlw wlw);
	
	public void doTransUpdatewlw(wlw wlw);
	
	public wlw doJoinTransFindwlwById(String id);
}
