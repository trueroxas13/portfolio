package org.example.demo;

import org.junit.BeforeClass;
import org.junit.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class VehicleOwnerTest {
    private static VehicleOwner testOwner;

    @BeforeClass
    public static void setup(){
        testOwner = new VehicleOwner();
    }

    @Test
    public void exceptionTesting(){
        Throwable exception = assertThrows(IllegalArgumentException.class, () -> testOwner.setQid("A"));
        assertEquals("QID must be an integer value", exception.getMessage());
    }
}
