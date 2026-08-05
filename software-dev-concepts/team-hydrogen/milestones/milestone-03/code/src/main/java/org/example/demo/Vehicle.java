package org.example.demo;

import java.time.LocalDate;

public class Vehicle {

	private Registration registration;
	private String vin;
	private int manufactureYear;
	private String vehicleMake;
	private String model;
	private VehicleOwner previousOwner;
	private VehicleOwner currentOwner;
	private FitnessCertificate fitnessCertificate;
	private InsuranceCompany insurancePolicy;
	private ConfiscationOrder confiscationOrder;
	private LocalDate datePurchased;

	public Vehicle(Registration registration, String vin, int manufactureYear, String vehicleMake, String model, VehicleOwner previousOwner, VehicleOwner currentOwner, FitnessCertificate fitnessCertificate, InsuranceCompany insurancePolicy, ConfiscationOrder confiscationOrder, LocalDate datePurchased) {
		this.registration = registration;
		this.vin = vin;
		this.manufactureYear = manufactureYear;
		this.vehicleMake = vehicleMake;
		this.model = model;
		this.previousOwner = previousOwner;
		this.currentOwner = currentOwner;
		this.fitnessCertificate = fitnessCertificate;
		this.insurancePolicy = insurancePolicy;
		this.confiscationOrder = confiscationOrder;
		this.datePurchased = datePurchased;
	}

	public Registration getRegistration() {
		return this.registration;
	}

	public void setRegistration(Registration registration) {
		this.registration = registration;
	}

	public String getVin() {
		return this.vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}

	public int getManufactureYear() {
		return this.manufactureYear;
	}

	public void setManufactureYear(int manufactureYear) {
		this.manufactureYear = manufactureYear;
	}

	public String getVehicleMake() {
		return this.vehicleMake;
	}

	public void setVehicleMake(String vehicleMake) {
		this.vehicleMake = vehicleMake;
	}

	public String getModel() {
		return this.model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public VehicleOwner getPreviousOwner() {
		return this.previousOwner;
	}

	public void setPreviousOwner(VehicleOwner previousOwner) {
		this.previousOwner = previousOwner;
	}

	public VehicleOwner getCurrentOwner() {
		return this.currentOwner;
	}

	public void setCurrentOwner(VehicleOwner currentOwner) {
		this.currentOwner = currentOwner;
	}

	public FitnessCertificate getFitnessCertificate() {
		return this.fitnessCertificate;
	}

	public void setFitnessCertificate(FitnessCertificate fitnessCertificate) {
		this.fitnessCertificate = fitnessCertificate;
	}

	public InsuranceCompany getInsurancePolicy() {
		return this.insurancePolicy;
	}

	public void setInsurancePolicy(InsuranceCompany insurancePolicy) {
		this.insurancePolicy = insurancePolicy;
	}

	public ConfiscationOrder getConfiscationOrder() {
		return this.confiscationOrder;
	}

	public void setConfiscationOrder(ConfiscationOrder confiscationOrder) {
		this.confiscationOrder = confiscationOrder;
	}

	public LocalDate getDatePurchased() {
		return this.datePurchased;
	}

	public void setDatePurchased(LocalDate datePurchased) {
		this.datePurchased = datePurchased;
	}

	/**
	 * 
	 * @param newOwner
	 */
	public void transferOwnership(VehicleOwner newOwner) {
		// TODO - implement Vehicle.transferOwnership
		throw new UnsupportedOperationException();
	}

	public int getVehicleAge() {
		// TODO - implement Vehicle.getVehicleAge
		throw new UnsupportedOperationException();
	}

	public boolean isRegistered() {
		// TODO - implement Vehicle.isRegistered
		throw new UnsupportedOperationException();
	}

	public void generateOwnershipReport() {
		// TODO - implement Vehicle.generateOwnershipReport
		throw new UnsupportedOperationException();
	}


}