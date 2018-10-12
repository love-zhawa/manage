/*
 * ChequeServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月8日 下午4:43:19
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyCheque;
import team.nercita.manage.cms.po.form.ApplyChequeDetail;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.apply.ChequeService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2017年11月8日 下午4:43:19
 */
@Component
public class ChequeServiceImpl extends BaseService implements ChequeService {

	@Override
	public Map<String, Object> doJoinTransFindApplyChequeList(Integer goPage, Map<String, Object> paramMap) {
		String title = MapUtils.getString(paramMap, "title");
		String keyWords = MapUtils.getString(paramMap, "keyWords");
		
		String sql = "select a from ApplyCheque a left join fetch a.detailList where 1=1 ";
		String countSql = "select count(a) from ApplyCheque a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(title)){
			sql += " and a.title like :TITLE";
			countSql += " and a.title like :TITLE";
			queryMap.put("TITLE", "%" + title + "%");
		}
		
		if(StringUtils.isNotBlank(keyWords)){
			sql += " and a.keyWords like :KEYWORDS";
			countSql += " and a.keyWords like :KEYWORDS";
			queryMap.put("KEYWORDS", "%" + keyWords + "%");
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("chequeList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveApplyCheque(ApplyCheque applyCheque, User user) {
		applyCheque.setId(Generator.getUUID());
		List<ApplyChequeDetail> detailList = applyCheque.getDetailList();
		String keyWords = "";
		if(detailList != null) {
			for (ApplyChequeDetail applyChequeDetail : detailList) {
				if(applyChequeDetail.getProject() != null && StringUtils.isNotBlank(applyChequeDetail.getProject().getId())){
					Project project = baseDao.findObject(Project.class, applyChequeDetail.getProject().getId());
					keyWords += applyChequeDetail.getPayUnit() + "|" + project.getProjectName() 
					+ "|" +applyChequeDetail.getUseInfo() + "|" + applyChequeDetail.getDetail();
					applyChequeDetail.setPayProject(project.getProjectName());
					applyChequeDetail.setNumber(project.getFinancialNumber());
				}
			}
		}
		
		applyCheque.setDetailList(null);
		applyCheque.setKeyWords(keyWords);
		baseDao.save(applyCheque);
		
		if(detailList != null) {
			for (ApplyChequeDetail detail : detailList) {
				if(detail.getProject() != null && StringUtils.isNotBlank(detail.getProject().getId())){
					detail.setApplyCheque(applyCheque);
					detail.setUser(user);
					detail.setId(Generator.getUUID());
					baseDao.save(detail);
				}
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public ApplyCheque doJoinTransFindApplyCheque(String id) {
		ApplyCheque cheque = baseDao.findObject(ApplyCheque.class, id);
		
		String sql = "select a from ApplyChequeDetail a where a.applyCheque.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", id);
		
		List<ApplyChequeDetail> detailList = (List<ApplyChequeDetail>) baseDao.findObjectList(sql, resultMap);
		
		cheque.setDetailList(detailList);
		return cheque;
	}

	@Override
	public ApplyCheque doJoinTransFindApplyChequeById(String id) {
		String sql = "select a from ApplyCheque a left join fetch a.detailList where a.id = :ID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("ID", id);
		
		return baseDao.findObject(sql, resultMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public ApplyCheque doTransUpdateApplyCheque(ApplyCheque applyCheque, User user) {
		List<ApplyChequeDetail> newDetailList = applyCheque.getDetailList();
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", applyCheque.getId());
		
		String sql = "select si from ApplyChequeDetail si left join fetch si.project where si.applyCheque.id = :ID";
		List<ApplyChequeDetail> oldList = (List<ApplyChequeDetail>) baseDao.findObjectList(sql, paramMap);
		//审核通过后原有的经费加到原来的项目
		if(applyCheque.getStatus()==1&&applyCheque.getStatus()!=null){
			for (int i = 0; i < oldList.size(); i++) {
				String oldsql = "select p from Project p where p.id = :PID";
				Map<String,Object> oldMap = new HashMap();
				oldMap.put("PID",oldList.get(i).getProject().getId());
				Project projects = baseDao.findObject(oldsql,oldMap);
				projects.setTotalMoney(projects.getTotalMoney()+oldList.get(i).getAmount());
				baseDao.update(projects);
			}
			for (int i = 0; i < newDetailList.size(); i++) {
				String psqls = "select p from Project p where p.id = :PIDS";
				Map<String,Object> proMaps = new HashMap();
				proMaps.put("PIDS",newDetailList.get(i).getProject().getId());
				Project projects = baseDao.findObject(psqls,proMaps);
				projects.setTotalMoney(projects.getTotalMoney()-newDetailList.get(i).getAmount());
				baseDao.update(projects);
			}
			
		}
		return applyCheque;
	}
	@Override
	public void doTransUpdateApplyCheque1(ApplyCheque applyCheque, User user) {
		List<ApplyChequeDetail> newDetailList = applyCheque.getDetailList();
		String keyWords = "";
		
		String sql = "select a from ApplyChequeDetail a where a.applyCheque.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", applyCheque.getId());
		
		List<ApplyChequeDetail> detailList = (List<ApplyChequeDetail>) baseDao.findObjectList(sql, resultMap);
		
		for (ApplyChequeDetail applyChequeDetail : detailList) {
			baseDao.delete(applyChequeDetail);
		}
		
		if(newDetailList != null){
			for (ApplyChequeDetail applyChequeDetail : newDetailList) {
				if(applyChequeDetail.getProject() != null && StringUtils.isNotBlank(applyChequeDetail.getProject().getId())){
					Project project = baseDao.findObject(Project.class, applyChequeDetail.getProject().getId());
					keyWords += applyChequeDetail.getPayUnit() + "|" + project.getProjectName()
						+ "|" +applyChequeDetail.getUseInfo() + "|" + applyChequeDetail.getDetail();
					applyChequeDetail.setPayProject(project.getProjectName());
				}
			}
		}
		
		applyCheque.setDetailList(null);
		applyCheque.setKeyWords(keyWords);
		baseDao.update(applyCheque);
		
		if(newDetailList != null){
			for (ApplyChequeDetail detail : newDetailList) {
				if(detail.getProject() != null && StringUtils.isNotBlank(detail.getProject().getId())){
					detail.setApplyCheque(applyCheque);
					detail.setId(Generator.getUUID());
					detail.setUser(user);
					baseDao.save(detail);
				}
			}
		}
	}
	
	
	@Override
	public void doTransApplyAudit(String id, int status) {
		String sql = "select a from ApplyCheque a where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		ApplyCheque applyCheque =  baseDao.findObject(sql, paramMap);
		if(status == 1){//审核通过，需要把项目总经费减去
			String sql2 = "select si from ApplyChequeDetail si left join fetch si.project where si.applyCheque.id = :APPLYID";
			Map<String, Object> m = new HashMap();
			m.put("APPLYID", applyCheque.getId());
			List<ApplyChequeDetail> lists = (List<ApplyChequeDetail>) baseDao.findObjectList(sql2, m);
			for (int i = 0; i < lists.size(); i++) {
				String sql1 = "select p from Project p where p.id = :PID";
				Map<String,Object> proMap = new HashMap();
				proMap.put("PID",lists.get(i).getProject().getId());
				Project project = baseDao.findObject(sql1, proMap);
				System.out.println(lists.get(i).getAmount());
				project.setTotalMoney(project.getTotalMoney()-lists.get(i).getAmount());
			}
		}
		applyCheque.setStatus(status);
		baseDao.update(applyCheque);
	}
	
	@Override
	public ApplyCheque doTransCommonDel(String id) {
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", id);
		
		String sql = "select a from ApplyCheque a where a.id = :ID";
		ApplyCheque applyCheque =  baseDao.findObject(sql, paramMap);
		if(applyCheque.getStatus() == 1){
			String sql2 = "select si from ApplyChequeDetail si left join fetch si.project where si.applyCheque.id = :APPLYID";
			Map<String, Object> m = new HashMap();
			m.put("APPLYID", applyCheque.getId());
			List<ApplyChequeDetail> lists = (List<ApplyChequeDetail>) baseDao.findObjectList(sql2, m);
			for (int i = 0; i < lists.size(); i++) {
				String sql1 = "select p from Project p where p.id = :PID";
				Map<String,Object> proMap = new HashMap();
				proMap.put("PID",lists.get(i).getProject().getId());
				Project project = baseDao.findObject(sql1, proMap);
				project.setTotalMoney(project.getTotalMoney()+lists.get(i).getAmount());
				baseDao.update(project);
			}
		}
		return null;
		
	}
	@Override
	public void doTransCommonDel1(String id) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from ApplyChequeDetail a where a.applyCheque.id = :ID";
		paramMap.put("ID", id);
		
		List<ApplyChequeDetail> itemList = (List<ApplyChequeDetail>) baseDao.findObjectList(sql, paramMap);
		if(itemList != null && !itemList.isEmpty()) {
			for (ApplyChequeDetail storageItem : itemList) {
				baseDao.delete(storageItem);
			}
		}
		sql = "select a from ApplyCheque a where a.id = :ID";
		Object obj = baseDao.findObject(sql, paramMap);
		
		baseDao.delete(obj);
	}
}
