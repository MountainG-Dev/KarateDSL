import com.intuit.karate.junit5.Karate;

public class AllRunners {

    @Karate.Test        // Se utiliza para instanciar un feature dentro de un mismo package Junit 5
    Karate testSample() {
        return Karate.run().relativeTo(getClass());
    }

    @Karate.Test        // Se utiliza para instanciar un feature dentro de un mismo package y con definición de tag especifico Junit 5
    Karate testTags() {
        return Karate.run("login").tags("@tag1").relativeTo(getClass());
    }

    @Karate.Test        // Se utiliza para instanciar un feature en un package diferente, con tag especifico y configuraciones extras Junit 5
    Karate testSystemProperty() {
        return Karate.run("classpath:karateUIAutomation/login.feature")
                .tags("@tag1")
                .karateEnv("e2e")
                .systemProperty("foo", "bar");
    }

}
