package org.example.demo;

import java.io.Serializable;

public class Report  {
    private String firstVIN;
    private String secondVIN;
    private String time;
    private String date;
    private String location;
    private String offendingVIN;
    private String victimVIN;
    private Boolean confirmation;
    private Boolean acknowledgement;

    public Report(Boolean acknowledgement,Boolean confirmation,String victimVIN,String offendingVIN,String location, String date, String time, String secondVIN, String firstVIN) {
        this.acknowledgement=acknowledgement;
        this.confirmation=confirmation;
        this.victimVIN=victimVIN;
        this.offendingVIN=offendingVIN;
        this.location =location;
        this.date = date;
        this.time = time;
        this.secondVIN = secondVIN;
        this.firstVIN = firstVIN;
    }
    public Report() {

    }

    public String getFirstVIN() {
        return firstVIN;
    }

    public void setFirstVIN(String firstVIN) {
        this.firstVIN = firstVIN;
    }

    public String getSecondVIN() {
        return secondVIN;
    }

    public void setSecondVIN(String secondVIN) {
        this.secondVIN = secondVIN;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getOffendingVIN() {
        return offendingVIN;
    }

    public void setOffendingVIN(String offendingVIN) {
        this.offendingVIN = offendingVIN;
    }

    public String getVictimVIN() {
        return victimVIN;
    }

    public void setVictimVIN(String victimVIN) {
        this.victimVIN = victimVIN;
    }

    @Override
    public String toString() {
        return "First vehicle VIN: "+getFirstVIN()+"\n"+"Second vehicle VIN: "+getSecondVIN()+"\n"+"Accident date: "+getDate()+"\n"+"Accident time: "+getTime()+"\n"+"Accident location: "+getLocation()+"\n"+"Offending vehicle VIN: "+getOffendingVIN()+"\n"+"Victim vehicle VIN: "+getVictimVIN();
    }
}
