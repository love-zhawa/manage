package team.nercita.manage.cms.po.project;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import team.nercita.manage.cms.po.projectmanage.Project;


/**
 * project_xmsh entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "project_cpsh")
public class ProjectCpsh implements java.io.Serializable {

	private static final long serialVersionUID = 2547929043560790671L;
	private String id;
	private String ly;//来源：1销售和2项目，销售自己填写，项目关联
	private String project;//项目  --销售
	private String projectnumber;//项目编号  --销售
	
	private Project projects;
	private String sbname;//设备名称
	private String sbtype;//设备类型
	private String sbhome;//生产厂家
	private String sbnumber;//设备编号
	private String dw;//使用单位
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date cctime;//出厂日期
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date oldtime;//上次维护时间
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date gztime;//发现故障时间
	private String person;//施工人员
	private String bxms;//报修描述
	
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	
	private String gzms1;//故障描述   工程小组
	private String jjff1;//解决方法
	private String suggest1;//处理建议
	private String gzms2;//故障描述    生产小组
	private String jjff2;//解决方法
	private String suggest2;//处理建议
	private String gzms3;//故障描述   研发小组
	private String jjff3;//解决方法
	private String suggest3;//处理建议
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	public Project getProjects() {
		return projects;
	}
	public void setProjects(Project projects) {
		this.projects = projects;
	}
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Column(name = "ly")
	public String getLy() {
		return ly;
	}
	public void setLy(String ly) {
		this.ly = ly;
	}
	@Column(name = "project")
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	@Column(name = "project_number")
	public String getProjectnumber() {
		return projectnumber;
	}
	public void setProjectnumber(String projectnumber) {
		this.projectnumber = projectnumber;
	}
	@Column(name = "sbname")
	public String getSbname() {
		return sbname;
	}
	public void setSbname(String sbname) {
		this.sbname = sbname;
	}
	@Column(name = "sbtype")
	public String getSbtype() {
		return sbtype;
	}
	public void setSbtype(String sbtype) {
		this.sbtype = sbtype;
	}
	@Column(name = "sbhome")
	public String getSbhome() {
		return sbhome;
	}
	public void setSbhome(String sbhome) {
		this.sbhome = sbhome;
	}
	@Column(name = "sbnumber")
	public String getSbnumber() {
		return sbnumber;
	}
	public void setSbnumber(String sbnumber) {
		this.sbnumber = sbnumber;
	}
	@Column(name = "dw")
	public String getDw() {
		return dw;
	}
	public void setDw(String dw) {
		this.dw = dw;
	}
	@Column(name = "cctime")
	public Date getCctime() {
		return cctime;
	}
	public void setCctime(Date cctime) {
		this.cctime = cctime;
	}
	@Column(name = "oldtime")
	public Date getOldtime() {
		return oldtime;
	}
	public void setOldtime(Date oldtime) {
		this.oldtime = oldtime;
	}
	@Column(name = "gztime")
	public Date getGztime() {
		return gztime;
	}
	public void setGztime(Date gztime) {
		this.gztime = gztime;
	}
	@Column(name = "person")
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	@Column(name = "bxms")
	public String getBxms() {
		return bxms;
	}
	public void setBxms(String bxms) {
		this.bxms = bxms;
	}
	@Column(name = "creator", length = 32)
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
	
	@Column(name = "gzms1")
	public String getGzms1() {
		return gzms1;
	}
	public void setGzms1(String gzms1) {
		this.gzms1 = gzms1;
	}
	@Column(name = "jjff1")
	public String getJjff1() {
		return jjff1;
	}
	public void setJjff1(String jjff1) {
		this.jjff1 = jjff1;
	}
	@Column(name = "suggest1")
	public String getSuggest1() {
		return suggest1;
	}
	public void setSuggest1(String suggest1) {
		this.suggest1 = suggest1;
	}
	@Column(name = "gzms2")
	public String getGzms2() {
		return gzms2;
	}
	public void setGzms2(String gzms2) {
		this.gzms2 = gzms2;
	}
	@Column(name = "jjff2")
	public String getJjff2() {
		return jjff2;
	}
	public void setJjff2(String jjff2) {
		this.jjff2 = jjff2;
	}
	@Column(name = "suggest2")
	public String getSuggest2() {
		return suggest2;
	}
	public void setSuggest2(String suggest2) {
		this.suggest2 = suggest2;
	}
	@Column(name = "gzms3")
	public String getGzms3() {
		return gzms3;
	}
	public void setGzms3(String gzms3) {
		this.gzms3 = gzms3;
	}
	@Column(name = "jjff3")
	public String getJjff3() {
		return jjff3;
	}
	public void setJjff3(String jjff3) {
		this.jjff3 = jjff3;
	}
	@Column(name = "suggest3")
	public String getSuggest3() {
		return suggest3;
	}
	public void setSuggest3(String suggest3) {
		this.suggest3 = suggest3;
	}
	
	
}