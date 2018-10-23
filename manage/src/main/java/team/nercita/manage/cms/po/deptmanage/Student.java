package team.nercita.manage.cms.po.deptmanage;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import team.nercita.manage.cms.po.projectmanage.Project;

@Entity
@Table(name = "student")
public class Student implements java.io.Serializable {

	private static final long serialVersionUID = -2458621811040821123L;
	
	private String id;
	private User user;
	private UserGroup userGroup;
	private Project project;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date beginTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date endTime;
	@DateTimeFormat(pattern = "yyyy-MM") 
	private Date bztime;//添加补助的时间
	private Double summoney;//总
	
	private String username;
	private Integer status;
	private String tutor;
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	private List<Studentbz> bzlist;

	@OneToMany(mappedBy = "student")
	public List<Studentbz> getBzlist() {
		return bzlist;
	}

	public void setBzlist(List<Studentbz> bzlist) {
		this.bzlist = bzlist;
	}
	@Column(name = "tutor")
	public String getTutor() {
		return tutor;
	}

	public void setTutor(String tutor) {
		this.tutor = tutor;
	}

	@Column(name = "bztime")
	public Date getBztime() {
		return bztime;
	}

	public void setBztime(Date bztime) {
		this.bztime = bztime;
	}
	@Column(name = "status")
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "username")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_group_id")
	public UserGroup getUserGroup() {
		return this.userGroup;
	}

	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}
	@Column(name = "beginTime", length = 19)
	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}
	@Column(name = "endTime", length = 19)
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	@Column(name = "summoney")
	public Double getSummoney() {
		return summoney;
	}

	public void setSummoney(Double summoney) {
		this.summoney = summoney;
	}

	@Column(name = "creator", length = 20)
	public String getCreator() {
		return this.creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	@Column(name = "create_time", length = 19)
	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "modifier", length = 20)
	public String getModifier() {
		return this.modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	@Column(name = "modify_time", length = 19)
	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
}