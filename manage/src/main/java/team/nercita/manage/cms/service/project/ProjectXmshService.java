package team.nercita.manage.cms.service.project;

import java.util.Map;

import team.nercita.manage.cms.po.project.ProjectXmsh;

public interface ProjectXmshService {

	public Map<String, Object> doJoinTransProjectXmshList(Integer goPage, Map<String, Object> paramMap);
	
	public void doTransSaveProjectXmsh(ProjectXmsh xmsh);
	
	public void doTransUpdateProjectXmsh(ProjectXmsh xmsh);
	
	public ProjectXmsh doJoinTransFindProjectXmshById(String id);
	
}