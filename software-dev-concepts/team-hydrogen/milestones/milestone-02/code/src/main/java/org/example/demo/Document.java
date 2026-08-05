package org.example.demo;

import java.time.LocalDate;

public abstract class Document {

	private LocalDate issueDate;
	private LocalDate expiryDate;
	private String description;
	private boolean valid = true;

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	public void printDetails() {
		// TODO - implement Document.printDetails
		throw new UnsupportedOperationException();
	}

	public boolean isValid() {
		return this.valid;
	}

}