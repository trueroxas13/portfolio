package org.example.demo;

import org.junit.BeforeClass;
import org.junit.jupiter.api.DisplayName;
import org.junit.Test;

import static org.junit.jupiter.api.Assertions.*;

public class FitnessCertificateTest {
    static FitnessCertificate testCertificate;

    @BeforeClass
    public static void setUp(){
        testCertificate = new FitnessCertificate(new AuthorizedWorkshop());
    }

    @Test
    @DisplayName("ID test")
    public void testId(){
        assertEquals(Integer.parseInt(testCertificate.getCertificateId()) , testCertificate.getStart() -1,
                "ID of the latest cert should be equal to the current counter - 1");
    }

    @Test
    @DisplayName("Counter test")
    public void testCounter(){
        assertNotEquals(0, testCertificate.getStart(), "The counter should never be 0");
        assertTrue( testCertificate.getStart() > 0, "The counter should never be less than 0");
    }
}
