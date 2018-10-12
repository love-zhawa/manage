package team.nercita.manage.cms.service.jxc.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.jxc.ProductYqj;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.jxc.ProductYqjService;
import team.nercita.manage.cms.util.Generator;
import team.nercita.manage.cms.util.Page;

@Component
public class ProductYqjImpl extends BaseService implements ProductYqjService {

	@Override
	public Map<String, Object> doJoinTransFindList(Integer goPage,Map<String, Object> paramMap) {
		String name = MapUtils.getString(paramMap, "name");
		String lx = MapUtils.getString(paramMap, "lx");
		
		Map<String, Object> queryMap = new HashMap();
		
		String sql = "select p from ProductYqj p where 1=1 ";
		String countSql = "select count(p) from ProductYqj p where 1=1 ";
		
		if(StringUtils.isNotBlank(name)) {
			sql += " and p.name = :NAME";
			countSql += " and p.name = :NAME";
			queryMap.put("NAME", name);
		}
		if(StringUtils.isNotBlank(lx)) {
			sql += " and p.lx = :LX";
			countSql += " and p.lx = :LX";
			queryMap.put("LX", lx);
		}
		
		sql += " order by p.createTime desc";
		
		paramMap.clear();
		paramMap.put("page", new Page(baseDao.queryObjectCount(countSql, queryMap), goPage));
		paramMap.put("yqjList", baseDao.findObjectList(sql, queryMap, Page.getStartIndex(goPage), Page.getMaxResult()));
		
		return paramMap;	
	}

	@Override
	public void doTransSaveProductYqj(ProductYqj productYqj) {
		productYqj.setId(Generator.getUUID());
		baseDao.save(productYqj);
	}

	@Override
	public ProductYqj doJoinTransFindYqjById(String id) {
		return baseDao.findObject(ProductYqj.class,id);
	}

	@Override
	public void doTransUpdateDealer(ProductYqj productYqj) {
		baseDao.update(productYqj);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ProductYqj> doJoinTransFindDealer() {
		String sql = "select p from ProductYqj p";
		
		return (List<ProductYqj>) baseDao.findObjectList(sql, null);
	}

	@Override
	public void doTransDelete(String id) {
		ProductYqj yqj = baseDao.findObject(ProductYqj.class, id);
		baseDao.delete(yqj);
		
	}

}
