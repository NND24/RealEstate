package batdongsan.models;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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

	@ManyToOne
	@JoinColumn(name = "categoryId")
	private CategoryModel category;

	@ManyToOne
	@JoinColumn(name = "provinceId")
	private ProvincesModel province;

	@ManyToOne
	@JoinColumn(name = "districtId")
	private DistrictsModel district;

	@ManyToOne
	@JoinColumn(name = "wardId")
	private WardsModel ward;
	
	@ManyToOne
	@JoinColumn(name = "userId")
	private UsersModel user;

	private String address;
	private String title;
	private String description;
	private String typePost;
	private float area;
	private float price;
	private String unit;
	private String interior;
	private String direction;
	private int numberOfBedrooms;
	private int numberOfToilets;
	private String images;
	private String contactName;
	private String phoneNumber;
	private String email;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "MM/dd/yyyy")
	private Date submittedDate;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "MM/dd/yyyy")
	private Date expirationDate;
	
	private String status;
	private int totalMoney;

	@OneToMany(mappedBy = "realEstate", fetch = FetchType.EAGER)
	private Collection<FavouriteModel> favourite;

	public RealEstateModel() {
		super();
	}

	public int getRealEstateId() {
		return realEstateId;
	}

	public void setRealEstateId(int realEstateId) {
		this.realEstateId = realEstateId;
	}

	public CategoryModel getCategory() {
		return category;
	}

	public void setCategory(CategoryModel category) {
		this.category = category;
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

	public float getArea() {
		return area;
	}

	public void setArea(float area) {
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

	public String getTypePost() {
		return typePost;
	}

	public void setTypePost(String typePost) {
		this.typePost = typePost;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public Date getSubmittedDate() {
		return submittedDate;
	}

	public void setSubmittedDate(Date submittedDate) {
		this.submittedDate = submittedDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(int totalMoney) {
		this.totalMoney = totalMoney;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public Collection<FavouriteModel> getFavourite() {
		return favourite;
	}

	public void setFavourite(Collection<FavouriteModel> favourite) {
		this.favourite = favourite;
	}

	public UsersModel getUser() {
		return user;
	}

	public void setUser(UsersModel user) {
		this.user = user;
	}
	
	
}
