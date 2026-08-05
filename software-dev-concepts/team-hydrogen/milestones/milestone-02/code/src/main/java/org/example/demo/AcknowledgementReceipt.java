package org.example.demo;

public class AcknowledgementReceipt extends Receipt {

	private AcknowledgedDoc acknowledgedDoc;
	private String docId;

	public AcknowledgedDoc getAcknowledgedDoc() {
		return this.acknowledgedDoc;
	}

	public void setAcknowledgedDoc(AcknowledgedDoc acknowledgedDoc) {
		this.acknowledgedDoc = acknowledgedDoc;
	}

}