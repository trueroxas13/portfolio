package org.example.demo;

import java.time.LocalDate;

public class ConfiscationOrder {
	private static int start=1;
	private String orderId;
	private boolean confirmationStatus = false;
	private LocalDate date;

	public ConfiscationOrder( boolean confirmationStatus) {
		this.orderId = "00"+start;
		this.confirmationStatus = confirmationStatus;
		this.date = LocalDate.now();
		start++;
	}

	public String getOrderId() {
		return this.orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public boolean isConfirmationStatus() {
		return this.confirmationStatus;
	}

	public void setConfirmationStatus(boolean confirmationStatus) {
		this.confirmationStatus = confirmationStatus;
	}

	public void generateConfiscationOrder() {
		// TODO - implement ConfiscationOrder.generateConfiscationOrder
		throw new UnsupportedOperationException();
	}

	public void cancelRegistration() {
		// TODO - implement ConfiscationOrder.cancelRegistration
		throw new UnsupportedOperationException();
	}

}