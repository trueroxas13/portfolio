package org.example.demo;

import java.time.LocalDate;

public class InsurancePolicy extends Document {

	private String policyId;
	private String vin;
	private InsuranceCompany issuingCompany;
	private double price;
	private double coverageAmount;
	private boolean status;

	public String getPolicyId() {
		return this.policyId;
	}

	public void setPolicyId(String policyId) {
		this.policyId = policyId;
	}

	public String getVin() {
		return this.vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}

	public InsuranceCompany getIssuingCompany() {
		return this.issuingCompany;
	}

	public void setIssuingCompany(InsuranceCompany issuingCompany) {
		this.issuingCompany = issuingCompany;
	}

	public double getPrice() {
		return this.price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getCoverageAmount() {
		return this.coverageAmount;
	}

	public void setCoverageAmount(double coverageAmount) {
		this.coverageAmount = coverageAmount;
	}

	public boolean isStatus() {
		return this.status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	/**
	 * 
	 * @param newEndDate
	 * @param newCoverageAmount
	 * @param newPrice
	 */
	public void renewPolicy(LocalDate newEndDate, double newCoverageAmount, double newPrice) {
		// TODO - implement InsurancePolicy.renewPolicy
		throw new UnsupportedOperationException();
	}

}