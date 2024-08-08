package workbenchconnector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


public class workbenchconnector {
	public static void main(String[] args) {
		Connection con=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_application_db", "root", "Shaikma@2408");
			String sql = "INSERT INTO admin (username, password) VALUES ('Mastan', 'Shaikma@2408')";
            PreparedStatement statement = con.prepareStatement(sql);
			if(con!=null) {
				System.out.println("database is connected");
			}
			      int rows = statement.executeUpdate();

	            if (rows > 0) {
	                System.out.println("Entered successfully");
	            } else {
	                System.out.println("Error in inserting");
	            }
		}
		catch(Exception e) {
			System.out.println("not connected");
		}
	}

}

