package batdongsan.models;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "RealEstate")
public class RealEstateModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int realEstateId;

	private String type;

	@ManyToOne
	@JoinColumn(name = "provinceId")
	private ProvincesModel province;

	@ManyToOne
	@JoinColumn(name = "districtId")
	private DistrictsModel district;

	@ManyToOne
	@JoinColumn(name = "wardId")
	private WardsModel ward;

	private String address;
	private String title;
	private String description;
	private int area;
	private float price;
	private String unit;
	private String interior;
	private int numberOfBedrooms;
	private int numberOfToilets;
	private String images;
	private String contactName;
	private String phoneNumber;
	private String email;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "MM/dd/yyyy")
	private Date createdDate;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "MM/dd/yyyy")
	private Date updatedDate;

	public RealEstateModel() {
		super();
	}

	public RealEstateModel(int realEstateId, String type, ProvincesModel province, DistrictsModel district,
			WardsModel ward, String address, String title, String description, int area, float price, String unit,
			String interior, int numberOfBedrooms, int numberOfToilets, String images, String contactName,
			String phoneNumber, String email, Date createdDate, Date updatedDate) {
		super();
		this.realEstateId = realEstateId;
		this.type = type;
		this.province = province;
		this.district = district;
		this.ward = ward;
		this.address = address;
		this.title = title;
		this.description = description;
		this.area = area;
		this.price = price;
		this.unit = unit;
		this.interior = interior;
		this.numberOfBedrooms = numberOfBedrooms;
		this.numberOfToilets = numberOfToilets;
		this.images = images;
		this.contactName = contactName;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.createdDate = createdDate;
		this.updatedDate = updatedDate;
	}

	public int getRealEstateId() {
		return realEstateId;
	}

	public void setRealEstateId(int realEstateId) {
		this.realEstateId = realEstateId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getArea() {
		return area;
	}

	public void setArea(int area) {
		this.area = area;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getInterior() {
		return interior;
	}

	public void setInterior(String interior) {
		this.interior = interior;
	}

	public int getNumberOfBedrooms() {
		return numberOfBedrooms;
	}

	public void setNumberOfBedrooms(int numberOfBedrooms) {
		this.numberOfBedrooms = numberOfBedrooms;
	}

	public int getNumberOfToilets() {
		return numberOfToilets;
	}

	public void setNumberOfToilets(int numberOfToilets) {
		this.numberOfToilets = numberOfToilets;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public ProvincesModel getProvince() {
		return province;
	}

	public void setProvince(ProvincesModel province) {
		this.province = province;
	}

	public DistrictsModel getDistrict() {
		return district;
	}

	public void setDistrict(DistrictsModel district) {
		this.district = district;
	}

	public WardsModel getWard() {
		return ward;
	}

	public void setWard(WardsModel ward) {
		this.ward = ward;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

}
