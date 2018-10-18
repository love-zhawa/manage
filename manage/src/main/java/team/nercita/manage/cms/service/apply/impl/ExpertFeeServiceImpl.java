/*
 * ExpertFeeServiceImpl.java
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.Experts;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyExpertFee;
import team.nercita.manage.cms.po.form.ExpertFeeDetail;
import team.nercita.manage.cms.po.projectmanage.Project;
import team.nercita.manage.cms.service.apply.ExpertFeeService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.usermanage.ExpertsService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2017年11月8日 下午4:43:19
 */
@Component
public class ExpertFeeServiceImpl extends BaseService implements ExpertFeeService {
	@Autowired
	ExpertsService expertsService;//专家
	
	@Override
	public Map<String, Object> doJoinTransFindApplyExpertFeeList(Integer goPage, Map<String, Object> paramMap) {
		String title = MapUtils.getString(paramMap, "title");
		String keyWords = MapUtils.getString(paramMap, "keyWords");
		
		String sql = "select a from ApplyExpertFee a left join fetch a.project left join fetch a.detailList where 1=1 ";
		String countSql = "select count(a) from ApplyExpertFee a where 1=1";
		
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
		paramMap.put("expertFeeList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveApplyExpertFee(ApplyExpertFee applyExpertFee, User user) {
		applyExpertFee.setId(Generator.getUUID());
		List<ExpertFeeDetail> detailList = applyExpertFee.getDetailList();
		String keyWords = "";
		if(detailList != null) {
			for (ExpertFeeDetail expertFeeDetail : detailList) {
				keyWords += expertFeeDetail.getZjid() + "|" + expertFeeDetail.getIdCard() 
					+ "|" +expertFeeDetail.getUnit() + "|" + expertFeeDetail.getTitle();
			}
		}
		
		applyExpertFee.setDetailList(null);
		applyExpertFee.setKeyWords(keyWords);
		baseDao.save(applyExpertFee);
		
		if(detailList != null) {
			for (ExpertFeeDetail detail : detailList) {
				Experts zj = expertsService.doJoinTransFindExperts(detail.getZjid());
				detail.setName(zj.getUserName());
				detail.setZjid(zj.getId());
				detail.setApplyExpertFee(applyExpertFee);
				detail.setUser(user);
				detail.setId(Generator.getUUID());
				baseDao.save(detail);
				//并且可以修改专家信息
				zj.setIdCard(detail.getIdCard());
				zj.setUnit(detail.getUnit());
				zj.setTitle(detail.getTitle());
				zj.setBankCard(detail.getBankCard());
				zj.setBankName(detail.getBaneName());
				expertsService.doTransUpdateExperts(zj);
				
			}
		}
	}
	@Override
	public void doTransSaveApplyExpertFee1(ApplyExpertFee applyExpertFee, User user) {
		applyExpertFee.setId(Generator.getUUID());
		List<ExpertFeeDetail> detailList = applyExpertFee.getDetailList();
		String keyWords = "";
		if(detailList != null) {
			for (ExpertFeeDetail expertFeeDetail : detailList) {
				keyWords += expertFeeDetail.getZjid() + "|" + expertFeeDetail.getIdCard() 
					+ "|" +expertFeeDetail.getUnit() + "|" + expertFeeDetail.getTitle();
			}
		}
		
		applyExpertFee.setDetailList(null);
		applyExpertFee.setKeyWords(keyWords);
		baseDao.save(applyExpertFee);
		if(detailList != null) {
			for (ExpertFeeDetail detail : detailList) {
				detail.setName(detail.getName());
				detail.setIdCard(detail.getIdCard());
				detail.setUnit(detail.getUnit());
				detail.setTitle(detail.getTitle());
				detail.setDays(detail.getDays());
				detail.setBankCard(detail.getBankCard());
				detail.setBaneName(detail.getBaneName());
				detail.setAmount(detail.getAmount());
				detail.setId(Generator.getUUID());
				detail.setApplyExpertFee(applyExpertFee);
				baseDao.save(detail);
			}
		}
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public ApplyExpertFee doJoinTransFindApplyExpertFee(String id) {
		ApplyExpertFee ExpertFee = baseDao.findObject(ApplyExpertFee.class, id);
		
		String sql = "select a from ExpertFeeDetail a where a.applyExpertFee.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", id);
		
		List<ExpertFeeDetail> detailList = (List<ExpertFeeDetail>) baseDao.findObjectList(sql, resultMap);
		
		ExpertFee.setDetailList(detailList);
		return ExpertFee;
	}

	@Override
	public ApplyExpertFee doJoinTransFindApplyExpertFeeById(String id) {
		return baseDao.findObject(ApplyExpertFee.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public ApplyExpertFee doTransUpdateApplyExpertFee(ApplyExpertFee applyExpertFee, User user) {
		List<ExpertFeeDetail> newDetailList = applyExpertFee.getDetailList();
		String asql = "select r from ApplyExpertFee r left join fetch r.project where r.id = :ID";//旧数据,applyExpertFee是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", applyExpertFee.getId());
		ApplyExpertFee app = baseDao.findObject(asql, paramMap);
		
		String sql = "select si from ExpertFeeDetail si where si.applyExpertFee.id = :ID";
		List<ExpertFeeDetail> oldList = (List<ExpertFeeDetail>) baseDao.findObjectList(sql, paramMap);
		//审核通过后原有的经费加到原来的项目
		
		Double sum = 0.0;
		Double sum1 = 0.0;
		if(applyExpertFee.getStatus()==1&&applyExpertFee.getStatus()!=null){
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
			proMaps.put("PIDS",applyExpertFee.getProject().getId());
			Project projects = baseDao.findObject(psqls,proMaps);
			for (int i = 0; i < newDetailList.size(); i++) {
				sum1+=newDetailList.get(i).getAmount();
			}
			projects.setTotalMoney(projects.getTotalMoney()-sum1);
			baseDao.update(projects);
		}
		
		return applyExpertFee;
	
	}
	public void doTransUpdateApplyExpertFee1(ApplyExpertFee applyExpertFee, User user) {
		List<ExpertFeeDetail> newDetailList = applyExpertFee.getDetailList();
		String keyWords = "";
		
		String sql = "select a from ExpertFeeDetail a where a.applyExpertFee.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", applyExpertFee.getId());
		
		List<ExpertFeeDetail> detailList = (List<ExpertFeeDetail>) baseDao.findObjectList(sql, resultMap);
		
		for (ExpertFeeDetail expertFeeDetail : detailList) {
			baseDao.delete(expertFeeDetail);
		}
		
		if(newDetailList != null){
			for (ExpertFeeDetail expertFeeDetail : newDetailList) {
				keyWords += expertFeeDetail.getZjid() + "|" + expertFeeDetail.getIdCard() 
					+ "|" +expertFeeDetail.getUnit() + "|" + expertFeeDetail.getTitle();
			}
		}
		
		applyExpertFee.setDetailList(null);
		applyExpertFee.setKeyWords(keyWords);
		baseDao.update(applyExpertFee);
		
		if(newDetailList != null){
			for (ExpertFeeDetail detail : newDetailList) {
				Experts zj = expertsService.doJoinTransFindExperts(detail.getZjid());
				detail.setName(zj.getUserName());
				detail.setApplyExpertFee(applyExpertFee);
				detail.setId(Generator.getUUID());
				detail.setUser(user);
				baseDao.save(detail);
				//并且可以修改专家信息
				zj.setIdCard(detail.getIdCard());
				zj.setUnit(detail.getUnit());
				zj.setTitle(detail.getTitle());
				zj.setBankCard(detail.getBankCard());
				zj.setBankName(detail.getBaneName());
				expertsService.doTransUpdateExperts(zj);
			}
		}
	}
	public void doTransUpdateApplyExpertFee2(ApplyExpertFee applyExpertFee, User user) {
		List<ExpertFeeDetail> newDetailList = applyExpertFee.getDetailList();
		String keyWords = "";
		String sql = "select a from ExpertFeeDetail a where a.applyExpertFee.id=:AID";
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", applyExpertFee.getId());
		
		List<ExpertFeeDetail> detailList = (List<ExpertFeeDetail>) baseDao.findObjectList(sql, resultMap);
		for (ExpertFeeDetail expertFeeDetail : detailList) {
			baseDao.delete(expertFeeDetail);
		}
		if(newDetailList != null){
			for (ExpertFeeDetail expertFeeDetail : newDetailList) {
				keyWords += expertFeeDetail.getZjid() + "|" + expertFeeDetail.getIdCard() 
					+ "|" +expertFeeDetail.getUnit() + "|" + expertFeeDetail.getTitle();
			}
		}
		
		applyExpertFee.setDetailList(null);
		applyExpertFee.setKeyWords(keyWords);
		baseDao.update(applyExpertFee);
		if(newDetailList != null) {
			for (ExpertFeeDetail detail : newDetailList) {
				detail.setName(detail.getName());
				detail.setIdCard(detail.getIdCard());
				detail.setUnit(detail.getUnit());
				detail.setTitle(detail.getTitle());
				detail.setDays(detail.getDays());
				detail.setBankCard(detail.getBankCard());
				detail.setBaneName(detail.getBaneName());
				detail.setAmount(detail.getAmount());
				detail.setId(Generator.getUUID());
				detail.setApplyExpertFee(applyExpertFee);
				baseDao.save(detail);
			}
		}
	}
	
	@Override
	public void doTransApplyAudit(String id, int status) {
		Double sum = 0.0;
		String sql = "select a from ApplyExpertFee a left join fetch a.project where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		ApplyExpertFee applyExpertFee =  baseDao.findObject(sql, paramMap);
		if(status == 1){//审核通过，需要把项目总经费减去
			String sql1 = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",applyExpertFee.getProject().getId());
			Project project = baseDao.findObject(sql1, proMap);
			
			String sql2 = "select si from ExpertFeeDetail si where si.applyExpertFee.id = :APPLYID";
			Map<String, Object> m = new HashMap();
			m.put("APPLYID", applyExpertFee.getId());
			List<ExpertFeeDetail> lists = (List<ExpertFeeDetail>) baseDao.findObjectList(sql2, m);
			for (int i = 0; i < lists.size(); i++) {
				if(lists.get(i).getAmount()!=null&&!lists.get(i).getAmount().equals("")){
					sum+=lists.get(i).getAmount();
				}
			}
			project.setTotalMoney(project.getTotalMoney()-sum);
			baseDao.update(project);
		}
		applyExpertFee.setStatus(status);
		baseDao.update(applyExpertFee);
	}

	@Override
	public Map<String, Object> doJoinTransFindApplyExpertFees(String id) {
		String sql = "select r from ApplyExpertFee r left join fetch r.project where r.id = :SID";
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("SID", id);
		
		ApplyExpertFee expertFee = baseDao.findObject(sql, paramMap);
		
		sql = "select a from ExpertFeeDetail a where a.applyExpertFee.id = :SID";
		
		List<ExpertFeeDetail> detailList = (List<ExpertFeeDetail>) baseDao.findObjectList(sql, paramMap);
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("detailList", detailList);
		resultMap.put("expertFee", expertFee);
		return resultMap;
	}
	
	@Override
	public void doTransCommonDel(String id) {
		String asql = "select r from ApplyExpertFee r left join fetch r.project where r.id = :ID";//旧数据,applyReimbursement是新数据
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ID", id);
		ApplyExpertFee app = baseDao.findObject(asql, paramMap);
		
		String sql = "select si from ExpertFeeDetail si where si.applyExpertFee.id = :ID";
		List<ExpertFeeDetail> oldList = (List<ExpertFeeDetail>) baseDao.findObjectList(sql, paramMap);
		
		Double sum = 0.0;
		if(app.getStatus()==1&&app.getStatus()!=null){
			String psql = "select p from Project p where p.id = :PID";
			Map<String,Object> proMap = new HashMap();
			proMap.put("PID",app.getProject().getId());
			Project project = baseDao.findObject(psql,proMap);
			for (int i = 0; i < oldList.size(); i++) {
				sum+=oldList.get(i).getAmount();
			}
			project.setTotalMoney(project.getTotalMoney()+sum);
			baseDao.update(project);
		}
		if(oldList != null && !oldList.isEmpty()) {
			for (ExpertFeeDetail old : oldList) {
				baseDao.delete(old);
			}
		}
		baseDao.delete(app);
		
	}
	@Override
	public void doTransCommonDel1(String id) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = "select a from ExpertFeeDetail a where a.applyExpertFee.id = :ID";
		paramMap.put("ID", id);
		
		List<ExpertFeeDetail> itemList = (List<ExpertFeeDetail>) baseDao.findObjectList(sql, paramMap);
		if(itemList != null && !itemList.isEmpty()) {
			for (ExpertFeeDetail storageItem : itemList) {
				baseDao.delete(storageItem);
			}
		}
		sql = "select a from ApplyExpertFee a where a.id = :ID";
		Object obj = baseDao.findObject(sql, paramMap);
		
		baseDao.delete(obj);
	}
}
