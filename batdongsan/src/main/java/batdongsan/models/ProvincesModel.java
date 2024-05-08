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
@Table(name = "Provinces")
public class ProvincesModel {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int provinceId;
	private String name;
	
	@OneToMany(mappedBy="province", fetch=FetchType.EAGER)
	private Collection<RealEstateModel> realEstates;
	
	public int getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(int provinceId) {
		this.provinceId = provinceId;
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
