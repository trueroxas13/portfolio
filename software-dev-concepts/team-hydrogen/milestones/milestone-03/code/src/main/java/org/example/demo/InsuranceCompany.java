package org.example.demo;

import java.time.LocalDate;
import java.util.ArrayList;

public class InsuranceCompany {

	private String companyId;
	private String companyName;
	private String contactDetails;
	private ArrayList<InsurancePolicy> allPolicies= new ArrayList<>();

	public InsuranceCompany(String companyId, String companyName, String contactDetails) {
		this.companyId = companyId;
		this.companyName = companyName;
		this.contactDetails = contactDetails;
	}

	public String getCompanyId() {
		return this.companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public String getCompanyName() {
		return this.companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getContactDetails() {
		return this.contactDetails;
	}

	public void setContactDetails(String contactDetails) {
		this.contactDetails = contactDetails;
	}

	public ArrayList<InsurancePolicy> getAllPolicies() {
		return this.allPolicies;
	}

	public void setAllPolicies(ArrayList<InsurancePolicy> allPolicies) {
		this.allPolicies = allPolicies;
	}

	public void listAllPolicies() {
		// TODO - implement InsuranceCompany.listAllPolicies
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param vehicle
	 * @param coverageAmount
	 * @param price
	 * @param expiryDate
	 */
	public InsurancePolicy createPolicy(Vehicle vehicle, double coverageAmount, double price, LocalDate expiryDate) {
		// TODO - implement InsuranceCompany.createPolicy
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param policyId
	 */
	public InsurancePolicy findPolicy(String policyId) {
		// TODO - implement InsuranceCompany.findPolicy
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param policyId
	 */
	public void cancelPolicy(String policyId) {
		// TODO - implement InsuranceCompany.cancelPolicy
		throw new UnsupportedOperationException();
	}

}