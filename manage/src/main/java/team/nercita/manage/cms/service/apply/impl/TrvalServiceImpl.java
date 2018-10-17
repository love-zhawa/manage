/*
 * TrvalServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年11月8日 下午4:43:19
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyLeave;
import team.nercita.manage.cms.po.form.ApplyTrval;
import team.nercita.manage.cms.po.form.TrvalDetail;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.apply.TrvalService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2017年11月8日 下午4:43:19
 */
@Component
public class TrvalServiceImpl extends BaseService implements TrvalService {

	@Override
	public Map<String, Object> doJoinTransFindApplyTrvalList(Integer goPage, Map<String, Object> paramMap) {
		String name = MapUtils.getString(paramMap, "name");
		String reason = MapUtils.getString(paramMap, "reason");
		
		String sql = "select a from ApplyTrval a left join fetch a.detailList left join fetch a.addUser where 1=1 ";
		String countSql = "select count(a) from ApplyTrval a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		//申请管理普通用户只能看自己的
		if(user.getPost()==2 || user.getPost()==3){
			sql += " and a.addUser.id = :USERID";
			countSql += " and a.addUser.id = :USERID";
			queryMap.put("USERID", user.getId());
		}
		if(StringUtils.isNotBlank(name)){
			sql += " and a.name like :NAME";
			countSql += " and a.name like :NAME";
			queryMap.put("NAME", "%" + name + "%");
		}
		
		if(StringUtils.isNotBlank(reason)){
			sql += " and a.reason like :REASON";
			countSql += " and a.reason like :REASON";
			queryMap.put("REASON", "%" + reason + "%");
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("trvalList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveApplyTrval(ApplyTrval applyTrval, User user) {
		applyTrval.setId(Generator.getUUID());
		List<TrvalDetail> detailList = applyTrval.getDetailList();
		applyTrval.setAddUser(user);
		applyTrval.setDetailList(null);
		baseDao.save(applyTrval);
		
		if(detailList != null) {
			for (TrvalDetail detail : detailList) {
				detail.setApplyTrval(applyTrval);
				detail.setId(Generator.getUUID());
				baseDao.save(detail);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public ApplyTrval doJoinTransFindApplyTrval(String id) {
		ApplyTrval Trval = baseDao.findObject(ApplyTrval.class, id);
		
		String sql = "select a from TrvalDetail a where a.applyTrval.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", id);
		
		List<TrvalDetail> detailList = (List<TrvalDetail>) baseDao.findObjectList(sql, resultMap);
		
		Trval.setDetailList(detailList);
		return Trval;
	}

	@Override
	public ApplyTrval doJoinTransFindApplyTrvalById(String id) {
		return baseDao.findObject(ApplyTrval.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public ApplyTrval doTransUpdateApplyTrval(ApplyTrval applyTrval, User user) {
		List<TrvalDetail> newDetailList = applyTrval.getDetailList();
		
		String asql = "select r from ApplyTrval r left join fetch r.project where r.id = :ID";//旧数据,applyReimbursement是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", applyTrval.getId());
		ApplyTrval app = baseDao.findObject(asql, paramMap);
		
		String sql = "select si from TrvalDetail si where si.applyTrval.id = :ID";
		List<TrvalDetail> oldList = (List<TrvalDetail>) baseDao.findObjectList(sql, paramMap);
		//审核通过后原有的经费加到原来的项目
		
		Double sum = 0.0;
		Double sum1 = 0.0;
		if(applyTrval.getStatus()==1&&applyTrval.getStatus()!=null){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",app.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			for (int i = 0; i < oldList.size(); i++) {
				Double sums = oldList.get(i).getTrafficAmount()+oldList.get(i).getLiveAmount()+oldList.get(i).getTrafficSubsidyAmount()+oldList.get(i).getFoodSubsidyAmount()+oldList.get(i).getOtherAmount();                                           
				sum += sums;
			}
			project.setTotalMoney(project.getTotalMoney()+sum);
			baseDao.update(project);
			
			//新选择的项目经费减少
			String psqls = "select p from Project p where p.id = :PIDS";
			Map<String,Object> proMaps = new HashMap();
			proMaps.put("PIDS",applyTrval.getProject().getId());
			Project projects = baseDao.findObject(psqls,proMaps);
			for (int i = 0; i < newDetailList.size(); i++) {
				Double sums1 = newDetailList.get(i).getTrafficAmount()+newDetailList.get(i).getLiveAmount()+newDetailList.get(i).getTrafficSubsidyAmount()+newDetailList.get(i).getFoodSubsidyAmount()+newDetailList.get(i).getOtherAmount();                                           
				sum1 += sums1;
			}
			projects.setTotalMoney(projects.getTotalMoney()-sum1);
			baseDao.update(projects);
		}
		return applyTrval;
	}
	@Override
	public void doTransUpdateApplyTrval1(ApplyTrval applyTrval, User user) {
		List<TrvalDetail> newDetailList = applyTrval.getDetailList();
		
		String sql = "select a from TrvalDetail a where a.applyTrval.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", applyTrval.getId());
		
		List<TrvalDetail> detailList = (List<TrvalDetail>) baseDao.findObjectList(sql, resultMap);
		
		for (TrvalDetail TrvalDetail : detailList) {
			baseDao.delete(TrvalDetail);
		}
		
		applyTrval.setDetailList(null);
		applyTrval.setAddUser(user);
		baseDao.update(applyTrval);
		
		if(newDetailList != null){
			for (TrvalDetail detail : newDetailList) {
				detail.setApplyTrval(applyTrval);
				detail.setId(Generator.getUUID());
				baseDao.save(detail);
			}
		}
	}
	
	
	@Override
	public void doTransApplyAudit(String id, int status) {
		Double sum = 0.0;
		String sql = "select a from ApplyTrval a left join fetch a.project where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		ApplyTrval applyTrval =  baseDao.findObject(sql, paramMap);
		if(status == 1){//审核通过，需要把项目总经费减去
			String sql1 = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",applyTrval.getProject().getId());
			Project project = baseDao.findObject(sql1, proMap);
			
			String sql2 = "select si from TrvalDetail si where si.applyTrval.id = :APPLYID";
			Map<String, Object> m = new HashMap();
			m.put("APPLYID", applyTrval.getId());
			List<TrvalDetail> lists = (List<TrvalDetail>) baseDao.findObjectList(sql2, m);
			for (int i = 0; i < lists.size(); i++) {
				Double sums = lists.get(i).getTrafficAmount()+lists.get(i).getLiveAmount()+lists.get(i).getTrafficSubsidyAmount()+lists.get(i).getFoodSubsidyAmount()+lists.get(i).getOtherAmount();                                           
				sum += sums;
			}
			
			project.setTotalMoney(project.getTotalMoney()-sum);
			baseDao.update(project);
		}
		applyTrval.setStatus(status);
		baseDao.update(applyTrval);
	}
	
	@Override
	public ApplyTrval doTransCommonDel(String id) {
		String asql = "select r from ApplyTrval r left join fetch r.project where r.id = :ID";//旧数据,applyReimbursement是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", id);
		ApplyTrval app = baseDao.findObject(asql, paramMap);
		
		String sql = "select si from TrvalDetail si where si.applyTrval.id = :ID";
		List<TrvalDetail> oldList = (List<TrvalDetail>) baseDao.findObjectList(sql, paramMap);
		
		Double sum = 0.0;
		if(app.getStatus()==1&&app.getStatus()!=null){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",app.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			for (int i = 0; i < oldList.size(); i++) {
				Double sums = oldList.get(i).getTrafficAmount()+oldList.get(i).getLiveAmount()+oldList.get(i).getTrafficSubsidyAmount()+oldList.get(i).getFoodSubsidyAmount()+oldList.get(i).getOtherAmount();                                           
				sum += sums;
			}
			project.setTotalMoney(project.getTotalMoney()+sum);
			baseDao.update(project);
		}
		return null;
		
	}
	@Override
	public void doTransCommonDel1(String id) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from TrvalDetail a where a.applyTrval.id = :ID";
		paramMap.put("ID", id);
		
		List<TrvalDetail> itemList = (List<TrvalDetail>) baseDao.findObjectList(sql, paramMap);
		if(itemList != null && !itemList.isEmpty()) {
			for (TrvalDetail storageItem : itemList) {
				baseDao.delete(storageItem);
			}
		}
		sql = "select a from ApplyTrval a where a.id = :ID";
		Object obj = baseDao.findObject(sql, paramMap);
		
		baseDao.delete(obj);
	}

	@Override
	public void doTransUpdateApplyTrval2(ApplyTrval applyTrval, User user) {
		List<TrvalDetail> newDetailList = applyTrval.getDetailList();
		
		String sql = "select a from TrvalDetail a where a.applyTrval.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", applyTrval.getId());
		
		List<TrvalDetail> detailList = (List<TrvalDetail>) baseDao.findObjectList(sql, resultMap);
		
		for (TrvalDetail TrvalDetail : detailList) {
			baseDao.delete(TrvalDetail);
		}
		
		applyTrval.setDetailList(null);
		applyTrval.setAddUser(user);
		baseDao.update(applyTrval);
		
		if(newDetailList != null){
			for (TrvalDetail detail : newDetailList) {
				detail.setApplyTrval(applyTrval);
				detail.setId(Generator.getUUID());
				baseDao.save(detail);
			}
		}
	}

	@Override
	public List<ApplyTrval> doJoinTransTrval(Date date, String userid) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from ApplyTrval a left join fetch a.addUser left join fetch a.detailList where a.addUser.id = :USERID";
		paramMap.put("USERID", userid);
		List<ApplyTrval> lists = (List<ApplyTrval>) baseDao.findObjectList(sql, paramMap);
		
		return lists;
	}
}
