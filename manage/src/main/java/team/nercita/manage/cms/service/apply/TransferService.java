/*
 * TransferService.java
 * 创建者：侯建玮
 * 创建日期：2017年11月4日 上午11:05:34
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.service.apply;

import java.util.Map;

import team.nercita.manage.cms.po.form.ApplyTransfer;

/**
 * 
 * @author 侯建玮
 * @date： 2017年11月4日 上午11:05:34
 */
public interface TransferService {
	public Map<String, Object> doJoinTransFindApplyTransferList(Integer goPage, Map<String, Object> paramMap);
	 
	 public void doTransSaveApplyTransfer(ApplyTransfer applyTransfer);
	 
	 public ApplyTransfer doJoinTransFindApplyTransfer(String id);
	 
	 public ApplyTransfer doTransUpdateApplyTransfer(ApplyTransfer applyTransfer);
	 public void doTransUpdateApplyTransfer1(ApplyTransfer applyTransfer);
	 
	 public void doTransApplyAudit(String id, int auditStatus);
	 
	 public ApplyTransfer doTransCommonDel(String id);
	 public void doTransCommonDel1(String id);
}
