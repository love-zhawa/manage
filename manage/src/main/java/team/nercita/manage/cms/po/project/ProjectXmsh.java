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
@Table(name = "project_xmsh")
public class ProjectXmsh implements java.io.Serializable {

	private static final long serialVersionUID = 2547929043560790671L;
	private String id;
	private String number;//维修单号
	private Project project;//使用项目
	private String bxdept;//保修单位
	private String bxperson;//报修人
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date bxtime;//报修时间
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date buytime;//购买日期
	private String wxtype;//维修类型（1返厂维修，2现场维护，3售后更换）
	private String isbxq;//是否在保修期范围内（1是 2否）
	private String bxsb;//保修设备
	private String sbgz;//设备故障
	private String wxperson;//维修人
	private String bgperson;//报告人
	private String result;//故障处理结果
	private String wxreport;//维修报告
	private String bz;//备注
	private Double wxmoney;//维修金额
	private Double dzmoney;//到账金额
	private Double nomoney;//未到账
	private String dzdw;//到账单位
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date dztime;//到账时间
	
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Column(name = "number")
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	@Column(name = "bxdept")
	public String getBxdept() {
		return bxdept;
	}
	public void setBxdept(String bxdept) {
		this.bxdept = bxdept;
	}
	@Column(name = "bxperson")
	public String getBxperson() {
		return bxperson;
	}
	public void setBxperson(String bxperson) {
		this.bxperson = bxperson;
	}
	@Column(name = "bxtime")	
	public Date getBxtime() {
		return bxtime;
	}
	public void setBxtime(Date bxtime) {
		this.bxtime = bxtime;
	}
	@Column(name = "buytime")
	public Date getBuytime() {
		return buytime;
	}
	public void setBuytime(Date buytime) {
		this.buytime = buytime;
	}
	@Column(name = "wxtype")
	public String getWxtype() {
		return wxtype;
	}
	public void setWxtype(String wxtype) {
		this.wxtype = wxtype;
	}
	@Column(name = "isbxq")
	public String getIsbxq() {
		return isbxq;
	}
	public void setIsbxq(String isbxq) {
		this.isbxq = isbxq;
	}
	@Column(name = "bxsb")
	public String getBxsb() {
		return bxsb;
	}
	public void setBxsb(String bxsb) {
		this.bxsb = bxsb;
	}
	@Column(name = "sbgz")
	public String getSbgz() {
		return sbgz;
	}
	public void setSbgz(String sbgz) {
		this.sbgz = sbgz;
	}
	@Column(name = "wxperson")
	public String getWxperson() {
		return wxperson;
	}
	public void setWxperson(String wxperson) {
		this.wxperson = wxperson;
	}
	@Column(name = "bgperson")
	public String getBgperson() {
		return bgperson;
	}
	public void setBgperson(String bgperson) {
		this.bgperson = bgperson;
	}
	@Column(name = "result")
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	@Column(name = "wxreport")
	public String getWxreport() {
		return wxreport;
	}
	public void setWxreport(String wxreport) {
		this.wxreport = wxreport;
	}
	@Column(name = "bz")
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
	}
	@Column(name = "wxmoney")
	public Double getWxmoney() {
		return wxmoney;
	}
	public void setWxmoney(Double wxmoney) {
		this.wxmoney = wxmoney;
	}
	@Column(name = "dzmoney")
	public Double getDzmoney() {
		return dzmoney;
	}
	public void setDzmoney(Double dzmoney) {
		this.dzmoney = dzmoney;
	}
	@Column(name = "nomoney")
	public Double getNomoney() {
		return nomoney;
	}
	public void setNomoney(Double nomoney) {
		this.nomoney = nomoney;
	}
	@Column(name = "dzdw")
	public String getDzdw() {
		return dzdw;
	}
	public void setDzdw(String dzdw) {
		this.dzdw = dzdw;
	}
	@Column(name = "dztime")
	public Date getDztime() {
		return dztime;
	}
	public void setDztime(Date dztime) {
		this.dztime = dztime;
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
	
}