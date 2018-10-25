/*
 * Attendance.java
 * 创建者：侯建玮
 * 创建日期：2017年12月18日 下午3:47:18
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.po.sign;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import team.nercita.manage.cms.po.assets.Assets;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.po.form.ApplyLeave;

/**
 * 
 * @author 侯建玮
 * @date： 2017年12月18日 下午3:47:18
 */
@Entity
@Table(name = "attendance_t")
public class Attendance implements java.io.Serializable {

	private static final long serialVersionUID = -5650934545828885680L;
	
	private String id;
	private Date attendanceTime;
	
	private Date attendanceTime2;
	private int times;
	private String addr;
	
	private String addr2;
	private User user;
	private String creator;
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	private Date dkTime;
	
	private Integer iscd;//是否迟到1迟到   0正常
	private Integer iszt;//是否早退1早退  0正常
	private ApplyLeave qingjia;
	
	@Column(name = "iscd")
	public Integer getIscd() {
		return iscd;
	}

	public void setIscd(Integer iscd) {
		this.iscd = iscd;
	}
	@Column(name = "iszt")
	public Integer getIszt() {
		return iszt;
	}

	public void setIszt(Integer iszt) {
		this.iszt = iszt;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "qingjia_id")
	public ApplyLeave getQingjia() {
		return qingjia;
	}

	public void setQingjia(ApplyLeave qingjia) {
		this.qingjia = qingjia;
	}

	@Column(name = "dktime", length = 19)
	public Date getDkTime() {
		return dkTime;
	}

	public void setDkTime(Date dkTime) {
		this.dkTime = dkTime;
	}

	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Column(name = "times")
	public int getTimes() {
		return times;
	}

	public void setTimes(int times) {
		this.times = times;
	}
	@Column(name = "attendance_time2", length = 19)
	public Date getAttendanceTime2() {
		return attendanceTime2;
	}

	public void setAttendanceTime2(Date attendanceTime2) {
		this.attendanceTime2 = attendanceTime2;
	}

	@Column(name = "attendance_time", length = 19)
	public Date getAttendanceTime() {
		return attendanceTime;
	}

	public void setAttendanceTime(Date attendanceTime) {
		this.attendanceTime = attendanceTime;
	}
	@Column(name = "addr2", length = 200)
	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	@Column(name = "addr", length = 200)
	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
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
