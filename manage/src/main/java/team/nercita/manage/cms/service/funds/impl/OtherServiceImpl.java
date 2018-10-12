/*
 * OtherServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2018年1月1日 下午12:51:12
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.funds.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.projectmanage.OtherFund;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.funds.OtherService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2018年1月1日 下午12:51:12
 */
@Component
public class OtherServiceImpl extends BaseService implements OtherService {

	@Override
	public Map<String, Object> doJoinTransQueryFundsList(Integer goPage, Map<String, Object> paramMap) {
		String projectId = MapUtils.getString(paramMap, "projectId");
		String financialNumber = MapUtils.getString(paramMap, "financialNumber");
		String unit = MapUtils.getString(paramMap, "unit");
		
		String sql = "select a from OtherFund a left join fetch a.project where 1=1 ";
		String countSql = "select count(a) from OtherFund a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(projectId)){
			sql += " and a.project.id = :PROJECTID";
			countSql += " and a.project.id = :PROJECTID";
			queryMap.put("PROJECTID", projectId);
		}
		
		if(StringUtils.isNotBlank(financialNumber)){
			sql += " and a.financialNumber like :TASKNUMBER";
			countSql += " and a.financialNumber like :TASKNUMBER";
			queryMap.put("TASKNUMBER", "%" + financialNumber + "%");
		}
		if(StringUtils.isNotBlank(unit)){
			sql += " and a.unit like :UNIT";
			countSql += " and a.unit like :UNIT";
			queryMap.put("UNIT", "%" + unit + "%");
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("otherList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveOther(OtherFund otherFund) {
		otherFund.setId(Generator.getUUID());
		baseDao.save(otherFund);
	}

	@Override
	public OtherFund doJoinTransFindOtherById(String id) {
		String sql = "select p from OtherFund p left join fetch p.project where p.id = :ID";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("ID", id);
		
		return baseDao.findObject(sql, queryMap);
	}

	@Override
	public OtherFund doTransUpdateOther(OtherFund otherFund) {
		String sql = "select a from OtherFund a left join fetch a.project where a.id = :ID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("ID",otherFund.getId());
		OtherFund old =  baseDao.findObject(sql, paramMap);
		
		//审核通过后原有的经费加到原来的项目
		if(otherFund.getStatus()==1&&otherFund.getStatus()!=null){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",old.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			
			project.setTotalMoney(project.getTotalMoney()+old.getAmount());
			baseDao.update(project);
			//新选择的项目经费减少
			String psqls = "select p from Project p where p.id = :PIDS";
			Map<String,Object> proMaps = new HashMap();
			proMaps.put("PIDS",otherFund.getProject().getId());
			Project projects = baseDao.findObject(psqls,proMaps);
			projects.setTotalMoney(projects.getTotalMoney()-otherFund.getAmount());
			baseDao.update(projects);
		}
		
		return otherFund;
	}
	@Override
	public void doTransUpdateOther1(OtherFund otherFund) {
		baseDao.update(otherFund);
	}
	

	@Override
	public void doTransOther(String id, int status) {
		String sql = "select a from OtherFund a left join fetch a.project where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		OtherFund otherFund =  baseDao.findObject(sql, paramMap);
		if(status == 1){//审核通过，需要把项目总经费减去
			String sql1 = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",otherFund.getProject().getId());
			Project project = baseDao.findObject(sql1, proMap);
			
			project.setTotalMoney(project.getTotalMoney()-otherFund.getAmount());
			baseDao.update(project);
		}
		otherFund.setStatus(status);
		baseDao.update(otherFund);
		
	}

	@Override
	public OtherFund doJoinTransFindOther(String id) {
		String sql = "select r from OtherFund r left join fetch r.project where r.id = :SID";
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("SID", id);
		
		OtherFund otherFund = baseDao.findObject(sql, paramMap);
		return otherFund;
	}
	@Override
	public OtherFund doTransCommonDel(String id) {
		String asql = "select r from OtherFund r left join fetch r.project where r.id = :ID";//旧数据,applyReimbursement是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", id);
		OtherFund app = baseDao.findObject(asql, paramMap);
		
		if(app.getStatus()==1&&app.getStatus()!=null){
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
		
		String sql = "select a from OtherFund a where a.id = :ID";
		Object obj = baseDao.findObject(sql, paramMap);
		baseDao.delete(obj);
	}
}
