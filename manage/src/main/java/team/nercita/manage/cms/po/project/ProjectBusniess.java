package team.nercita.manage.cms.po.project;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import team.nercita.manage.cms.po.deptmanage.User;

@Entity
@Table(name = "project_busniess_t")
public class ProjectBusniess implements java.io.Serializable {

	private static final long serialVersionUID = 8117763370395979430L;
	private String id;
	private String bussName;//业务名称
	private String unit;//甲方单位
	private String contact;//甲方联系人1
	private String phoneNumber;//联系电话1
	//业务信息
	private String salesman;//业务员
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date contactDate;//接洽时间
	private String lastProgress;
	private Integer status;//接洽状态 接洽中/合同签订/终止
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	private String bussContent;//业务内容
	private User user;
	//项目信息
	private String ssdd;//项目实施地点
	private String jscontent;//项目建设内容(没用到)
	private String contact1;//甲方联系人2
	private String phoneNumber1;//联系电话2
	private String contact2;//甲方联系人3
	private String phoneNumber2;//联系电话3
	private String zwxx;//职务信息
	//项目来源信息
	private String lydw;//单位名称
	private String lyperson;//联系人 
	private String lyperson1;
	private String lyperson2;
	private String lyphone;//联系电话
	private String lyphone1;
	private String lyphone2;
	private String lyzwxx;//职务信息
	//实施信息
	private String xmjl;//项目经理
	private String dw;//合作单位
	private String dw1;
	private String dw2;
	private String lxr;//联系人
	private String lxr1;
	private String lxr2;
	private String lxphone;//联系电话
	private String lxphone1;
	private String lxphone2;
	private String sszt;//实施状态   实施中，实施完成
	
	
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "buss_name", length = 100)
	public String getBussName() {
		return this.bussName;
	}

	public void setBussName(String bussName) {
		this.bussName = bussName;
	}

	@Column(name = "unit", length = 50)
	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	@Column(name = "contact", length = 20)
	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	@Column(name = "phone_number", length = 20)
	public String getPhoneNumber() {
		return this.phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	@Column(name = "salesman", length = 20)
	public String getSalesman() {
		return this.salesman;
	}

	public void setSalesman(String salesman) {
		this.salesman = salesman;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "contact_date", length = 10)
	public Date getContactDate() {
		return this.contactDate;
	}

	public void setContactDate(Date contactDate) {
		this.contactDate = contactDate;
	}

	@Column(name = "last_progress", length = 200)
	public String getLastProgress() {
		return this.lastProgress;
	}

	public void setLastProgress(String lastProgress) {
		this.lastProgress = lastProgress;
	}

	@Column(name = "status")
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	@Column(name = "buss_content", length = 200)
	public String getBussContent() {
		return bussContent;
	}

	public void setBussContent(String bussContent) {
		this.bussContent = bussContent;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Column(name = "ssdd")
	public String getSsdd() {
		return ssdd;
	}

	public void setSsdd(String ssdd) {
		this.ssdd = ssdd;
	}
	@Column(name = "jscontent")
	public String getJscontent() {
		return jscontent;
	}

	public void setJscontent(String jscontent) {
		this.jscontent = jscontent;
	}
	@Column(name = "contact1")
	public String getContact1() {
		return contact1;
	}

	public void setContact1(String contact1) {
		this.contact1 = contact1;
	}
	@Column(name = "phoneNumber1")
	public String getPhoneNumber1() {
		return phoneNumber1;
	}

	public void setPhoneNumber1(String phoneNumber1) {
		this.phoneNumber1 = phoneNumber1;
	}
	@Column(name = "contact2")
	public String getContact2() {
		return contact2;
	}

	public void setContact2(String contact2) {
		this.contact2 = contact2;
	}
	@Column(name = "phoneNumber2")
	public String getPhoneNumber2() {
		return phoneNumber2;
	}

	public void setPhoneNumber2(String phoneNumber2) {
		this.phoneNumber2 = phoneNumber2;
	}
	@Column(name = "zwxx")
	public String getZwxx() {
		return zwxx;
	}

	public void setZwxx(String zwxx) {
		this.zwxx = zwxx;
	}
	@Column(name = "lydw")
	public String getLydw() {
		return lydw;
	}

	public void setLydw(String lydw) {
		this.lydw = lydw;
	}
	@Column(name = "lyperson")
	public String getLyperson() {
		return lyperson;
	}

	public void setLyperson(String lyperson) {
		this.lyperson = lyperson;
	}
	@Column(name = "lyphone")
	public String getLyphone() {
		return lyphone;
	}

	public void setLyphone(String lyphone) {
		this.lyphone = lyphone;
	}
	@Column(name = "lyperson1")
	public String getLyperson1() {
		return lyperson1;
	}

	public void setLyperson1(String lyperson1) {
		this.lyperson1 = lyperson1;
	}
	@Column(name = "lyphone1")
	public String getLyphone1() {
		return lyphone1;
	}

	public void setLyphone1(String lyphone1) {
		this.lyphone1 = lyphone1;
	}
	@Column(name = "lyperson2")
	public String getLyperson2() {
		return lyperson2;
	}

	public void setLyperson2(String lyperson2) {
		this.lyperson2 = lyperson2;
	}
	@Column(name = "lyphone2")
	public String getLyphone2() {
		return lyphone2;
	}

	public void setLyphone2(String lyphone2) {
		this.lyphone2 = lyphone2;
	}
	@Column(name = "lyzwxx")
	public String getLyzwxx() {
		return lyzwxx;
	}

	public void setLyzwxx(String lyzwxx) {
		this.lyzwxx = lyzwxx;
	}
	@Column(name = "xmjl")
	public String getXmjl() {
		return xmjl;
	}

	public void setXmjl(String xmjl) {
		this.xmjl = xmjl;
	}
	@Column(name = "dw")
	public String getDw() {
		return dw;
	}

	public void setDw(String dw) {
		this.dw = dw;
	}
	@Column(name = "dw1")
	public String getDw1() {
		return dw1;
	}

	public void setDw1(String dw1) {
		this.dw1 = dw1;
	}
	@Column(name = "dw2")
	public String getDw2() {
		return dw2;
	}

	public void setDw2(String dw2) {
		this.dw2 = dw2;
	}
	@Column(name = "lxr")
	public String getLxr() {
		return lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}
	@Column(name = "lxr1")
	public String getLxr1() {
		return lxr1;
	}

	public void setLxr1(String lxr1) {
		this.lxr1 = lxr1;
	}
	@Column(name = "lxr2")
	public String getLxr2() {
		return lxr2;
	}

	public void setLxr2(String lxr2) {
		this.lxr2 = lxr2;
	}
	@Column(name = "lxphone")
	public String getLxphone() {
		return lxphone;
	}

	public void setLxphone(String lxphone) {
		this.lxphone = lxphone;
	}
	@Column(name = "lxphone1")
	public String getLxphone1() {
		return lxphone1;
	}

	public void setLxphone1(String lxphone1) {
		this.lxphone1 = lxphone1;
	}
	@Column(name = "lxphone2")
	public String getLxphone2() {
		return lxphone2;
	}

	public void setLxphone2(String lxphone2) {
		this.lxphone2 = lxphone2;
	}
	@Column(name = "sszt")
	public String getSszt() {
		return sszt;
	}

	public void setSszt(String sszt) {
		this.sszt = sszt;
	}
	
	
	
	
}