package greedy;

public class FloorsPassengers {
	int floor;
	int amountOfPassengers;
	public FloorsPassengers(int floor, int amount){
		this.floor = floor;
		this.amountOfPassengers = amount;
	}
	
	public String toString() {
		return ("floor: " + this.floor + ", count: " + this.amountOfPassengers);
	}
}
