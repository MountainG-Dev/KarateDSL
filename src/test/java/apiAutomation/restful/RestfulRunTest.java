package apiAutomation.restful;

import com.intuit.karate.junit5.Karate;

public class RestfulRunTest {

    @Karate.Test        // Se utiliza para instanciar un feature dentro de un mismo package Junit 5
    Karate restfulTest() {
        return Karate.run("restful-get").relativeTo(getClass());
    }
}
