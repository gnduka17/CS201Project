package final_project;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateRequest
 */
@WebServlet("/UpdateRequest")
public class UpdateRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateRequest() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void close_conn(Connection conn, Statement st, ResultSet rs) {
		try {
			if(conn!=null) {
				conn.close();
			}
			if(st!=null) {
				st.close();
			}
			if(rs!=null) {
				rs.close();
			}
		}
		catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int productID = Integer.parseInt(request.getParameter("productID"));
		int buyerID = Integer.parseInt(request.getParameter("buyerID"));
		int sellerID = Integer.parseInt(request.getParameter("sellerID"));
		int index = Integer.parseInt(request.getParameter("index"));
		String path = "jdbc:mysql://google/silcData?cloudSqlInstance=cs201silcproject:us-west1:cs201group"
				+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=yongzush";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(path);
			if(index==1) {   //add to request
				boolean exists = false;
				ps = conn.prepareStatement("SELECT * FROM Transactions WHERE buyerID=?" + 
						" AND productID=?");
				ps.setInt(1, buyerID);
				ps.setInt(2, productID);
				rs = ps.executeQuery();
				while(rs.next()) { 
					exists = true;
				}
				if(!exists) {
					ps = conn.prepareStatement("INSERT INTO Transactions (productID, sellerID, buyerID) VALUES (?,?,?)");
					ps.setInt(1, productID);
					ps.setInt(2, sellerID);
					ps.setInt(3, buyerID);
					ps.executeUpdate();
				}
			}
			else if(index==2) {  //remove from request
				ps = conn.prepareStatement("DELETE FROM Transactions WHERE buyerID=? AND productID=?");
				ps.setInt(1, buyerID);
				ps.setInt(2, productID);
				ps.executeUpdate();
			}
			close_conn(conn, ps, rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
