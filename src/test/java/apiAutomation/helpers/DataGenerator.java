package apiAutomation.helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {

    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    public static JSONObject getRandomBookingValues(){
        Faker faker = new Faker();
        String firstname = faker.gameOfThrones().character();
        String lastname = faker.gameOfThrones().city();
        int totalprice = faker.number().randomDigit();
        boolean depositpaid = faker.bool().bool();
        String checkin = String.valueOf("2022-08-03");
        String checkout = String.valueOf("2022-08-03");
        String additionalneeds = faker.pokemon().name();
        JSONObject json = new JSONObject();
        json.put("firstname", firstname);
        json.put("lastname", lastname);
        json.put("totalprice", totalprice);
        json.put("depositpaid", depositpaid);
        json.put("checkin", checkin);
        json.put("checkout", checkout);
        json.put("additionalneeds", additionalneeds);
        return json;
    }

}
