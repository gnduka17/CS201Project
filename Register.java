

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    //CHANGE WHEN REAL DATABASE IS MADE 
	public static final String credentials = "jdbc:mysql://google/lab_db?cloudSqlInstance=cs201-lab7-255501:us-central1:csci-201&socke" + 
			"tFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=default" + 
			"&password=default";
	static Connection connection1 = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	initConnection(); 
    	HttpSession session = request.getSession();
    	
    	String fullName = (String) request.getAttribute("fullName"); 
    	
    	String username = (String) request.getAttribute("username");
    	String email = (String) request.getAttribute("email"); 
    	String password = (String) request.getAttribute("password"); 
    	String confPassword = (String) request.getAttribute("confirmPassword"); 
    	
    	if(!Pattern.matches("[!-~]+@(usc)+[.](edu)", email)) {
    		
    		
    	}
    	//Check if username is in the table 
    	PrintWriter out = response.getWriter();
    	if(password.equals(confPassword)) {
    		
    		session.setAttribute("username", username);
    		session.setAttribute("loggedIn", "true");
    		//Insert user into database 
    		
    	}else {
    		
    		out.println("Passwords do not match"); 
    		
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
