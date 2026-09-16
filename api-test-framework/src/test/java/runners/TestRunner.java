package runners;


import io.karatelabs.core.Runner;
import io.karatelabs.core.SuiteResult;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class TestRunner {

    @Test
    void testAll() {
        SuiteResult result = Runner.path("classpath:features")
                .outputHtmlReport(true)
                .parallel(5);
        assertTrue(result.isPassed());
    }
}
