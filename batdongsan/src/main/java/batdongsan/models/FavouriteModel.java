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
@Table(name = "Favourite")
public class FavouriteModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int favouriteId;

	@ManyToOne
	@JoinColumn(name = "userId")
	private UsersModel user;

	@ManyToOne
	@JoinColumn(name = "realEstateId")
	private HCMRealEstateModel realEstate;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "MM/dd/yyyy")
	private Date addedDate;

	public FavouriteModel() {
		super();
	}

	public FavouriteModel(UsersModel user, HCMRealEstateModel realEstate, Date addedDate) {
		super();
		this.user = user;
		this.realEstate = realEstate;
		this.addedDate = addedDate;
	}

	public int getFavouriteId() {
		return favouriteId;
	}

	public void setFavouriteId(int favouriteId) {
		this.favouriteId = favouriteId;
	}

	public UsersModel getUser() {
		return user;
	}

	public void setUser(UsersModel user) {
		this.user = user;
	}

	public HCMRealEstateModel getRealEstate() {
		return realEstate;
	}

	public void setRealEstate(HCMRealEstateModel realEstate) {
		this.realEstate = realEstate;
	}

	public Date getAddedDate() {
		return addedDate;
	}

	public void setAddedDate(Date addedDate) {
		this.addedDate = addedDate;
	}
	
	
}
