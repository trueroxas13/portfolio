package org.example.demo;

import java.util.ArrayList;

public class VehicleOwner {

	private String contactInfo;
	private String name;
	private String qid;
	private String address;
	private ArrayList<PaymentDue> paymentDues;

	public VehicleOwner(String contactInfo, String name, String qid, String address) {
		this.contactInfo = contactInfo;
		this.name = name;
		this.qid = qid;
		this.address = address;
	}

	public VehicleOwner(){}

	public String getContactInfo() {
		return this.contactInfo;
	}

	public void setContactInfo(String contactInfo) {
		this.contactInfo = contactInfo;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getQid() {
		return this.qid;
	}

	public void setQid(String qid) {
		try{
			Integer.parseInt(qid);
			this.qid = qid;
		} catch (NumberFormatException e){
			throw new IllegalArgumentException("QID must be an integer value");
		}
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public ArrayList<PaymentDue> getPaymentDues() {
		return this.paymentDues;
	}

	public void setPaymentDues(ArrayList<PaymentDue> paymentDues) {
		this.paymentDues = paymentDues;
	}

	public boolean isCurrentOwner() {
		// TODO - implement VehicleOwner.isCurrentOwner
		throw new UnsupportedOperationException();
	}

	public void getOwnerDetails() {
		// TODO - implement VehicleOwner.getOwnerDetails
		throw new UnsupportedOperationException();
	}

	/**
	 * Lists PaymentDues
	 */
	public void viewPaymentDues() {
		// TODO - implement VehicleOwner.viewPaymentDues
		throw new UnsupportedOperationException();
	}

}