package org.example.demo;

import java.time.LocalDate;

public class TrafficFine extends PaymentDue {

	private Offense offenseType;
	private int qid;
	/**
	 * An identifier that can be used in PaymentReceipt
	 */
	private String paymentCat = "TRAFFIC_FINE";

	public Offense getOffenseType() {
		return this.offenseType;
	}

	public void setOffenseType(Offense offenseType) {
		this.offenseType = offenseType;
	}

	public int getQid() {
		return this.qid;
	}

	public void setQid(int qid) {
		this.qid = qid;
	}

	/**
	 * 
	 * @param fromDate
	 * @param toDate
	 */
	public void calcPeriod(LocalDate fromDate, LocalDate toDate) {
		// TODO - implement TrafficFine.calcPeriod
		throw new UnsupportedOperationException();
	}

}