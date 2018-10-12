package team.nercita.manage.cms.service.project;

import java.util.Map;

import team.nercita.manage.cms.po.project.ProjectCpsh;

public interface ProjectCpshService {

	public Map<String, Object> doJoinTransProjectCpshList(Integer goPage, Map<String, Object> paramMap);
	
	public void doTransSaveProjectCpsh(ProjectCpsh cpsh);
	
	public void doTransUpdateProjectCpsh(ProjectCpsh cpsh);
	
	public ProjectCpsh doJoinTransFindProjectCpshById(String id);
	
}