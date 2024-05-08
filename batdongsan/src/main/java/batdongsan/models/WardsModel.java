package batdongsan.models;

import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "Wards")
public class WardsModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int wardId;
	private int districtId;
	private String name;

	@OneToMany(mappedBy = "ward", fetch = FetchType.EAGER)
	private Collection<RealEstateModel> realEstates;

	public int getWardId() {
		return wardId;
	}

	public void setWardId(int wardId) {
		this.wardId = wardId;
	}

	public int getDistrictId() {
		return districtId;
	}

	public void setDistrictId(int districtId) {
		this.districtId = districtId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Collection<RealEstateModel> getRealEstates() {
		return realEstates;
	}

	public void setRealEstates(Collection<RealEstateModel> realEstates) {
		this.realEstates = realEstates;
	}

}
