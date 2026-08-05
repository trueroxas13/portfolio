package greedy;

import java.util.ArrayList;
import java.util.Scanner;

public class GreedyApproach {
	
	static boolean validInput = false;
	
	static int maxWalkingDistance = 0;
	
	static int x = 0;
	
	static boolean hasFinishedEntering = false;
	
	static FloorsPassengers stops[];
	static int stopsCounter;

	public static void main(String[] args) {
		ArrayList<Integer> input = new ArrayList<>();
		
		Scanner sc = new Scanner(System.in);
		
		System.out.println("Please enter the maximum distance you are willing to walk for your destination.");
		x = sc.nextInt();
		sc.nextLine();
		
		maxWalkingDistance = (2*x) + 1;
		
		while (!hasFinishedEntering) {
			System.out.println("Please enter the floor number:");
			int temp = sc.nextInt();
			input.add(temp);
			
			sc.nextLine();
			
			
			System.out.println("Would you like to add another floor? (Enter '0' for no, anything else for yes. NOTE: Duplicate Floors are treated as multiple passengers with the same destination!)");
			String decision = sc.next();
			
			if (decision.equals("0")) {
				hasFinishedEntering = true;
			}
		}
		
		input.sort(null);
		
		FloorsPassengers[] FP = ConstructData(input);
		
		CalculateStops(FP, 0);
		
		for (FloorsPassengers x : stops) {
			if (x != null) {
				System.out.println(x);
			}
		}
		
		sc.close();
	}

	static FloorsPassengers[] ConstructData(ArrayList<Integer> floors) {
		int current = floors.get(0);
		int countOfCurrent = 0;
		int uniques = 1;
		
		for (int i = 0; i < floors.size(); i++) {
			if (current != floors.get(i)) {
				current = floors.get(i);
				uniques++;
			}
		}
		
		current = floors.get(0);
		
		FloorsPassengers[] FP = new FloorsPassengers[uniques];
		int counter = 0;
		
		for (int j = 0; j < floors.size(); j++) {
			if (current != floors.get(j)) {
				FP[counter] = new FloorsPassengers(current, countOfCurrent);
				counter++;
				current = floors.get(j);
				countOfCurrent = 1;				
			} else {
				countOfCurrent++;
			}
			//store the final index value
			if (j == floors.size() - 1 && FP[counter - 1].floor != current) {
				FP[counter] = new FloorsPassengers(current, countOfCurrent);
			}
		}
		
		//testing purposes
		
		/*
		for (FloorsPassengers x : FP) {
			System.out.println(x.toString());
		}
		*/
		return FP;
	} 
	
	static void CalculateStops(FloorsPassengers[] FP, int index) {
		stops = new FloorsPassengers[FP.length];
		
		Calculate(FP, index);		
	}
	
	static void Calculate(FloorsPassengers[] FP, int index) {
		if (index == FP.length) {
			return;
		}
		int temp = index + 1;
		
		if (temp == FP.length) {
			stops[stopsCounter] = FP[temp-1];
			stopsCounter++;
			System.out.println("Min: " + FP[index].floor + ", Max: " + FP[temp-1].floor);
			return;
		}
		
		//the maximum gap between floors in a group
		while (FP[temp].floor - FP[index].floor < maxWalkingDistance) {
			temp = temp + 1;
			if (temp == FP.length) {
				break;
			}
		}
		
		int totalPassengers = 0;
		
		for (int i = index; i < temp; i++) {
			totalPassengers += FP[i].amountOfPassengers; 
		}
		
		stops[stopsCounter] = new FloorsPassengers((FP[temp-1].floor + FP[index].floor)/2, totalPassengers);
		stopsCounter++;
		System.out.println("Min: " + FP[index].floor + ", Max: " + FP[temp-1].floor);
		
		Calculate(FP, temp);
	}
}
