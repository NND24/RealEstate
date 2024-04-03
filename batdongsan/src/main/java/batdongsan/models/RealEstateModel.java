package batdongsan.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "RealEstate")
public class RealEstateModel {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int realEstateId;
	private String type;
	private int provinceId;
	private int districtId;
	private int wardId;
	private String address;
	private String title;
	private String description;
	private int area;
	private int price;
	private String unit;
	private String interior;
	private int numberOfBedrooms;
	private int numberOfToilets;
	private String images;
	private String contactName;
	private String phoneNumber;
	private String email;
	
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
	public int getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(int provinceId) {
		this.provinceId = provinceId;
	}
	public int getDistrictId() {
		return districtId;
	}
	public void setDistrictId(int districtId) {
		this.districtId = districtId;
	}
	public int getWardId() {
		return wardId;
	}
	public void setWardId(int wardId) {
		this.wardId = wardId;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
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

	
}
