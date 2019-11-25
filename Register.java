package final_project;

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
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    //CHANGE WHEN REAL DATABASE IS MADE 
	public static final String credentials = "jdbc:mysql://google/silcData?cloudSqlInstance=cs201silcproject:us-west1:cs201group&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=cs201SilCgroup&password=password";
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
    	
    	try {
    		PrintWriter out = response.getWriter();
    		
	    	PreparedStatement preparedStatement = connection1.prepareStatement("SELECT * FROM User WHERE email='" + email + "'"); 
			ResultSet rs = preparedStatement.executeQuery();
			
			session.setAttribute("loggedIn", "false");
			//Check if email is taken
			if(rs.next()) {
				
				out.println("Email is already in use"); 
				return; 
			}
			
			//Checking if email is valid 
	    	if(!Pattern.matches("[!-~]+@(usc)+[.](edu)", email)) {
	    		out.println("This is not a valid usc email. ");
	    		return; 
	    		
	    	}
	    	//Check if username is in the table 
	    	preparedStatement = connection1.prepareStatement("SELECT * FROM user WHERE username='" + username + "'"); 
	    	rs = preparedStatement.executeQuery(); 
	    	
	    	if(rs.next()) {
	    		out.println("This username is already taken");
	    		return; 
	    		
	    	}
	    	
	    	if(password.equals(confPassword)) {
	    		//buyer id and //user id 
	    		session.setAttribute("username", username);
	    		session.setAttribute("loggedIn", "true");
	    		
	    		//Insert user into database 
	    		preparedStatement = connection1.prepareStatement("INSERT INTO user(name,username,email,password,rating,ratingCount) VALUES(?,?,?,?,?,?)");
	    		preparedStatement.setString(1, fullName);
				preparedStatement.setString(2, username);
				preparedStatement.setString(3, email);
				preparedStatement.setString(4, password); 
				preparedStatement.setDouble(5,0); 
				preparedStatement.setInt(6,0); 
				
				//name,username,email,password,rating,ratingCount
				preparedStatement.execute();
	    		
				preparedStatement = connection1.prepareStatement("SELECT * FROM user WHERE username='" + username + "'"); 
		    	rs = preparedStatement.executeQuery();
		    	
		    	int id = rs.getInt("userID"); 
		    	session.setAttribute("userID", id);
		    	session.setAttribute("name", rs.getString("name"));
	    	}else {
	    		
	    		
	    		out.println("Passwords do not match"); 
	    		return;
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
