/*
 * RemunerationServiceImpl.java
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
import team.nercita.manage.cms.po.form.ApplyRemuneration;
import team.nercita.manage.cms.po.form.RemunerationDetail;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.apply.RemunerationService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2017年11月8日 下午4:43:19
 */
@Component
public class RemunerationServiceImpl extends BaseService implements RemunerationService {

	@Override
	public Map<String, Object> doJoinTransFindApplyRemunerationList(Integer goPage, Map<String, Object> paramMap) {
		String title = MapUtils.getString(paramMap, "title");
		String keyWords = MapUtils.getString(paramMap, "keyWords");
		
		String sql = "select a from ApplyRemuneration a left join fetch a.project left join fetch a.detailList where 1=1 ";
		String countSql = "select count(a) from ApplyRemuneration a where 1=1";
		
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
		paramMap.put("remunerationList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveApplyRemuneration(ApplyRemuneration applyRemuneration, User user) {
		applyRemuneration.setId(Generator.getUUID());
		List<RemunerationDetail> detailList = applyRemuneration.getDetailList();
		String keyWords = "";
		if(detailList != null) {
			for (RemunerationDetail remunerationDetail : detailList) {
				keyWords += remunerationDetail.getName() + "|" + remunerationDetail.getIdCard() 
					+ "|" +remunerationDetail.getBankName() + "|" + remunerationDetail.getBankCard();
			}
		}
		
		applyRemuneration.setDetailList(null);
		applyRemuneration.setKeyWords(keyWords);
		baseDao.save(applyRemuneration);
		
		if(detailList != null) {
			for (RemunerationDetail detail : detailList) {
				detail.setApplyRemuneration(applyRemuneration);
				detail.setAddUser(user);
				detail.setId(Generator.getUUID());
				baseDao.save(detail);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public ApplyRemuneration doJoinTransFindApplyRemuneration(String id) {
		ApplyRemuneration Remuneration = baseDao.findObject(ApplyRemuneration.class, id);
		
		String sql = "select a from RemunerationDetail a where a.applyRemuneration.id=:AID";
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", id);
		
		List<RemunerationDetail> detailList = (List<RemunerationDetail>) baseDao.findObjectList(sql, resultMap);
		
		Remuneration.setDetailList(detailList);
		return Remuneration;
	}

	@Override
	public ApplyRemuneration doJoinTransFindApplyRemunerationById(String id) {
		return baseDao.findObject(ApplyRemuneration.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public ApplyRemuneration doTransUpdateApplyRemuneration(ApplyRemuneration applyRemuneration, User user) {
		List<RemunerationDetail> newDetailList = applyRemuneration.getDetailList();
        String asql = "select r from ApplyRemuneration r left join fetch r.project where r.id = :ID";//旧数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", applyRemuneration.getId());
		ApplyRemuneration app = baseDao.findObject(asql, paramMap);
		
		String sql = "select si from RemunerationDetail si where si.applyRemuneration.id = :ID";
		List<RemunerationDetail> oldList = (List<RemunerationDetail>) baseDao.findObjectList(sql, paramMap);
		//审核通过后原有的经费加到原来的项目
		
		Double sum = 0.0;
		Double sum1 = 0.0;
		if(applyRemuneration.getStatus()==1&&applyRemuneration.getStatus()!=null){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",app.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			for (int i = 0; i < oldList.size(); i++) {
				sum+=oldList.get(i).getPayAmount();
			}
			project.setTotalMoney(project.getTotalMoney()+sum);
			baseDao.update(project);
			
			//新选择的项目经费减少
			String psqls = "select p from Project p where p.id = :PIDS";
			Map<String,Object> proMaps = new HashMap();
			proMaps.put("PIDS",applyRemuneration.getProject().getId());
			Project projects = baseDao.findObject(psqls,proMaps);
			for (int i = 0; i < newDetailList.size(); i++) {
				sum1+=newDetailList.get(i).getPayAmount();
			}
			projects.setTotalMoney(projects.getTotalMoney()-sum1);
			baseDao.update(projects);
		}
		return applyRemuneration;
	}
	@Override
	public void doTransUpdateApplyRemuneration1(ApplyRemuneration applyRemuneration, User user) {
		List<RemunerationDetail> newDetailList = applyRemuneration.getDetailList();
		String keyWords = "";
		
		String sql = "select a from RemunerationDetail a where a.applyRemuneration.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", applyRemuneration.getId());
		
		List<RemunerationDetail> detailList = (List<RemunerationDetail>) baseDao.findObjectList(sql, resultMap);
		
		for (RemunerationDetail remunerationDetail : detailList) {
			baseDao.delete(remunerationDetail);
		}
		
		if(newDetailList != null){
			for (RemunerationDetail remunerationDetail : newDetailList) {
				keyWords += remunerationDetail.getName() + "|" + remunerationDetail.getIdCard() 
					+ "|" +remunerationDetail.getBankName() + "|" + remunerationDetail.getBankCard();
			}
		}
		
		applyRemuneration.setDetailList(null);
		applyRemuneration.setKeyWords(keyWords);
		baseDao.update(applyRemuneration);
		
		if(newDetailList != null){
			for (RemunerationDetail detail : newDetailList) {
				detail.setApplyRemuneration(applyRemuneration);
				detail.setId(Generator.getUUID());
				detail.setAddUser(user);
				baseDao.save(detail);
			}
		}
	}
	
	
	@Override
	public void doTransApplyAudit(String id, int status) {
		Double sum = 0.0;
		String sql = "select a from ApplyRemuneration a left join fetch a.project where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		ApplyRemuneration applyRemuneration =  baseDao.findObject(sql, paramMap);
		if(status == 1){//审核通过，需要把项目总经费减去
			String sql1 = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",applyRemuneration.getProject().getId());
			Project project = baseDao.findObject(sql1, proMap);
			
			String sql2 = "select si from RemunerationDetail si where si.applyRemuneration.id = :APPLYID";
			Map<String, Object> m = new HashMap();
			m.put("APPLYID", applyRemuneration.getId());
			List<RemunerationDetail> lists = (List<RemunerationDetail>) baseDao.findObjectList(sql2, m);
			for (int i = 0; i < lists.size(); i++) {
				sum+=lists.get(i).getPayAmount();
			}
			project.setTotalMoney(project.getTotalMoney()-sum);
			baseDao.update(project);
		}
		applyRemuneration.setStatus(status);
		baseDao.update(applyRemuneration);
	}

	@Override
	public Map<String, Object> doJoinTransFindApplyRemunerations(String id) {
		String sql = "select r from ApplyRemuneration r left join fetch r.project where r.id = :SID";
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("SID", id);
		
		ApplyRemuneration remuneration = baseDao.findObject(sql, paramMap);
		
		sql = "select r from RemunerationDetail r where r.applyRemuneration.id = :SID";
		
		List<RemunerationDetail> detailList = (List<RemunerationDetail>) baseDao.findObjectList(sql, paramMap);
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("detailList", detailList);
		resultMap.put("remuneration", remuneration);
		return resultMap;
	}
	
	@Override
	public ApplyRemuneration doTransCommonDel(String id) {
		String asql = "select r from ApplyRemuneration r left join fetch r.project where r.id = :ID";//旧数据,applyReimbursement是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", id);
		ApplyRemuneration app = baseDao.findObject(asql, paramMap);
		
		String sql = "select si from RemunerationDetail si where si.applyRemuneration.id = :ID";
		List<RemunerationDetail> oldList = (List<RemunerationDetail>) baseDao.findObjectList(sql, paramMap);
		
		Double sum = 0.0;
		if(app.getStatus()==1&&app.getStatus()!=null){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",app.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			for (int i = 0; i < oldList.size(); i++) {
				sum+=oldList.get(i).getPayAmount();
			}
			project.setTotalMoney(project.getTotalMoney()+sum);
			baseDao.update(project);
		}
		return null;
		
	}
	@Override
	public void doTransCommonDel1(String id) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from RemunerationDetail a where a.applyRemuneration.id = :ID";
		paramMap.put("ID", id);
		
		List<RemunerationDetail> itemList = (List<RemunerationDetail>) baseDao.findObjectList(sql, paramMap);
		if(itemList != null && !itemList.isEmpty()) {
			for (RemunerationDetail storageItem : itemList) {
				baseDao.delete(storageItem);
			}
		}
		sql = "select a from ApplyRemuneration a where a.id = :ID";
		Object obj = baseDao.findObject(sql, paramMap);
		
		baseDao.delete(obj);
	}
}
