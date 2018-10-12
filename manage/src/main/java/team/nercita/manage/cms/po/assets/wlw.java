package team.nercita.manage.cms.po.assets;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;


/**
 * assets_borrow entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wlw")
public class wlw implements java.io.Serializable {

	private static final long serialVersionUID = 2547929043560790671L;
	private String id;
	private String sim;//手机卡号
	private String cgperson;//采购人
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date cgtime;//采购时间
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date sytime;//使用时间
	private String dd;//使用地点
	private String syperson;//使用人
	private String lyperson;//领用人
	private String bz;//备注
	
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	
	@Column(name = "bz")
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
	}
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Column(name = "sim")
	public String getSim() {
		return sim;
	}
	public void setSim(String sim) {
		this.sim = sim;
	}
	@Column(name = "cgperson")
	public String getCgperson() {
		return cgperson;
	}
	public void setCgperson(String cgperson) {
		this.cgperson = cgperson;
	}
	@Column(name = "cgtime")
	public Date getCgtime() {
		return cgtime;
	}
	public void setCgtime(Date cgtime) {
		this.cgtime = cgtime;
	}
	@Column(name = "sytime")
	public Date getSytime() {
		return sytime;
	}
	public void setSytime(Date sytime) {
		this.sytime = sytime;
	}
	@Column(name = "dd")
	public String getDd() {
		return dd;
	}
	public void setDd(String dd) {
		this.dd = dd;
	}
	@Column(name = "syperson")
	public String getSyperson() {
		return syperson;
	}
	public void setSyperson(String syperson) {
		this.syperson = syperson;
	}
	@Column(name = "lyperson")
	public String getLyperson() {
		return lyperson;
	}
	public void setLyperson(String lyperson) {
		this.lyperson = lyperson;
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