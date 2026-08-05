package org.example.demo;

public class Invoice extends PaymentDue {

	private String description;
	/**
	 * An identifier that can be used in PaymentReceipt
	 */
	private String paymentCat = "INVOICE";

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}