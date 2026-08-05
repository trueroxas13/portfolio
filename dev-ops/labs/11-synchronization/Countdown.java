public class Countdown {
  public void printCount() {
    try {
      for (int i = 10; i > 0; i--) {
        System.out.println(" --- " + i);
      }
      System.out.println("Blast off!");
    } catch (Exception e) {
      System.out.println("Thread interrupted.");
    }
  }
}