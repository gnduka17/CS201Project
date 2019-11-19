import java.io.IOException;
import java.sql.DriverManager;
import java.util.HashMap;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// Will forward to search results page by default
		String next = "/search.jsp";
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		
		// Get search query
		String query = request.getParameter("searchInput");
		
		// Check if search query is empty
		if(query.trim().equalsIgnoreCase("")) {
			next = "homepage.jsp";
			// Set error message
			request.setAttribute("searchError", "You must enter search keywords!");
			dispatch = getServletContext().getRequestDispatcher(next);
			dispatch.forward(request, response);
		}
		
		// If the search query is not empty, split it into separate strings
		String[] keywords = query.split(" ");
		
		// Create HashMap to store results
		HashMap<Integer, Product> results = null;
		
		// Iterate over search keywords
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		for(int i = 0; i < keywords.length; i++) {
			String searchString = "SELECT * FROM Product WHERE productName LIKE '%?%'";
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://google/Lab7?cloudSqlInstance=beaming-key-255523:us-central1:sql-db-1&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=root");
				
				// Search for entry
				ps = conn.prepareStatement(searchString);
				ps.setString(1, keywords[i]);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					// Get product information
					int productID = rs.getInt("productID");
					String productName = rs.getString("productName");
					double productPrice = rs.getDouble("productPrice");
					String productCondition = rs.getString("productCondition");
					String productDescription = rs.getString("productDescription");
					String productCategory = rs.getString("productCategory");
					int userID = rs.getInt("productID");
					String sellerName = rs.getString("sellerName");
						
					// Create new Project object
					Product newProduct = new Product(productID, productName, productPrice, productCondition, productDescription, productCategory, userID, sellerName);
					
					// Insert search result into the results HashMap
					results.put(productID, newProduct);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				// Close connections
				try {
					if (rs != null) {
						rs.close();
					}
					if (ps != null) {
						ps.close();
					}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
		}
		// Set results attribute
		request.setAttribute("resultMap", results);
		
		// Forward to results page
		dispatch = getServletContext().getRequestDispatcher(next);
		dispatch.forward(request, response);
		
	}
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
