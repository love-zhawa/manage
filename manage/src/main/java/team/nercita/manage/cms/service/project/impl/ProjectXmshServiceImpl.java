/*
 * AssetsServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年7月26日 下午9:09:58
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.project.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.project.ProjectXmsh;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.project.ProjectXmshService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

@Component
public class ProjectXmshServiceImpl extends BaseService implements ProjectXmshService {

	@Override
	public Map<String, Object> doJoinTransProjectXmshList(Integer goPage, Map<String, Object> paramMap) {
		String projectid = MapUtils.getString(paramMap, "projectid");
		String number = MapUtils.getString(paramMap, "number");
		
		String sql = "select a from ProjectXmsh a left join fetch a.project where 1=1 ";
		String countSql = "select count(a) from ProjectXmsh a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(projectid)){
			sql += " and a.project.id = :PROJECTID";
			countSql += " and a.project.id = :PROJECTID";
			queryMap.put("PROJECTID", projectid);
		}
		
		if(StringUtils.isNotBlank(number)){
			sql += " and a.number like :NUMBER";
			countSql += " and a.number like :NUMBER";
			queryMap.put("NUMBER", "%" + number + "%");
		}
		
		sql += " order by a.bxtime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("xmshList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}
	
	@Override
	public void doTransSaveProjectXmsh(ProjectXmsh xmsh) {
		xmsh.setId(Generator.getUUID());
		baseDao.save(xmsh);
	}
	
	@Override
	public ProjectXmsh doJoinTransFindProjectXmshById(String id) {
		return baseDao.findObject(ProjectXmsh.class, id);
	}
	
	@Override
	public void doTransUpdateProjectXmsh(ProjectXmsh xmsh) {
		baseDao.update(xmsh);
	}
}
