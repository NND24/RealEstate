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
@Table(name = "HCMDistricts")
public class HCMDistrictsModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int districtId;
	private String name;

	@OneToMany(mappedBy = "district", fetch = FetchType.EAGER)
	private Collection<HCMWardsModel> wards;

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

	public Collection<HCMWardsModel> getWards() {
		return wards;
	}

	public void setWards(Collection<HCMWardsModel> wards) {
		this.wards = wards;
	}

	

}
