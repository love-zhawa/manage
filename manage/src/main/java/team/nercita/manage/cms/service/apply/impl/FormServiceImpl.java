/*
 * ApplyServiceImpl.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月6日 上午8:12:10
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.form.CommonForms;
import team.nercita.manage.cms.po.form.CommonFormss;
import team.nercita.manage.cms.service.apply.ApplyService;
import team.nercita.manage.cms.service.apply.FormService;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

@Component
public class FormServiceImpl extends BaseService implements FormService {

	@Override
	public Map<String, Object> doJoinTransFindCommonFormsList(Integer goPage, Map<String, Object> paramMap) {
		String fileName = MapUtils.getString(paramMap, "fileName");
		String title = MapUtils.getString(paramMap, "title");
		
		String sql = "select a from CommonFormss a left join fetch a.user where 1=1 ";
		String countSql = "select count(a) from CommonFormss a where 1=1";
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotBlank(title)){
			sql += " and a.title like :TITLE";
			countSql += " and a.title like :TITLE";
			queryMap.put("TITLE", "%" + title + "%");
		}
		
		if(StringUtils.isNotBlank(fileName)){
			sql += " and a.fileName like :FILENAME";
			countSql += " and a.fileName like :FILENAME";
			queryMap.put("FILENAME", "%" + fileName + "%");
		}
		
		sql += " order by a.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("formList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;
	}

	@Override
	public void doTransSaveCommonForms(CommonFormss commonFormss) {
		commonFormss.setId(Generator.getUUID());
		
		baseDao.save(commonFormss);
	}

	@Override
	public CommonFormss doJoinTransFindCommonForms(String id) {
		return baseDao.findObject(CommonFormss.class, id);
	}

	@Override
	public void doTransUpdateCommonForms(CommonFormss commonFormss) {
		CommonForms oldCommonForms = baseDao.findObject(CommonForms.class, commonFormss.getId());
		/*oldCommonForms.setFormName(commonFormss.getFormName());
		oldCommonForms.setContent(commonFormss.getContent());*/
		if(StringUtils.isNotBlank(commonFormss.getFileName())){
			oldCommonForms.setFileName(commonFormss.getFileName());
			oldCommonForms.setFilePath(commonFormss.getFilePath());
		}
		
		baseDao.update(oldCommonForms);
	}

}
