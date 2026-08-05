package org.example.demo;

import java.io.Serializable;

public class Owner {
    private String Name;
    private String QID;

    public Owner(String name, String QID) {
        Name = name;
        this.QID = QID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getQID() {
        return QID;
    }

    public void setQID(String QID) {
        this.QID = QID;
    }

    @Override
    public String toString() {
        return "Owner{" +
                "Name='" + Name + '\'' +
                ", QID='" + QID + '\'' +
                '}';
    }
}
