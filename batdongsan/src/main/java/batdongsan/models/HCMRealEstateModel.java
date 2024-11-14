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
@Table(name = "HCMRealEstate")
public class HCMRealEstateModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int realEstateId;

	@ManyToOne
	@JoinColumn(name = "categoryId")
	private CategoryModel category;

	@ManyToOne
	@JoinColumn(name = "streetId")
	private HCMStreetsModel street;

	@ManyToOne
	@JoinColumn(name = "userId")
	private UsersModel user;

	private String address;
	private String title;
	private String description;
	private String typePost;
	private float size;
	private Long price;
	private String unit;
	private String furnishingSell;
	private String direction;
	private String balconyDirection;
	private int rooms;
	private int toilets;
	private int floors;
	private String type;
	private String propertyStatus;
	private String propertyLegalDocument;
	private String characteristics;
	private boolean urgent;
	private String images;
	private String contactName;
	private String phoneNumber;
	private String email;

	private int interestedClick;
	
	private boolean deleteStatus;

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

	public HCMRealEstateModel() {
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

	public String getBalconyDirection() {
		return balconyDirection;
	}

	public void setBalconyDirection(String balconyDirection) {
		this.balconyDirection = balconyDirection;
	}

	public int getFloors() {
		return floors;
	}

	public void setFloors(int floors) {
		this.floors = floors;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPropertyStatus() {
		return propertyStatus;
	}

	public void setPropertyStatus(String propertyStatus) {
		this.propertyStatus = propertyStatus;
	}

	public String getPropertyLegalDocument() {
		return propertyLegalDocument;
	}

	public void setPropertyLegalDocument(String propertyLegalDocument) {
		this.propertyLegalDocument = propertyLegalDocument;
	}

	public String getCharacteristics() {
		return characteristics;
	}

	public void setCharacteristics(String characteristics) {
		this.characteristics = characteristics;
	}

	public float getSize() {
		return size;
	}

	public void setSize(float size) {
		this.size = size;
	}

	public Long getPrice() {
		return price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getFurnishingSell() {
		return furnishingSell;
	}

	public void setFurnishingSell(String furnishingSell) {
		this.furnishingSell = furnishingSell;
	}

	public int getRooms() {
		return rooms;
	}

	public void setRooms(int rooms) {
		this.rooms = rooms;
	}

	public int getToilets() {
		return toilets;
	}

	public void setToilets(int toilets) {
		this.toilets = toilets;
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

	public HCMStreetsModel getStreet() {
		return street;
	}

	public void setStreet(HCMStreetsModel street) {
		this.street = street;
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

	public boolean isUrgent() {
		return urgent;
	}

	public void setUrgent(boolean urgent) {
		this.urgent = urgent;
	}

	public int getInterestedClick() {
		return interestedClick;
	}

	public void setInterestedClick(int interestedClick) {
		this.interestedClick = interestedClick;
	}

	public boolean isDeleteStatus() {
		return deleteStatus;
	}

	public void setDeleteStatus(boolean deleteStatus) {
		this.deleteStatus = deleteStatus;
	}

}
