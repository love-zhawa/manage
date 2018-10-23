package team.nercita.manage.cms.service.usermanage.impl;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import team.nercita.manage.cms.po.deptmanage.Student;
import team.nercita.manage.cms.po.deptmanage.Studentbz;
import team.nercita.manage.cms.service.base.BaseService;
import team.nercita.manage.cms.service.usermanage.StudentService;
import team.nercita.manage.cms.util.Generator;

@Component
public class StudentServiceImpl extends BaseService implements StudentService {

	@Override
	public List<Student> doJoinTransFindUserByTutorName(String tutor) {
		String sql = "select u from Student u left join fetch u.user left join fetch u.userGroup left join fetch u.project where u.tutor = :TUTOR";
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("TUTOR", tutor);
		List<Student> lists = (List<Student>) baseDao.findObjectList(sql, paramMap);
		return lists;
	}

	@Override
	public void doTransSaveStu(Student stu) {
		stu.setId(Generator.getUUID());
		//stu.setUser(stu.getUser());
		stu.setTutor(stu.getTutor());
		stu.setProject(stu.getProject());
		stu.setSummoney(stu.getSummoney());
		stu.setBztime(stu.getBztime());
		try {
			stu.setBeginTime(subMonth(stu.getBztime()));//上个月19号
			stu.setEndTime(endtime(stu.getBztime()));//下个月18号
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		baseDao.save(stu);
		List<Studentbz> bzlist = stu.getBzlist();
		if(bzlist !=null ){
			for (Studentbz bz : bzlist) {
				bz.setId(Generator.getUUID());
				bz.setStudent(stu);
				try {
					bz.setBeginTime(subMonth(stu.getBztime()));//上个月19号
					bz.setEndTime(endtime(stu.getBztime()));//下个月18号
				} catch (ParseException e) {
					e.printStackTrace();
				}
				bz.setTs(bz.getTs());
				bz.setMoney(bz.getMoney());
				bz.setQtmoney(bz.getQtmoney());
				bz.setSummoney(bz.getSummoney());
				baseDao.save(bz);
			}
		}
		
	}
	@Override
	public void doTransUpdateStu(Student stu) {
		stu.setUser(stu.getUser());
		stu.setTutor(stu.getTutor());
		stu.setProject(stu.getProject());
		stu.setSummoney(stu.getSummoney());
		stu.setBztime(stu.getBztime());
		try {
			stu.setBeginTime(subMonth(stu.getBztime()));//上个月19号
			stu.setEndTime(endtime(stu.getBztime()));//下个月18号
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		List<Studentbz> newbzlist = stu.getBzlist();
		String sql = "select a from Studentbz a where a.student.id=:AID";
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", stu.getId());
		List<Studentbz> bzlist = (List<Studentbz>) baseDao.findObjectList(sql, resultMap);
		
		for (Studentbz studentbz : bzlist) {
			baseDao.delete(studentbz);
		}
		baseDao.update(stu);
		
		if(newbzlist !=null ){
			for (Studentbz bz : newbzlist) {
				bz.setId(Generator.getUUID());
				bz.setUser(bz.getUser());
				bz.setStudent(stu);
				try {
					bz.setBeginTime(subMonth(stu.getBztime()));//上个月19号
					bz.setEndTime(endtime(stu.getBztime()));//下个月18号
				} catch (ParseException e) {
					e.printStackTrace();
				}
				bz.setTs(bz.getTs());
				bz.setMoney(bz.getMoney());
				bz.setQtmoney(bz.getQtmoney());
				bz.setSummoney(bz.getSummoney());
				baseDao.save(bz);
			}
		}
	}
	/**** 
     * 传入具体日期 ，返回具体日期减一个月。 上个月19号
     * @throws ParseException 
     */  
    private Date subMonth(Date date) throws ParseException {  
        Calendar rightNow = Calendar.getInstance();  
        rightNow.setTime(date);  
        rightNow.add(Calendar.MONTH, -1);
        rightNow.add(Calendar.DATE, 18);//加18天,19号
        Date dt1 = rightNow.getTime();  
        return dt1;  
    }
    private Date endtime(Date date) throws ParseException {  
        Calendar rightNow = Calendar.getInstance();  
        rightNow.setTime(date);  
        rightNow.add(Calendar.DATE, 17);//加17天,这月18号
        Date dt1 = rightNow.getTime();  
        return dt1;  
    }

	@SuppressWarnings("unchecked")
	@Override
	public Student doJoinTransFindUserById(String id) {
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("AID", id);
		
		String sql1 = "select s from Student s left join fetch s.user left join fetch s.project where s.id = :AID";
		Student stu = baseDao.findObject(sql1, resultMap);
		
		String sql = "select a from Studentbz a left join fetch a.user where a.student.id=:AID";
		
		List<Studentbz> bzlist = (List<Studentbz>) baseDao.findObjectList(sql, resultMap);
		
		stu.setBzlist(bzlist);
		return stu;
	}

	@Override
	public void doTransAudit(String id, int status) {
		String sql = "select a from Student a where a.id = :AID";
		Map<String,Object> paramMap = new HashMap();
		paramMap.put("AID",id);
		Student stu =  baseDao.findObject(sql, paramMap);
		
		stu.setStatus(status);
		baseDao.update(stu);
		
	}

	@Override
	public List<Student> doJoinTransFindStudent() {
		String sql = "select u from Student u left join fetch u.user left join fetch u.userGroup left join fetch u.project order by u.endTime desc";
		List<Student> lists = (List<Student>) baseDao.findObjectList(sql, null);
		return lists;
	}

	@Override
	public List<Student> doJoinTransFindbz(String tutor,Date bztime) {
		Map<String,Object> paramMap = new HashMap();
		Date begintime = null;
		Date endtime = null;
		try {
			begintime = subMonth(bztime);//开始时间
			endtime = endtime(bztime);//结束时间
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String sql = "select s from Student s where s.tutor = :TUTOR and s.beginTime = :BEGINTIME and s.endTime = :ENDTIME";
		paramMap.put("TUTOR", tutor);
		paramMap.put("BEGINTIME", begintime);
		paramMap.put("ENDTIME",endtime);
		List<Student> lists = (List<Student>) baseDao.findObjectList(sql, paramMap);
		return lists;
	}
	@Override
	public List<Student> doJoinTransFindbz(String id,String userid,Date bztime) {
		Map<String,Object> paramMap = new HashMap();
		Date begintime = null;
		Date endtime = null;
		try {
			begintime = subMonth(bztime);//开始时间
			endtime = endtime(bztime);//结束时间
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String sql = "select s from Student s where s.id <> :ID and s.user.id = :USERID and s.beginTime = :BEGINTIME and s.endTime = :ENDTIME";
		paramMap.put("ID", id);
		paramMap.put("USERID", userid);
		paramMap.put("BEGINTIME", begintime);
		paramMap.put("ENDTIME",endtime);
		List<Student> lists = (List<Student>) baseDao.findObjectList(sql, paramMap);
		return lists;
	}

}
