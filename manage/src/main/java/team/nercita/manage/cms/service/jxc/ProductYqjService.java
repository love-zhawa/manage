package team.nercita.manage.cms.service.jxc;

import java.util.List;
import java.util.Map;

import team.nercita.manage.cms.po.jxc.ProductYqj;

public interface ProductYqjService {
	
	public Map<String, Object> doJoinTransFindList(Integer goPage, Map<String, Object> paramMap);
	
	public void doTransSaveProductYqj(ProductYqj productYqj);//添加
	
	public ProductYqj doJoinTransFindYqjById(String id);//根据id查看
	
	public void doTransUpdateDealer(ProductYqj productYqj);//修改
	
	public List<ProductYqj> doJoinTransFindDealer();//查询所有
	
	public void doTransDelete(String id);
}
