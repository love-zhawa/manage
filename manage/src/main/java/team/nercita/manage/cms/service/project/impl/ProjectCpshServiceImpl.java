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

import team.nercita.manage.cms.po.project.ProjectCpsh;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.project.ProjectCpshService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

@Component
public class ProjectCpshServiceImpl extends BaseService implements ProjectCpshService {

	@Override
	public Map<String, Object> doJoinTransProjectCpshList(Integer goPage, Map<String, Object> paramMap) {
		String sbname = MapUtils.getString(paramMap, "sbname");
		String sbtype = MapUtils.getString(paramMap, "sbtype");
		String sbhome = MapUtils.getString(paramMap, "sbhome");
		
		String sql = "select a from ProjectCpsh a left join fetch a.projects where 1=1 ";
		String countSql = "select count(a) from ProjectCpsh a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(sbname)){
			sql += " and a.sbname like :SBNAME";
			countSql += " and a.sbname like :SBNAME";
			queryMap.put("SBNAME", "%" + sbname + "%");
		}
		if(StringUtils.isNotBlank(sbtype)){
			sql += " and a.sbtype like :SBTYPE";
			countSql += " and a.sbtype like :SBTYPE";
			queryMap.put("SBTYPE", "%" + sbtype + "%");
		}
		if(StringUtils.isNotBlank(sbhome)){
			sql += " and a.sbhome like :SBHOME";
			countSql += " and a.sbhome like :SBHOME";
			queryMap.put("SBHOME", "%" + sbhome + "%");
		}
		
		sql += " order by a.gztime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("cpshList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}
	
	@Override
	public void doTransSaveProjectCpsh(ProjectCpsh cpsh) {
		cpsh.setId(Generator.getUUID());
		baseDao.save(cpsh);
	}
	
	@Override
	public ProjectCpsh doJoinTransFindProjectCpshById(String id) {
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("ID",id);
		String sql = "select p from ProjectCpsh p left join fetch p.projects where p.id = :ID";
		return baseDao.findObject(sql, queryMap);
	}
	
	@Override
	public void doTransUpdateProjectCpsh(ProjectCpsh cpsh) {
		baseDao.update(cpsh);
	}
}
