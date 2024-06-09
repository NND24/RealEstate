package batdongsan.models;

import java.sql.Date;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;


@Entity
@Table(name = "Employee")
public class EmployeeModel {
	@Id
	private String id;
	private String fullname;
	private String email;
	private String password;
	private String cccd;
	private String birthday;
	private String address;
	private String phoneNumber;
	private Date createDate;
	private Date deleteDate;
	private boolean status;
	
	@OneToMany(mappedBy = "employee", fetch = FetchType.EAGER)
	private Collection<NewsModel> news;
	
	@OneToOne(mappedBy = "employee", fetch = FetchType.EAGER)
	private PermissionModel permission;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getCccd() {
		return cccd;
	}
	public void setCccd(String cccd) {
		this.cccd = cccd;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getDeleteDate() {
		return deleteDate;
	}
	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public Collection<NewsModel> getNews() {
		return news;
	}
	public void setNews(Collection<NewsModel> news) {
		this.news = news;
	}
	public PermissionModel getPermission() {
		return permission;
	}
	public void setPermission(PermissionModel permission) {
		this.permission = permission;
	}
	
}
