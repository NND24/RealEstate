package batdongsan.models;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "News")
public class NewsModel {
	@Id
	private String newsId;
	private String title;
	private String thumbnail;
	private Date dateUploaded;
	private Date dateEnded;
	private String shortDescription;
	private String description;
	private boolean status;
	
	@ManyToOne
	@JoinColumn(name = "idWritter")
	private EmployeeModel employee;
	
	
	
	public NewsModel() {
		super();
	}
	
	public NewsModel(String newsId, String title, String thumbnail, Date dateUploaded, Date dateEnded,
			String shortDescription, String description, boolean status, EmployeeModel employee) {
		super();
		this.newsId = newsId;
		this.title = title;
		this.thumbnail = thumbnail;
		this.dateUploaded = dateUploaded;
		this.dateEnded = dateEnded;
		this.shortDescription = shortDescription;
		this.description = description;
		this.status = status;
		this.employee = employee;
	}
	public String getNewsId() {
		return newsId;
	}
	public void setNewsId(String newsId) {
		this.newsId = newsId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public Date getDateUploaded() {
		return dateUploaded;
	}
	public void setDateUploaded(Date dateUploaded) {
		this.dateUploaded = dateUploaded;
	}
	public Date getDateEnded() {
		return dateEnded;
	}
	public void setDateEnded(Date dateEnded) {
		this.dateEnded = dateEnded;
	}
	public String getShortDescription() {
		return shortDescription;
	}
	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public boolean getStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public EmployeeModel getEmployee() {
		return employee;
	}
	public void setEmployee(EmployeeModel employee) {
		this.employee = employee;
	}
	
	
}
