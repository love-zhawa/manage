/*
 * FundsServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月26日 上午11:14:58
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.funds.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.finance.FundsIncome;
import team.nercita.manage.cms.po.projectmanage.DialOutFund;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.funds.FundsService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 * 经费到账情况
 * @author 侯建玮
 * @date 2017年11月26日 上午11:14:58
 */
@Component
public class FundsServiceImpl extends BaseService implements FundsService {
	@Override
	public Map<String, Object> doJoinTransQueryFundsList(Integer goPage, Map<String, Object> paramMap) {
		String projectId = MapUtils.getString(paramMap, "projectId");
		String financialNumber = MapUtils.getString(paramMap, "financialNumber");
		
		String sql = "select a from FundsIncome a left join fetch a.project where 1=1 ";
		String countSql = "select count(a) from FundsIncome a where 1=1";
		
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
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("fundsList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}
	
	@Override
	public FundsIncome doJoinTransFindFundsIncomeById(String id) {
		String sql = "select p from FundsIncome p left join fetch p.project where p.id = :ID";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("ID", id);
		
		return baseDao.findObject(sql, queryMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void doTransSaveFundsIncome(FundsIncome fundsIncome) {
		/*String sql = "select f from FundsIncome f where f.project.id = :PROJECTID";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("PROJECTID", fundsIncome.getProject().getId());
		
		List<FundsIncome> fundsList = (List<FundsIncome>) baseDao.findObjectList(sql, queryMap);
		
		Double incomeAmount = 0.00;
		
		if(fundsList != null && !fundsList.isEmpty()) {
			for (FundsIncome funds : fundsList) {
				incomeAmount += funds.getAmount();
			}
		}
		incomeAmount += fundsIncome.getAmount();
		
		for (FundsIncome funds : fundsList) {
			funds.setIncomeAmount(Double.valueOf(incomeAmount));
			baseDao.update(funds);
		}
		
		fundsIncome.setIncomeAmount(Double.valueOf(incomeAmount));*/
		fundsIncome.setId(Generator.getUUID());
		
		baseDao.save(fundsIncome);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void doTransUpdateFundsIncome(FundsIncome fundsIncome) {
		/*String sql = "select f from FundsIncome f where f.project.id = :PROJECTID and id <> :ID";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("PROJECTID", fundsIncome.getProject().getId());
		queryMap.put("ID", fundsIncome.getId());
		List<FundsIncome> fundsList = (List<FundsIncome>) baseDao.findObjectList(sql, queryMap);
		
		Double incomeAmount = 0.00;
		
		if(fundsList != null && !fundsList.isEmpty()) {
			for (FundsIncome funds : fundsList) {
				incomeAmount += funds.getAmount();
			}
		}
		incomeAmount += fundsIncome.getAmount();
		
		for (FundsIncome funds : fundsList) {
			funds.setIncomeAmount(Double.valueOf(incomeAmount));
			baseDao.update(funds);
		}
		
		fundsIncome.setIncomeAmount(Double.valueOf(incomeAmount));*/
		baseDao.update(fundsIncome);
	}

	@Override
	public void doTransFundsIncome(String id, int status) {
		String sql = "select a from FundsIncome a left join fetch a.project where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		FundsIncome fundsIncome =  baseDao.findObject(sql, paramMap);
		if(status==1){
			String sql1 = "select f from FundsIncome f where f.project.id = :PROJECTID and id <> :ID";
			
			Map<String, Object> queryMap = new HashMap<String, Object>();
			queryMap.put("PROJECTID", fundsIncome.getProject().getId());
			queryMap.put("ID", fundsIncome.getId());
			
			List<FundsIncome> fundsList = (List<FundsIncome>) baseDao.findObjectList(sql1, queryMap);
			
			Double incomeAmount = 0.00;
			
			if(fundsList != null && !fundsList.isEmpty()) {
				for (FundsIncome funds : fundsList) {
					incomeAmount += funds.getAmount();
				}
			}
			incomeAmount += fundsIncome.getAmount();
			
			for (FundsIncome funds : fundsList) {
				funds.setIncomeAmount(Double.valueOf(incomeAmount));
				baseDao.update(funds);
			}
			
			fundsIncome.setIncomeAmount(Double.valueOf(incomeAmount));
		}
		fundsIncome.setStatus(status);
		baseDao.update(fundsIncome);
		
	}

	@Override
	public FundsIncome doJoinTransFindFundsIncome(String id) {
		String sql = "select r from FundsIncome r left join fetch r.project where r.id = :SID";
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("SID", id);
		
		FundsIncome fundsIncome = baseDao.findObject(sql, paramMap);
		return fundsIncome;
	}
}
