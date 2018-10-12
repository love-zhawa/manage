/*
 * UseCardService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年8月6日 下午12:13:46
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.apply;

import java.util.Map;

import team.nercita.manage.cms.po.form.ApplyRegister;

/**
 *
 * @author 侯建玮
 * @date 2017年8月6日 下午12:13:46
 */
public interface RegisterService {
	 public Map<String, Object> doJoinTransFindApplyRegisterList(Integer goPage, Map<String, Object> paramMap);
	 
	 public void doTransSaveApplyRegister(ApplyRegister applyRegister);
	 
	 public ApplyRegister doJoinTransFindApplyRegister(String id);
	 
	 public void doTransUpdateApplyRegister(ApplyRegister applyRegister);
}
