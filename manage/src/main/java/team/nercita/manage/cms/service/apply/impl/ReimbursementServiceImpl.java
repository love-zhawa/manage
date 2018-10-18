/*
 * ReimbursementServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月8日 上午11:35:04
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyReimbursement;
import team.nercita.manage.cms.po.form.ReimbursementDetail;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.apply.ReimbursementService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2017年11月8日 上午11:35:04
 */
@Component
public class ReimbursementServiceImpl extends BaseService implements ReimbursementService {

	@Override
	public Map<String, Object> doJoinTransFindApplyReimbursementList(Integer goPage, Map<String, Object> paramMap) {
		String payUnit = MapUtils.getString(paramMap, "payUnit");
		String projectId = MapUtils.getString(paramMap, "projectId");
		Integer status = MapUtils.getInteger(paramMap, "status");
		
		String sql = "select a from ApplyReimbursement a left join fetch a.project left join fetch a.addUser where 1=1 ";
		String countSql = "select count(a) from ApplyReimbursement a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		//申请管理普通用户只能看自己的
		if(user.getPost()==2 || user.getPost()==3){
			sql += " and a.addUser.id = :USERID";
			countSql += " and a.addUser.id = :USERID";
			queryMap.put("USERID", user.getId());
		}
		if(StringUtils.isNotBlank(payUnit)){
			sql += " and a.payUnit like :PAYUNIT";
			countSql += " and a.payUnit like :PAYUNIT";
			queryMap.put("PAYUNIT", "%" + payUnit + "%");
		}
		
		if(StringUtils.isNotBlank(projectId)){
			sql += " and a.project.id = :PROJECTID";
			countSql += " and a.project.id = :PROJECTID";
			queryMap.put("PROJECTID", projectId);
		}
		
		if(status != null) {
			sql += " and a.status = :STATUS";
			countSql += " and a.status = :STATUS";
			queryMap.put("STATUS", status);
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("sementList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}
	@Override
	public Map<String, Object> doJoinTransFindApplyReimbursementList1(Integer goPage, Map<String, Object> paramMap) {
		String applyUser = MapUtils.getString(paramMap, "applyUser");
		String projectId = MapUtils.getString(paramMap, "projectId");
		Integer status = MapUtils.getInteger(paramMap, "status");
		
		String sql = "select a from ApplyReimbursement a left join fetch a.project left join fetch a.addUser where 1=1 ";
		String countSql = "select count(a) from ApplyReimbursement a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(applyUser)){
			sql += " and a.addUser.name like :APPLYUSER";
			countSql += " and a.addUser.name like :APPLYUSER";
			queryMap.put("APPLYUSER", "%" + applyUser + "%");
		}
		
		if(StringUtils.isNotBlank(projectId)){
			sql += " and a.project.id = :PROJECTID";
			countSql += " and a.project.id = :PROJECTID";
			queryMap.put("PROJECTID", projectId);
		}
		
		if(status != null) {
			sql += " and a.status = :STATUS";
			countSql += " and a.status = :STATUS";
			queryMap.put("STATUS", status);
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("sementList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveApplyReimbursement(ApplyReimbursement applyReimbursement,
			List<ReimbursementDetail> detailList) {
		applyReimbursement.setId(Generator.getUUID());
		applyReimbursement.setDetailList(null);
		baseDao.save(applyReimbursement);
		
		for (ReimbursementDetail reimbursementDetail : detailList) {
			
			if(StringUtils.isBlank(reimbursementDetail.getDetail()) && reimbursementDetail.getAmount() == null){
				continue;
			}
			reimbursementDetail.setId(Generator.getUUID());
			reimbursementDetail.setAddUser(applyReimbursement.getAddUser());
			reimbursementDetail.setApplyReimbursement(applyReimbursement);
			
			baseDao.save(reimbursementDetail);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> doJoinTransFindApplyReimbursement(String id) {
		String sql = "select r from ApplyReimbursement r left join fetch r.project left join fetch r.addUser where r.id = :SID";
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("SID", id);
		
		ApplyReimbursement reimbursement = baseDao.findObject(sql, paramMap);
		
		sql = "select r from ReimbursementDetail r where r.applyReimbursement.id = :SID";
		
		List<ReimbursementDetail> detailList = (List<ReimbursementDetail>) baseDao.findObjectList(sql, paramMap);
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("detailList", detailList);
		resultMap.put("reimbursement", reimbursement);
		return resultMap;
	}
	
	@Override
	public ApplyReimbursement doJoinTransFindApplyReimbursementById(String id) {
		return baseDao.findObject(ApplyReimbursement.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public ApplyReimbursement doTransUpdateApplyReimbursement(ApplyReimbursement applyReimbursement,List<ReimbursementDetail> detailList) {
		String asql = "select r from ApplyReimbursement r left join fetch r.project where r.id = :ID";//旧数据,applyReimbursement是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", applyReimbursement.getId());
		ApplyReimbursement app = baseDao.findObject(asql, paramMap);
		
		String sql = "select si from ReimbursementDetail si where si.applyReimbursement.id = :ID";
		List<ReimbursementDetail> oldList = (List<ReimbursementDetail>) baseDao.findObjectList(sql, paramMap);
		//审核通过后原有的经费加到原来的项目
		
		Double sum = 0.0;
		Double sum1 = 0.0;
		if(applyReimbursement.getStatus()!=null&&applyReimbursement.getStatus()==1){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",app.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			for (int i = 0; i < oldList.size(); i++) {
				sum+=oldList.get(i).getAmount();
			}
			project.setTotalMoney(project.getTotalMoney()+sum);
			baseDao.update(project);
			
			//新选择的项目经费减少
			String psqls = "select p from Project p where p.id = :PIDS";
			Map<String,Object> proMaps = new HashMap();
			proMaps.put("PIDS",applyReimbursement.getProject().getId());
			Project projects = baseDao.findObject(psqls,proMaps);
			for (int i = 0; i < detailList.size(); i++) {
				sum1+=detailList.get(i).getAmount();
			}
			projects.setTotalMoney(projects.getTotalMoney()-sum1);
			baseDao.update(projects);
		}
		
		
		return applyReimbursement;
	}
	@Override
	public void doTransUpdateApplyReimbursement1(ApplyReimbursement applyReimbursement,List<ReimbursementDetail> detailList) {
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", applyReimbursement.getId());
		
		String sql = "select si from ReimbursementDetail si where si.applyReimbursement.id = :ID";
		List<ReimbursementDetail> oldList = (List<ReimbursementDetail>) baseDao.findObjectList(sql, paramMap);
		if(oldList.size()>0){
			for (ReimbursementDetail detail : oldList) {
				baseDao.delete(detail);
			}
		}
		
		if(detailList.size()>0){
			for (ReimbursementDetail reimbursementDetail : detailList) {
				if(StringUtils.isBlank(reimbursementDetail.getDetail()) && reimbursementDetail.getAmount() == null){
					continue;
				}
				reimbursementDetail.setId(Generator.getUUID());
				reimbursementDetail.setAddUser(applyReimbursement.getAddUser());
				reimbursementDetail.setApplyReimbursement(applyReimbursement);
				
				baseDao.save(reimbursementDetail);
			}
		}
		applyReimbursement.setDetailList(null);
		baseDao.update(applyReimbursement);
	}
	
	@Override
	public void doTransApplyAudit(String id, int status) {
		Double sum = 0.0;
		String sql = "select a from ApplyReimbursement a left join fetch a.project where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		ApplyReimbursement reimbursement =  baseDao.findObject(sql, paramMap);
		if(status == 1){//审核通过，需要把项目总经费减去
			String sql1 = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",reimbursement.getProject().getId());
			Project project = baseDao.findObject(sql1, proMap);
			
			String sql2 = "select si from ReimbursementDetail si where si.applyReimbursement.id = :APPLYID";
			Map<String, Object> m = new HashMap();
			m.put("APPLYID", reimbursement.getId());
			List<ReimbursementDetail> lists = (List<ReimbursementDetail>) baseDao.findObjectList(sql2, m);
			for (int i = 0; i < lists.size(); i++) {
				sum+=lists.get(i).getAmount();
			}
			
			project.setTotalMoney(project.getTotalMoney()-sum);
			baseDao.update(project);
		}
		
		reimbursement.setStatus(status);
		baseDao.update(reimbursement);
	}

	@Override
	public void doTransCommonDel(String id) {
		String asql = "select r from ApplyReimbursement r left join fetch r.project where r.id = :ID";//旧数据,applyReimbursement是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", id);
		ApplyReimbursement app = baseDao.findObject(asql, paramMap);
		
		String sql = "select si from ReimbursementDetail si where si.applyReimbursement.id = :ID";
		List<ReimbursementDetail> oldList = (List<ReimbursementDetail>) baseDao.findObjectList(sql, paramMap);
		
		Double sum = 0.0;
		if(app.getStatus()==null||app.getStatus()==0||app.getStatus()==2){
			System.out.println("********");
			if(oldList != null && !oldList.isEmpty()) {
				for (ReimbursementDetail storageItem : oldList) {
					baseDao.delete(storageItem);
				}
			}
			sql = "select a from ApplyReimbursement a where a.id = :ID";
			Object obj = baseDao.findObject(sql, paramMap);
			baseDao.delete(obj);
			
		}else if(app.getStatus()==1){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",app.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			for (int i = 0; i < oldList.size(); i++) {
				sum+=oldList.get(i).getAmount();
			}
			project.setTotalMoney(project.getTotalMoney()+sum);
			baseDao.update(project);
			
			if(oldList != null && !oldList.isEmpty()) {
				for (ReimbursementDetail storageItem : oldList) {
					baseDao.delete(storageItem);
				}
			}
			sql = "select a from ApplyReimbursement a where a.id = :ID";
			Object obj = baseDao.findObject(sql, paramMap);
			baseDao.delete(obj);
		}
		
	}
	@Override
	public void doTransCommonDel1(String id) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from ReimbursementDetail a where a.applyReimbursement.id = :ID";
		paramMap.put("ID", id);
		
		List<ReimbursementDetail> itemList = (List<ReimbursementDetail>) baseDao.findObjectList(sql, paramMap);
		if(itemList != null && !itemList.isEmpty()) {
			for (ReimbursementDetail storageItem : itemList) {
				baseDao.delete(storageItem);
			}
		}
		sql = "select a from ApplyReimbursement a where a.id = :ID";
		Object obj = baseDao.findObject(sql, paramMap);
		
		baseDao.delete(obj);
	}

	
}
