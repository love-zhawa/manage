/*
 * UserService.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年6月17日 下午1:36:03
 * 创业小团队-后台
 */
package team.nercita.manage.cms.service.usermanage;

import java.util.Date;
import java.util.List;

import team.nercita.manage.cms.po.deptmanage.Student;

public interface StudentService {
	
	public List<Student> doJoinTransFindStudent();
	public List<Student> doJoinTransFindUserByTutorName(String tutor);

	public void doTransSaveStu(Student stu);
	
	public void doTransUpdateStu(Student stu);
	
	public Student doJoinTransFindUserById(String id);
	
	//审核
	public void doTransAudit(String id, int status);
	//根据开始时间和结束时间查询 补助
	public List<Student> doJoinTransFindbz(String userid,Date bztime);
	public List<Student> doJoinTransFindbz(String id,String userid,Date bztime);
}
