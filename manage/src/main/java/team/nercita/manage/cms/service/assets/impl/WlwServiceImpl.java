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

import team.nercita.manage.cms.po.assets.wlw;
import team.nercita.manage.cms.service.assets.WlwService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

@Component
public class WlwServiceImpl extends BaseService implements WlwService {

	@Override
	public Map<String, Object> doJoinTranswlwList(Integer goPage, Map<String, Object> paramMap) {
		String sim = MapUtils.getString(paramMap, "sim");
		String cgperson = MapUtils.getString(paramMap, "cgperson");
		String dd = MapUtils.getString(paramMap, "dd");
		
		String sql = "select a from wlw a where 1=1 ";
		String countSql = "select count(a) from wlw a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(sim)){
			sql += " and a.sim like :SIM";
			countSql += " and a.sim like :SIM";
			queryMap.put("SIM", "%" + sim + "%");
		}
		
		if(StringUtils.isNotBlank(cgperson)){
			sql += " and a.cgperson like :CGPERSON";
			countSql += " and a.cgperson like :CGPERSON";
			queryMap.put("CGPERSON", "%" + cgperson + "%");
		}
		
		if(StringUtils.isNotBlank(dd)){
			sql += " and a.dd like :DD";
			countSql += " and a.dd like :DD";
			queryMap.put("DD", "%" + dd + "%");
		}
		
	//	sql += " order by a.time desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("wlwlist", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}
	
	@Override
	public void doTransSavewlw(wlw wlw) {
		wlw.setId(Generator.getUUID());
		baseDao.save(wlw);
	}
	
	@Override
	public wlw doJoinTransFindwlwById(String id) {
		return baseDao.findObject(wlw.class, id);
	}
	
	@Override
	public void doTransUpdatewlw(wlw wlw) {
		baseDao.update(wlw);
	}
}
