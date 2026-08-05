package org.example.demo;

import java.time.LocalDate;

public abstract class Receipt {

	private String receiptId;
	private LocalDate date;
	private String header;

	public String getReceiptId() {
		return this.receiptId;
	}

	public void setReceiptId(String receiptId) {
		this.receiptId = receiptId;
	}

}