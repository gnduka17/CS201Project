
public class Product {
	
	private int productID;
	private String productName;
	private double productPrice;
	private String productCondition;
	private String productDescription;
	private String productCategory;
	private int userID;
	private String sellerName;
	
	public Product(int productID, String productName, double productPrice, String productCondition,
			String productDescription, String productCategory, int userID, String sellerName) {
		this.productID = productID;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productCondition = productCondition;
		this.productDescription = productDescription;
		this.productCategory = productCategory;
		this.userID = userID;
		this.sellerName = sellerName;
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public double getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(double productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductCondition() {
		return productCondition;
	}

	public void setProductCondition(String productCondition) {
		this.productCondition = productCondition;
	}
	
	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}
	
	public String getSellerName() {
		return sellerName;
	}

	public void sellerName(String sellerName) {
		this.sellerName = sellerName;
	}
}
