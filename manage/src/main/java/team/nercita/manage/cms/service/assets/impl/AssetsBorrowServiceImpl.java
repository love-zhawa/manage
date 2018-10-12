/*
 * AssetsServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年7月26日 下午9:09:58
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.assets.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.assets.AssetsBorrow;
import team.nercita.manage.cms.service.assets.AssetsBorrowService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

@Component
public class AssetsBorrowServiceImpl extends BaseService implements AssetsBorrowService {

	@Override
	public Map<String, Object> doJoinTransAssetsBorrowList(Integer goPage, Map<String, Object> paramMap) {
		String assetsname = MapUtils.getString(paramMap, "assetsname");
		String person = MapUtils.getString(paramMap, "person");
		String dd = MapUtils.getString(paramMap, "dd");
		
		String sql = "select a from AssetsBorrow a left join fetch a.assets where 1=1 ";
		String countSql = "select count(a) from AssetsBorrow a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(assetsname)){
			sql += " and a.assetsname like :ASSETSNAME";
			countSql += " and a.assetsname like :ASSETSNAME";
			queryMap.put("ASSETSNAME", "%" + assetsname + "%");
		}
		
		if(StringUtils.isNotBlank(person)){
			sql += " and a.person like :PERSON";
			countSql += " and a.person like :PERSON";
			queryMap.put("PERSON", "%" + person + "%");
		}
		
		if(StringUtils.isNotBlank(dd)){
			sql += " and a.dd like :DD";
			countSql += " and a.dd like :DD";
			queryMap.put("DD", "%" + dd + "%");
		}
		
		sql += " order by a.time desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("assetsList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}
	
	@Override
	public void doTransSaveAssetsBorrow(AssetsBorrow assets) {
		assets.setId(Generator.getUUID());
		baseDao.save(assets);
	}
	
	@Override
	public AssetsBorrow doJoinTransFindAssetsBorrowById(String id) {
		return baseDao.findObject(AssetsBorrow.class, id);
	}
	
	@Override
	public void doTransUpdateAssetsBorrow(AssetsBorrow assets) {
		baseDao.update(assets);
	}
}
