package team.nercita.manage.cms.po.jxc;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

//已经出库的产品再入库
@Entity
@Table(name = "income_log")
public class IncomeLog implements java.io.Serializable {

	private static final long serialVersionUID = -5653874343877757825L;
	private String id;
	private String rkid;//入库id
	private String rktype;//入库类型
	private String cknumber;//出库编号
	private String cpname;//产品名称
	private String type;//规格 型号
	private Integer amount;//入库数量
	private String home;//生产厂家
	private String bz;//备注
	private Integer status;//状态，2是已经出库
	
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;

	@Column(name = "status")
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "rkid")
	public String getRkid() {
		return rkid;
	}
	public void setRkid(String rkid) {
		this.rkid = rkid;
	}
	@Column(name = "rktype")
	public String getRktype() {
		return rktype;
	}

	public void setRktype(String rktype) {
		this.rktype = rktype;
	}
	@Column(name = "cknumber")
	public String getCknumber() {
		return cknumber;
	}

	public void setCknumber(String cknumber) {
		this.cknumber = cknumber;
	}
	@Column(name = "cpname")
	public String getCpname() {
		return cpname;
	}

	public void setCpname(String cpname) {
		this.cpname = cpname;
	}
	@Column(name = "type")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	@Column(name = "amount")
	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	@Column(name = "home")
	public String getHome() {
		return home;
	}
	public void setHome(String home) {
		this.home = home;
	}
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
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
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