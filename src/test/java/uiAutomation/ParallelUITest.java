package uiAutomation;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ParallelUITest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:uiAutomation/login/login.feature")
                //.outputCucumberJson(true)
                .parallel(10);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
