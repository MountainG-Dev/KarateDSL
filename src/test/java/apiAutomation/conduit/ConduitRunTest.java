package apiAutomation.conduit;

import com.intuit.karate.junit5.Karate;

public class ConduitRunTest {

    @Karate.Test        // Se utiliza para instanciar un feature dentro de un mismo package Junit 5
    Karate conduitTest() {
        return Karate.run("conduit-homepage").relativeTo(getClass());
    }
}
