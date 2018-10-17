/*
 * SalaryServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月8日 下午11:15:22
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplySalary;
import team.nercita.manage.cms.service.apply.SalaryService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

/**
 *
 * @author 侯建玮
 * @date 2017年8月8日 下午11:15:22
 */
@Component
public class SalaryServiceImpl extends BaseService implements SalaryService {

	@Override
	public Map<String, Object> doJoinTransFindApplySalaryList(Integer goPage, Map<String, Object> paramMap) {
		String userName = MapUtils.getString(paramMap, "userName");
		
		String sql = "select a from ApplySalary a left join fetch a.user where 1=1 ";
		String countSql = "select count(a) from ApplySalary a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		//申请管理普通用户只能看自己的
		if(user.getPost()==2 || user.getPost()==3){
			sql += " and a.user.id = :USERID";
			countSql += " and a.user.id = :USERID";
			queryMap.put("USERID", user.getId());
		}
		if(StringUtils.isNotBlank(userName)){
			sql += " and a.userName like :USERNAME";
			countSql += " and a.userName like :USERNAME";
			queryMap.put("USERNAME", "%" + userName + "%");
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("salaryList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveApplySalary(ApplySalary applySalary) {
		applySalary.setId(Generator.getUUID());
		
		baseDao.save(applySalary);
	}

	@Override
	public ApplySalary doJoinTransFindApplySalary(String id) {
		ApplySalary applySalary = baseDao.findObject(ApplySalary.class, id);
		applySalary.getUser().getName();
		return applySalary;
	}

	@Override
	public void doTransUpdateApplySalary(ApplySalary applySalary) {
		baseDao.update(applySalary);
	}

}
