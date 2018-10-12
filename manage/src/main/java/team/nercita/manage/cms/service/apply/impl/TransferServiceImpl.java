/*
 * TransferServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月9日 下午8:45:57
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.form.ApplyTransfer;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.apply.TransferService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2017年8月9日 下午8:45:57
 */
@Component
public class TransferServiceImpl extends BaseService implements TransferService {

	@Override
	public Map<String, Object> doJoinTransFindApplyTransferList(Integer goPage, Map<String, Object> paramMap) {
		String use = MapUtils.getString(paramMap, "use");
		String unit = MapUtils.getString(paramMap, "unit");
		String project = MapUtils.getString(paramMap, "project");
		String status = MapUtils.getString(paramMap, "status");
		
		String sql = "select a from ApplyTransfer a left join fetch a.project where 1=1 ";
		String countSql = "select count(a) from ApplyTransfer a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(use)){
			sql += " and a.useInfo like :USE";
			countSql += " and a.useInfo like :USE";
			queryMap.put("USE", "%" + use + "%");
		}
		
		if(StringUtils.isNotBlank(status)){
			sql += " and a.status = :STATUS";
			countSql += " and a.status = :STATUS";
			queryMap.put("STATUS", Integer.parseInt(status));
		}
		
		if(StringUtils.isNotBlank(unit)){
			sql += " and a.payUnit like :UNIT";
			countSql += " and a.payUnit like :UNIT";
			queryMap.put("UNIT", "%" + unit + "%");
		}
		
		if(StringUtils.isNotBlank(project)){
			sql += " and a.project.projectName like :PROJECT";
			countSql += " and a.project.projectName like :PROJECT";
			queryMap.put("PROJECT", "%" + project + "%");
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("transferList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveApplyTransfer(ApplyTransfer applyTransfer) {
		applyTransfer.setId(Generator.getUUID());
		
		baseDao.save(applyTransfer);
	}

	@Override
	public ApplyTransfer doJoinTransFindApplyTransfer(String id) {
		String sql = "select a from ApplyTransfer a left join fetch a.project where a.id=:ID";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("ID", id);
		return baseDao.findObject(sql, queryMap);
	}

	@Override
	public ApplyTransfer doTransUpdateApplyTransfer(ApplyTransfer applyTransfer) {
		String sql = "select a from ApplyTransfer a left join fetch a.project where a.id = :ID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("ID",applyTransfer.getId());
		ApplyTransfer old =  baseDao.findObject(sql, paramMap);
		
		//审核通过后原有的经费加到原来的项目
		if(applyTransfer.getAuditStatus()==1&&applyTransfer.getAuditStatus()!=null){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",old.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			
			project.setTotalMoney(project.getTotalMoney()+old.getAmount());
			baseDao.update(project);
			//新选择的项目经费减少
			String psqls = "select p from Project p where p.id = :PIDS";
			Map<String,Object> proMaps = new HashMap();
			proMaps.put("PIDS",applyTransfer.getProject().getId());
			Project projects = baseDao.findObject(psqls,proMaps);
			projects.setTotalMoney(projects.getTotalMoney()-applyTransfer.getAmount());
			baseDao.update(projects);
		}
		return applyTransfer;
	}
	@Override
	public void doTransUpdateApplyTransfer1(ApplyTransfer applyTransfer) {
		baseDao.update(applyTransfer);
	}
	
	
	@Override
	public void doTransApplyAudit(String id, int auditStatus) {
		String sql = "select a from ApplyTransfer a left join fetch a.project where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		ApplyTransfer applyTransfer =  baseDao.findObject(sql, paramMap);
		if(auditStatus == 1){//审核通过，需要把项目总经费减去
			String sql1 = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",applyTransfer.getProject().getId());
			Project project = baseDao.findObject(sql1, proMap);
			
			project.setTotalMoney(project.getTotalMoney()-applyTransfer.getAmount());
			baseDao.update(project);
		}
		applyTransfer.setAuditStatus(auditStatus);
		baseDao.update(applyTransfer);
	}
	
	@Override
	public ApplyTransfer doTransCommonDel(String id) {
		String asql = "select r from ApplyTransfer r left join fetch r.project where r.id = :ID";//旧数据,applyReimbursement是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", id);
		ApplyTransfer app = baseDao.findObject(asql, paramMap);
		
		if(app.getAuditStatus()==1&&app.getAuditStatus()!=null){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",app.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			project.setTotalMoney(project.getTotalMoney()+app.getAmount());
			baseDao.update(project);
		}
		return null;
		
	}

	@Override
	public void doTransCommonDel1(String id) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ID", id);
		
		String sql = "select a from ApplyTransfer a where a.id = :ID";
		Object obj = baseDao.findObject(sql, paramMap);
		baseDao.delete(obj);
	}
}
