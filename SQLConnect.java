package final_project;
import java.sql.Connection;
import java.sql.DriverManager;
import final_project.SQLOver;

public class SQLConnect implements SQLOver {
	
	 static Connection connection = null;
	 public static Connection getCon() {
		 try {
				Class.forName("com.mysql.jdbc.Driver");
				connection = DriverManager.getConnection(CREDENTIALS_STRING);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		 return connection;
	 }
	 
}
