package org.example.demo;

import org.junit.Test;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Setup implements Aggregate<Vehicle> {

    private  ArrayList <Accident> Accidents=new ArrayList <>();
    private List<Vehicle> Vehicles=new ArrayList <>();
    Report mainreport = new Report();
    private String report = new String("Accident Report \nYour client was involved in an accident \nwith the following information:\n");
    public Iterator<Vehicle> iterator;




    public  Setup() {
        InsuranceCompany ic1= new InsuranceCompany("002879","Marshal","+947 9088 6677");
        Vehicle v1 =new Vehicle(new Registration(),"2001B7F2",2011,"Ford","Mustang",new VehicleOwner("+974 3408 5789","Ahmed","200010905","Doha,63,salwa"),new VehicleOwner("+974 3499 5789","Khalid","199903090","Doha,67,lusail"),new FitnessCertificate(null),ic1,new ConfiscationOrder(true),LocalDate.of(2012,2,1) );
        Vehicle v2 =new Vehicle(new Registration(),"2001B6F6",2015,"Ford","Focus",new VehicleOwner("+974 3789 5789","Khalid","199903090","Doha,56,wakra"),new VehicleOwner("+974 4477 5789","Hamdi","199903690","Doha,67,lusail"),new FitnessCertificate(null),ic1,new ConfiscationOrder(true),LocalDate.of(2016,4,1) );


        Vehicles.add(v1);
        Vehicles.add(v2);
        Iterator<Vehicle> iterator = this.createIterator();
        this.iterator = iterator;



    }

    public  void setReport(String... info) {

        Report r1=new Report(true,true,info[1],info[0],info[4],info[2],info[3],info[1],info[0]);
        Accident a1=new Accident("A023",LocalDate.parse(info[2]),info[4],info[0],info[1],info[5],null);
        Accidents.add(a1);
        report = report+r1.toString();
        mainreport= r1;



    }

public void changeOwner(String VIN,VehicleOwner newOwner) {
    while(iterator.hasNext()) {
        Vehicle v1 = iterator.next();
        if(v1.getVin().equals(VIN)) {
            v1.setPreviousOwner( v1.getCurrentOwner());
            v1.setCurrentOwner(newOwner);

        }
    }
    iterator.setCurrentIndex(0);
}

    public boolean verifyInfo(String... info){

        while(iterator.hasNext())  {
            Vehicle v1 = iterator.next();
            if(v1.getVin().equals(info[0]) && v1.getCurrentOwner().getQid().equals(info[1]) && v1.getCurrentOwner().getName().equals(info[2])) {
                iterator.setCurrentIndex(0);
                return true;
            }
        }iterator.setCurrentIndex(0);
        return false;

    }
    public  String getReport() {
        return report;
    }

    public Report getReport(String VIN) {
        return mainreport;
    }

    public Vehicle getVehicle(String VIN) {
        while(iterator.hasNext()) {
            Vehicle v = iterator.next();
            if( v.getVin().equals(VIN)) {
                iterator.setCurrentIndex(0);
                return  v;
            }
        }
        iterator.setCurrentIndex(0);
        return null;
    }

    public List<Vehicle> getVehicles() {
        return Vehicles;
    }

    @Override
    public Iterator<Vehicle> createIterator() {
        return new VehiclesIterator(Vehicles);
    }
}
