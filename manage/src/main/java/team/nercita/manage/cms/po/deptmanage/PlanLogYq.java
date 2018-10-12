package team.nercita.manage.cms.po.deptmanage;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "plan_log_yq")
public class PlanLogYq implements java.io.Serializable {

	private static final long serialVersionUID = -2458621811040821123L;
	
	private String id;
	private WorkPlan workPlan;
	private String yy;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date newEndTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date oldEndTime;
	
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "plan_id")
	public WorkPlan getWorkPlan() {
		return workPlan;
	}

	public void setWorkPlan(WorkPlan workPlan) {
		this.workPlan = workPlan;
	}

	@Column(name = "yy")
	public String getYy() {
		return yy;
	}

	public void setYy(String yy) {
		this.yy = yy;
	}
	@Column(name = "newEndTime", length = 19)
	public Date getNewEndTime() {
		return newEndTime;
	}

	public void setNewEndTime(Date newEndTime) {
		this.newEndTime = newEndTime;
	}
	@Column(name = "oldEndTime", length = 19)
	public Date getOldEndTime() {
		return oldEndTime;
	}

	public void setOldEndTime(Date oldEndTime) {
		this.oldEndTime = oldEndTime;
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