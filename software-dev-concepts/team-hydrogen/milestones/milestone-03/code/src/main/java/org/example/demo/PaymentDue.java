package org.example.demo;

import java.time.LocalDate;

public abstract class PaymentDue {

	private double paymentAmount;
	private PaymentStatus paymentStatus;
	private String paymentId;
	private LocalDate dueDate;
	private LocalDate issueDate;
	private String vin;

	public double getPaymentAmount() {
		return this.paymentAmount;
	}

	public void setPaymentAmount(double paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public void setPaymentStatus(PaymentStatus paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public String getPaymentId() {
		return this.paymentId;
	}

	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

	public LocalDate getDueDate() {
		return this.dueDate;
	}

	public void setDueDate(LocalDate dueDate) {
		this.dueDate = dueDate;
	}

	public LocalDate getIssueDate() {
		return this.issueDate;
	}

	public void setIssueDate(LocalDate issueDate) {
		this.issueDate = issueDate;
	}

	public String getVin() {
		return this.vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}

	public boolean getPaymentStatus() {
		// TODO - implement PaymentDue.getPaymentStatus
		throw new UnsupportedOperationException();
	}

	public void printDetails() {
		// TODO - implement PaymentDue.printDetails
		throw new UnsupportedOperationException();
	}

	/**
	 * Changes paymentStatus to PAID
	 */
	public void pay() {
		// TODO - implement PaymentDue.pay
		throw new UnsupportedOperationException();
	}

}