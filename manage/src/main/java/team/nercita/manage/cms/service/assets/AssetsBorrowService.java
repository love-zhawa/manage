/*
 * AssetsBorrowService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年7月26日 下午9:06:49
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.assets;

import java.util.Map;

import team.nercita.manage.cms.po.assets.AssetsBorrow;

/**
 *
 * @author 侯建玮
 * @date 2017年7月26日 下午9:06:49
 */
public interface AssetsBorrowService {
	/**
	 * 查询固定资产  借用记录
	 * @param goPage
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> doJoinTransAssetsBorrowList(Integer goPage, Map<String, Object> paramMap);
	
	/**
	 * 保存固定资产
	 * @param ProjectXmsh
	 */
	public void doTransSaveAssetsBorrow(AssetsBorrow assets);
	
	/**
	 * 修改固定资产
	 * @param ProjectXmsh
	 */
	public void doTransUpdateAssetsBorrow(AssetsBorrow assets);
	
	/**
	 * 查询固定资产
	 * @param id
	 * @return
	 */
	public AssetsBorrow doJoinTransFindAssetsBorrowById(String id);
}
