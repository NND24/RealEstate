package batdongsan.models;

import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "HCMWards")
public class HCMWardsModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int wardId;
	
	@ManyToOne
	@JoinColumn(name = "districtId")
	private HCMDistrictsModel district;
	
	private String name;
	
	@OneToMany(mappedBy = "ward", fetch = FetchType.EAGER)
	private Collection<HCMStreetsModel> streets;

	public int getWardId() {
		return wardId;
	}

	public void setWardId(int wardId) {
		this.wardId = wardId;
	}

	public HCMDistrictsModel getDistrict() {
		return district;
	}

	public void setDistrict(HCMDistrictsModel district) {
		this.district = district;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Collection<HCMStreetsModel> getStreets() {
		return streets;
	}

	public void setStreets(Collection<HCMStreetsModel> streets) {
		this.streets = streets;
	}
}
