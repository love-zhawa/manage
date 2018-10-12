/*
 * StartUpServiceImpl.java
 * 创建者：侯建玮
 * 创建日期：2017年12月28日 下午5:05:49
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.service.project.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.project.ProjectBusniess;
import team.nercita.manage.cms.po.project.ProjectFile;
import team.nercita.manage.cms.po.project.ProjectStartup;
import team.nercita.manage.cms.po.project.StartUpDetail;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.project.StartUpService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 * 
 * @author 侯建玮
 * @date： 2017年12月28日 下午5:05:49
 */
@Component
public class StartUpServiceImpl extends BaseService implements StartUpService {

	@Override
	public Map<String, Object> doJoinTransQueryStartUp(Integer goPage, Map<String, Object> paramMap) {
		String projectid = MapUtils.getString(paramMap, "projectid");
		String bussid = MapUtils.getString(paramMap, "bussid");
		String userid = MapUtils.getString(paramMap, "userid");
		
		String sql = "select a from ProjectStartup a left join fetch a.project left join fetch a.bus left join fetch a.user where 1=1 ";
		String countSql = "select count(a) from ProjectStartup a where 1=1 ";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(bussid)){
			sql += " and a.bus.id = :BUSSID";
			countSql += " and a.bus.id = :BUSSID";
			queryMap.put("BUSSID", bussid);
		}
		if(StringUtils.isNotBlank(projectid)){
			sql += " and a.project.id = :PROJECTID";
			countSql += " and a.project.id = :PROJECTID";
			queryMap.put("PROJECTID", projectid);
		}
		
		if(StringUtils.isNotBlank(userid)){
			sql += " and a.fzr = :USERID";
			countSql += " and a.fzr = :USERID";
			queryMap.put("USERID", userid);
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("startupList",baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		return paramMap;
	}

	@Override
	public void doTransSaveProJectStartUp(ProjectStartup projectStartup, List<ProjectFile> fileList) {
		//Project project = baseDao.findObject(Project.class, projectStartup.getProject().getId());
		ProjectBusniess project = baseDao.findObject(ProjectBusniess.class, projectStartup.getBus().getId());
		
		projectStartup.setId(Generator.getUUID());
		//projectStartup.setUser(project.getUser());
		projectStartup.setFzr(project.getSalesman());
		
		for (ProjectFile projectFile : fileList) {
			projectFile.setBussId(projectStartup.getId());
			projectFile.setId(Generator.getUUID());
			
			baseDao.save(projectFile);
		}
		baseDao.save(projectStartup);
	}

	@Override
	public ProjectStartup doJoinTransFindProjectStartUpById(String id) {
		
		return baseDao.findObject(ProjectStartup.class, id);
	}

	@Override
	public void doTransSaveProjectNode(StartUpDetail startUpDetail) {
		ProjectStartup projectStartup = baseDao.findObject(ProjectStartup.class, startUpDetail.getProjectStartup().getId());
		projectStartup.setLastProgress(startUpDetail.getLastProgress());
		baseDao.update(projectStartup);
		
		startUpDetail.setId(Generator.getUUID());
		baseDao.save(startUpDetail);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void doTransUpdateProjectStartUp(ProjectStartup projectStartup, List<ProjectFile> fileList) {
		//Project project = baseDao.findObject(Project.class, projectStartup.getProject().getId());
		ProjectBusniess project = baseDao.findObject(ProjectBusniess.class, projectStartup.getBus().getId());
		
		//projectStartup.setUser(project.getUser());
		projectStartup.setFzr(project.getSalesman());
		
		baseDao.update(projectStartup);
		
		if(fileList != null && !fileList.isEmpty()) {
			String sql = "select p from ProjectFile p where p.bussId = :BUSSID";
			
			Map<String, Object> queryMap = new HashMap<String, Object>();
			queryMap.put("BUSSID", projectStartup.getId());
			
			List<ProjectFile> oldFileList = (List<ProjectFile>) baseDao.findObjectList(sql, queryMap);
			
			if(oldFileList != null && !oldFileList.isEmpty()) {
				for (ProjectFile projectFile : oldFileList) {
					baseDao.delete(projectFile);
				}
			}
			
			for (ProjectFile projectFile : fileList) {
				projectFile.setBussId(projectStartup.getId());
				projectFile.setId(Generator.getUUID());
				
				baseDao.save(projectFile);
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void doTransDelStartup(String id) {
		ProjectStartup projectStartup = baseDao.findObject(ProjectStartup.class, id);
		
		String sql = "select s from StartUpDetail s where s.projectStartup.id = :STARTUPID";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("STARTUPID", projectStartup.getId());
		
		List<StartUpDetail> detailList = (List<StartUpDetail>) baseDao.findObjectList(sql, queryMap);
		
		if(detailList!=null && !detailList.isEmpty()) {
			for (StartUpDetail startUpDetail : detailList) {
				baseDao.delete(startUpDetail);
			}
		}
		
		sql = "select p from ProjectFile p where p.bussId = :BUSSID";
		
		queryMap.clear();
		queryMap.put("BUSSID", projectStartup.getId());
		
		List<ProjectFile> oldFileList = (List<ProjectFile>) baseDao.findObjectList(sql, queryMap);
		
		if(oldFileList != null && !oldFileList.isEmpty()) {
			for (ProjectFile projectFile : oldFileList) {
				baseDao.delete(projectFile);
			}
		}
		
		baseDao.delete(projectStartup);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<StartUpDetail> doJoinTransFindDetailList(String id) {
		
		String sql = "select p from StartUpDetail p where p.projectStartup.id = :BUSSID order by p.noteDate desc";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("BUSSID", id);
		return (List<StartUpDetail>) baseDao.findObjectList(sql, queryMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ProjectFile> doJoinTransFindFileList(String id) {
		String sql = "select p from ProjectFile p where p.bussId = :BUSSID";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("BUSSID", id);
		
		List<ProjectFile> FileList = (List<ProjectFile>) baseDao.findObjectList(sql, queryMap);
		return FileList;
	}

	@Override
	public List<ProjectStartup> doJoinTransQueryStartup() {
		String sql = "select max(id),max(fzr) from ProjectStartup group by fzr having count(fzr)>=1";
		return (List<ProjectStartup>) baseDao.findObjectList(sql, null);
	}

}
