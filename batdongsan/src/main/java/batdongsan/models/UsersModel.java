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
@Table(name = "Users")
public class UsersModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userId;
	private String name;
	private String email;
	private String password;
	private String avatar;
	private String taxCode;
	private String phonenumber;
	private int accountBalance;
	private boolean status;
	

	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<FavouriteModel> favourite;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<HCMRealEstateModel> realEstate;

	public UsersModel() {
		super();
	}

	public UsersModel(int userId, String name, String avatar, String taxCode, String phonenumber) {
		super();
		this.userId = userId;
		this.name = name;
		this.avatar = avatar;
		this.taxCode = taxCode;
		this.phonenumber = phonenumber;
	}

	public UsersModel(String name, String email, String password, String avatar, String taxCode, String phonenumber) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.avatar = avatar;
		this.taxCode = taxCode;
		this.phonenumber = phonenumber;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getTaxCode() {
		return taxCode;
	}

	public void setTaxCode(String taxCode) {
		this.taxCode = taxCode;
	}

	public String getPhonenumber() {
		return phonenumber;
	}

	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}

	public Collection<FavouriteModel> getFavourite() {
		return favourite;
	}

	public void setFavourite(Collection<FavouriteModel> favourite) {
		this.favourite = favourite;
	}

	public int getAccountBalance() {
		return accountBalance;
	}

	public void setAccountBalance(int accountBalance) {
		this.accountBalance = accountBalance;
	}

	public boolean getStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
	
	

}
