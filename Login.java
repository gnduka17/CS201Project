

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String credentials = "jdbc:mysql://google/silcData?cloudSqlInstance=cs201silcproject:us-west1:cs201group&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=cs201SilCgroup&password=password";
	static Connection connection1 = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	initConnection(); 
    	
    	String username = (String) request.getAttribute("username"); 
    	String password = (String) request.getAttribute("password"); 
    	HttpSession session = request.getSession();
    	
    	try {
    		PreparedStatement ps = 
    			connection1.prepareStatement("SELECT * FROM user WHERE username='" 
    					+ username + "' AND password='" + password + "'");
    		ResultSet rs = ps.executeQuery(); 
    		
    		if(rs.next()) {
    			if(rs.getString("user").equals("guest")) {
    				
    				session.setAttribute("loggedIn", "guest");
    			}else {
    				session.setAttribute("loggedIn", "true");
					session.setAttribute("username", username);
				
					session.setAttribute("name", rs.getString("name")); 
					session.setAttribute("userID", rs.getInt("userID"));
    			}
    		}else {
    			PrintWriter pw = response.getWriter(); 
    			
    			pw.println("Invalid Login Information"); 
    			session.setAttribute("loggedIn", "false");
				session.setAttribute("username", "absolutelyNot");
			
				session.setAttribute("name", "absolutelyNot"); 
				session.setAttribute("userID", "absolutelyNot");
 
    		}
    	}catch(SQLException e) {
    		
    		e.printStackTrace();
    	}
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

	public static void initConnection() {
		if (connection1 != null) {
			System.out.println("[WARN] Connection has already been established.");
			return;
		}
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection1 = DriverManager.getConnection(credentials);
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
	}
}
