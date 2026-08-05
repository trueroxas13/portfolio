package org.example.demo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Random;
import java.util.UUID;

public class Registration  {
    private String registrationId;
    private static int start=1;

    public Registration() {
        this.registrationId = "00"+start;
        start++;
    }

    /**
     *
     * @param newExpiryDate
     */
    public void renewRegistration(LocalDate newExpiryDate) {
        // TODO - implement Registration.renewRegistration
        throw new UnsupportedOperationException();
    }

}
