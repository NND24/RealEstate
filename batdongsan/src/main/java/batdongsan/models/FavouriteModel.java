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
	private RealEstateModel realEstate;

	public FavouriteModel() {
		super();
	}

	public FavouriteModel(UsersModel user, RealEstateModel realEstate) {
		super();
		this.user = user;
		this.realEstate = realEstate;
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

	public RealEstateModel getRealEstate() {
		return realEstate;
	}

	public void setRealEstate(RealEstateModel realEstate) {
		this.realEstate = realEstate;
	}

}
