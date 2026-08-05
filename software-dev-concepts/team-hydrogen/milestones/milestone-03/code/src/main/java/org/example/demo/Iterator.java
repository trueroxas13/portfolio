package org.example.demo;

interface Iterator<T> {
    boolean hasNext();
    T next();
    void setCurrentIndex(int currentIndex);
}
