package team.nercita.manage.cms.po.projectmanage;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "funds_detail_t")
public class FundsDetail implements java.io.Serializable {

	private static final long serialVersionUID = -7557093104436466172L;
	private String id;
	private Project project;
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	
	private String name;
	private Double originalBudget;
	private Double newBudget;
	private Double pay;
	private Double originalBalance;
	private Double newBalance;

	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	public Project getProject() {
		return this.project;
	}

	public void setProject(Project project) {
		this.project = project;
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

	@Column(name = "name", length = 20)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Column(name = "original_budget")
	public Double getOriginalBudget() {
		return originalBudget;
	}

	public void setOriginalBudget(Double originalBudget) {
		this.originalBudget = originalBudget;
	}
	@Column(name = "new_budget")
	public Double getNewBudget() {
		return newBudget;
	}

	public void setNewBudget(Double newBudget) {
		this.newBudget = newBudget;
	}
	@Column(name = "pay")
	public Double getPay() {
		return pay;
	}

	public void setPay(Double pay) {
		this.pay = pay;
	}
	@Column(name = "original_balance")
	public Double getOriginalBalance() {
		return originalBalance;
	}

	public void setOriginalBalance(Double originalBalance) {
		this.originalBalance = originalBalance;
	}
	@Column(name = "new_balance")
	public Double getNewBalance() {
		return newBalance;
	}

	public void setNewBalance(Double newBalance) {
		this.newBalance = newBalance;
	}

}