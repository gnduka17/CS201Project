package cs201Project;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class insertItemServlet
 */
@WebServlet("/insertItemServlet")
public class insertItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public insertItemServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String prodName= request.getParameter("productName");
		String prodPrice = request.getParameter("prodprice");
		String prodCond = request.getParameter("condition");
		String prodCat = request.getParameter("category");
		String descrip = request.getParameter("productDesc");
		String fakename = "John Doe";
		Integer fakeID = 1;
		System.out.println("prodname:" + prodName);
		System.out.println("prodprice:" + prodPrice);
		System.out.println("prodcond:" + prodCond);
		System.out.println("prodcat:" + prodCat);
		System.out.println("descip:" + descrip);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://google/silcData?cloudSqlInstance=cs201silcproject:us-west1:cs201group&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=woody&password=woody");
			ps=conn.prepareStatement("INSERT INTO Product(productName,productPrice,productCondition,productDescription,productCategory,sellerID,sellerName) VALUES (?,?,?,?,?,?,?)");
			ps.setString(1, prodName);
			ps.setString(2, prodPrice);
			ps.setString(3, prodCond);
			ps.setString(4, descrip);
			ps.setString(5, prodCat);
			ps.setInt(6, fakeID);
			ps.setString(7, fakename);
			ps.execute();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();	
		}
		
		request.getRequestDispatcher("/checking.jsp").forward(request,response);
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
