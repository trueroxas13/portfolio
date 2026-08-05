package org.example.demo;

import java.time.LocalDate;
import java.util.ArrayList;

public class AuthorizedWorkshop {

	private String workshopId;
	private String workshopName;
	private String location;
	private String contactDetails;
	private ArrayList<FitnessCertificate> allCertificates;

	public String getWorkshopId() {
		return this.workshopId;
	}

	public void setWorkshopId(String workshopId) {
		this.workshopId = workshopId;
	}

	public String getWorkshopName() {
		return this.workshopName;
	}

	public void setWorkshopName(String workshopName) {
		this.workshopName = workshopName;
	}

	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getContactDetails() {
		return this.contactDetails;
	}

	public void setContactDetails(String contactDetails) {
		this.contactDetails = contactDetails;
	}

	public ArrayList<FitnessCertificate> getAllCertificates() {
		return this.allCertificates;
	}

	public void setAllCertificates(ArrayList<FitnessCertificate> allCertificates) {
		this.allCertificates = allCertificates;
	}

	public void listAllCertificates() {
		// TODO - implement AuthorizedWorkshop.listAllCertificates
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param vehicle
	 * @param expiryDate
	 */
	public FitnessCertificate generateCertificate(Vehicle vehicle, LocalDate expiryDate) {
		// TODO - implement AuthorizedWorkshop.generateCertificate
		throw new UnsupportedOperationException();
	}

}