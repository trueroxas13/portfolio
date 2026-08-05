package org.example.demo;

interface Aggregate<T> {
    Iterator<T> createIterator();
}

