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
@Table(name = "HCMStreets")
public class HCMStreetsModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int streetId;
	
	@ManyToOne
	@JoinColumn(name = "wardId")
	private HCMWardsModel ward;
	
	private String name;

	@OneToMany(mappedBy = "street", fetch = FetchType.EAGER)
	private Collection<HCMRealEstateModel> realEstates;

	public int getStreetId() {
		return streetId;
	}

	public void setStreetId(int streetId) {
		this.streetId = streetId;
	}

	public HCMWardsModel getWard() {
		return ward;
	}

	public void setWard(HCMWardsModel ward) {
		this.ward = ward;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Collection<HCMRealEstateModel> getRealEstates() {
		return realEstates;
	}

	public void setRealEstates(Collection<HCMRealEstateModel> realEstates) {
		this.realEstates = realEstates;
	}

}
