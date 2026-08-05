package org.example.demo;

import java.time.LocalDate;
import java.util.ArrayList;

public class PaymentReceipt extends Receipt {

	private String creditCardNumber;
	private String creditCardName;
	/**
	 * Assumed to be valid in the receipt since checked by qPay
	 */
	private LocalDate creditCardValidity;
	private ArrayList<PaymentDue> dues;
	private String vin;

	public String getCreditCardNumber() {
		return this.creditCardNumber;
	}

	public void setCreditCardNumber(String creditCardNumber) {
		this.creditCardNumber = creditCardNumber;
	}

	public String getCreditCardName() {
		return this.creditCardName;
	}

	public void setCreditCardName(String creditCardName) {
		this.creditCardName = creditCardName;
	}

	public LocalDate getCreditCardValidity() {
		return this.creditCardValidity;
	}

	public void setCreditCardValidity(LocalDate creditCardValidity) {
		this.creditCardValidity = creditCardValidity;
	}

	public ArrayList<PaymentDue> getDues() {
		return this.dues;
	}

	public void setDues(ArrayList<PaymentDue> dues) {
		this.dues = dues;
	}

	public String getVin() {
		return this.vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}

	/**
	 * 
	 * @param paymentDues
	 */
	public double calcTotal(ArrayList<PaymentDue> paymentDues) {
		// TODO - implement PaymentReceipt.calcTotal
		throw new UnsupportedOperationException();
	}

	public void payTotal() {
		// TODO - implement PaymentReceipt.payTotal
		throw new UnsupportedOperationException();
	}

}