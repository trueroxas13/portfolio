package org.example.demo;

import org.junit.Test;

import java.time.LocalDate;
import java.util.ArrayList;

public class Setup {

    private  ArrayList <Accident> Accidents=new ArrayList <>();
    private  ArrayList <Vehicle> Vehicles=new ArrayList <>();
    Report mainreport = new Report();
    private String Report = new String("Accident Report \nYour client was involved in an \naccident with the following information:\n");




    public  Setup() {
        InsuranceCompany ic1= new InsuranceCompany("002879","Marshal","+947 9088 6677");
        Vehicle v1 =new Vehicle(new Registration(),"2001B7F2",2011,"Ford","Mustang",new VehicleOwner("+974 3408 5789","Ahmed","200010905","Doha,63,salwa"),new VehicleOwner("+974 3499 5789","Khalid","199903090","Doha,67,lusail"),new FitnessCertificate(null),ic1,new ConfiscationOrder(true),LocalDate.of(2012,2,1) );
        Vehicle v2 =new Vehicle(new Registration(),"2001B6F6",2015,"Ford","Fucus",new VehicleOwner("+974 3789 5789","Khalid","199903090","Doha,56,wakra"),new VehicleOwner("+974 4477 5789","Hamdi","199903690","Doha,67,lusail"),new FitnessCertificate(null),ic1,new ConfiscationOrder(true),LocalDate.of(2016,4,1) );


        Vehicles.add(v1);
        Vehicles.add(v2);



    }

    public  void setReport(String... info) {

        Report r1=new Report(true,true,info[1],info[0],info[4],info[2],info[3],info[1],info[0]);
        Accident a1=new Accident("A023",LocalDate.parse(info[2]),info[4],info[0],info[1],info[5],null);
        Accidents.add(a1);
        Report = r1.toString();
        mainreport= r1;



    }
    public void changeOwner(String VIN,VehicleOwner newOwner) {
        for(int i=0;i<Vehicles.size();i++) {
            if(Vehicles.get(i).getVin().equals(VIN)) {
                Vehicles.get(i).setPreviousOwner( Vehicles.get(i).getCurrentOwner());
                Vehicles.get(i).setCurrentOwner(newOwner);

            }
        }
    }

    public boolean verifyInfo(String... info){

        for (int i=0;i<Vehicles.size();i++) {
            if(Vehicles.get(i).getVin().equals(info[0]) && Vehicles.get(i).getCurrentOwner().getQid().equals(info[1]) && Vehicles.get(i).getCurrentOwner().getName().equals(info[2])) {
                return true;
            }
        }return false;

    }
    public  String getReport() {
        return Report;
    }

    public Report getReport(String VIN) {
        return mainreport;
    }
    public Vehicle getVehicle(String VIN) {
        for(int i=0;i<Vehicles.size();i++) {
            if(Vehicles.get(i).getVin().equals(VIN)) {
                return Vehicles.get(i);
            }
        }
        return null;
    }

    public ArrayList<Vehicle> getVehicles() {
        return Vehicles;
    }
}
