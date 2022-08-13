package uiAutomation.login;

import com.intuit.karate.junit5.Karate;

public class LoginRunTest {

    @Karate.Test        // Se utiliza para instanciar un feature dentro de un mismo package Junit 5
    Karate loginTest() {
        return Karate.run("login").relativeTo(getClass());
    }

}
