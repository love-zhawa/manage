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
@Table(name = "assets_borrow")
public class AssetsBorrow implements java.io.Serializable {

	private static final long serialVersionUID = 2547929043560790671L;
	private String id;
	private String person;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date time;
	private String dd;
	private String bz;
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	
	private String assetsname;
	private Assets assets;
	
	@Column(name = "assetsname")
	public String getAssetsname() {
		return assetsname;
	}
	public void setAssetsname(String assetsname) {
		this.assetsname = assetsname;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "assets_id")
	public Assets getAssets() {
		return assets;
	}
	public void setAssets(Assets assets) {
		this.assets = assets;
	}
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Column(name = "person")
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	@Column(name = "time")
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	@Column(name = "dd")
	public String getDd() {
		return dd;
	}
	public void setDd(String dd) {
		this.dd = dd;
	}
	@Column(name = "bz")
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
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