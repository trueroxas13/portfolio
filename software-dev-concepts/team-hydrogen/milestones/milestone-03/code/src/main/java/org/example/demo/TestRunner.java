package org.example.demo;

import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

public class TestRunner {
    public static void main(String[] args) {
        Result res = JUnitCore.runClasses(FitnessCertificateTest.class, VehicleOwnerTest.class);

        for (Failure failure : res.getFailures()) {
            System.out.println(failure.toString());
        }
        System.out.println("Number of tests performed: " + res.getRunCount());
        System.out.println("Number of tests ignored: " + res.getIgnoreCount());
        System.out.println("Number of tests failed: " + res.getFailureCount());
        System.out.println("Overall test conclusion: " + res.wasSuccessful());
    }
}
