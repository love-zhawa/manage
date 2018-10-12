
package team.nercita.manage.cms.service.apply;

import java.util.Map;

import team.nercita.manage.cms.po.form.CommonFormss;


public interface FormService {
	 public Map<String, Object> doJoinTransFindCommonFormsList(Integer goPage, Map<String, Object> paramMap);
	 
	 public void doTransSaveCommonForms(CommonFormss commonFormss);
	 
	 public CommonFormss doJoinTransFindCommonForms(String id);
	 
	 public void doTransUpdateCommonForms(CommonFormss commonFormss);
}
