package apiAutomation.helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.minidev.json.JSONObject;

public class DbHandler {

    private static final String connectionUrl = "jdbc:sqlserver://database-1.crao9zjlt1n2.us-east-1.rds.amazonaws.com:1433;databse=Pubs;user=admin;password=vale2502;encrypt=true;trustServerCertificate=true";

    public static void addNewPromotionWithName(String promotion){
        try(Connection connect = DriverManager.getConnection(connectionUrl)){
            connect.createStatement().execute("INSERT INTO [Pubs].[dbo].[promotions] (promotion_name, discount, start_date, expired_date) VALUES('"+promotion+"', 0.20, '20230601', '20230701')");
        } catch (SQLException e){
            e.printStackTrace();
        }
    }

    public static JSONObject getStartAndExpiredDateFromPromotions(String promotion){
        JSONObject json = new JSONObject();

        try(Connection connect = DriverManager.getConnection(connectionUrl)){
            ResultSet rs = connect.createStatement().executeQuery("SELECT * FROM [Pubs].[dbo].[promotions] where promotion_name = '"+promotion+"'");
            rs.next();
            json.put("startDate", rs.getString("start_date"));
            json.put("expiredDate", rs.getString("expired_date"));
        } catch (SQLException e){
            e.printStackTrace();
        }
        return json;
    }
    
}
