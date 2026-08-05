package org.example.demo;

import java.time.LocalDate;

public class FitnessCertificate extends Document {
	private static int start =1;
	private String certificateId;

	private AuthorizedWorkshop workshop;

	public FitnessCertificate(  AuthorizedWorkshop workshop) {
		this.certificateId = "00"+start;

		this.workshop = workshop;
		start++;
	}

	public String getCertificateId() {
		return this.certificateId;
	}

	public void setCertificateId(String certificateId) {
		this.certificateId = certificateId;
	}



	public AuthorizedWorkshop getWorkshop() {
		return this.workshop;
	}

	public void setWorkshop(AuthorizedWorkshop workshop) {
		this.workshop = workshop;
	}

	/**
	 * 
	 * @param newExpiryDate
	 */
	public void renewCertificate(LocalDate newExpiryDate) {
		// TODO - implement FitnessCertificate.renewCertificate
		throw new UnsupportedOperationException();
	}

	public int getStart(){
		return start;
	}
}