package org.example.demo;

import java.util.List;
import java.util.NoSuchElementException;

public class VehiclesIterator implements Iterator<Vehicle> {
    private int currentIndex = 0;
    private List<Vehicle> Vehicles;

    public VehiclesIterator(List<Vehicle> Vehicles) {
        this.Vehicles = Vehicles;
    }

    @Override
    public boolean hasNext() {
        return currentIndex < Vehicles.size();
    }

    @Override
    public Vehicle next() {
        if (!hasNext()) {
            throw new NoSuchElementException();
        }
        return Vehicles.get(currentIndex++);
    }

    public void setCurrentIndex(int currentIndex) {
        this.currentIndex = currentIndex;
    }
}
