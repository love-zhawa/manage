package team.nercita.manage.cms.po.deptmanage;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "workingcalendar")
public class workingcalendar implements java.io.Serializable {

	private static final long serialVersionUID = -2458621811040821123L;
	
	private String id;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date time;
	private Integer day;//星期几
	private Integer status;//0节假日，1工作日
	private String isfj;//是什么节假日
	
	/*private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;*/

	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	@Column(name = "day")
	public Integer getDay() {
		return day;
	}

	public void setDay(Integer day) {
		this.day = day;
	}
	@Column(name = "status")
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	@Column(name = "isfj")
	public String getIsfj() {
		return isfj;
	}

	public void setIsfj(String isfj) {
		this.isfj = isfj;
	}
	@Column(name = "time")
	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	/*@Column(name = "creator", length = 20)
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
	}*/
}