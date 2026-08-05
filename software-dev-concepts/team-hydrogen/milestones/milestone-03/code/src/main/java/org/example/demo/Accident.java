package org.example.demo;

import java.time.LocalDate;

public class Accident {

	private String caseNumber;
	private LocalDate date;
	private String location;
	private String offendingVehicleVin;
	private String victimVehicleVin;
	private String description;
	private String policeLoginInfo;

	public Accident(String caseNumber, LocalDate date, String location, String offendingVehicleVin, String victimVehicleVin, String description, String policeLoginInfo) {
		this.caseNumber = caseNumber;
		this.date = date;
		this.location = location;
		this.offendingVehicleVin = offendingVehicleVin;
		this.victimVehicleVin = victimVehicleVin;
		this.description = description;
		this.policeLoginInfo = policeLoginInfo;
	}

	public String getCaseNumber() {
		return this.caseNumber;
	}

	public void setCaseNumber(String caseNumber) {
		this.caseNumber = caseNumber;
	}

	public LocalDate getDate() {
		return this.date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getOffendingVehicleVin() {
		return this.offendingVehicleVin;
	}

	public void setOffendingVehicleVin(String offendingVehicleVin) {
		this.offendingVehicleVin = offendingVehicleVin;
	}

	public String getVictimVehicleVin() {
		return this.victimVehicleVin;
	}

	public void setVictimVehicleVin(String victimVehicleVin) {
		this.victimVehicleVin = victimVehicleVin;
	}

	public String getPoliceLoginInfo() {
		return this.policeLoginInfo;
	}

	public void setPoliceLoginInfo(String PoliceLoginInfo) {
		this.policeLoginInfo = PoliceLoginInfo;
	}

	public void confirmFault() {
		// TODO - implement Accident.confirmFault
		throw new UnsupportedOperationException();
	}

}