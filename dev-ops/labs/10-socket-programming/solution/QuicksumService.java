import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Random;

public class QuicksumService implements Runnable {
  private static final long TIMEOUT = 60 * (long)1000;
  private static final Random generator = new Random();
  private Socket client;

  public QuicksumService(Socket client) { this.client = client; }

  public void run() {
    try (BufferedReader input =
             new BufferedReader(new InputStreamReader(client.getInputStream()));
         PrintWriter output = new PrintWriter(client.getOutputStream(), true)) {
      long start = System.currentTimeMillis();
      int correct = 0;

      while (System.currentTimeMillis() - start < TIMEOUT) {
        int[] numbers = {generator.nextInt(10), generator.nextInt(10),
                         generator.nextInt(10)};

        output.printf("What is %d + %d + %d?%n", numbers[0], numbers[1],
                      numbers[2]);
        output.flush();

        int answer = Integer.parseInt(input.readLine());
        if (answer == numbers[0] + numbers[1] + numbers[2]) {
          correct += 1;
          output.print("Correct! ");
        } else {
          output.print("Incorrect! ");
        }
      }
      output.printf("%d correct answers.%n", correct);
    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      try {
        client.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
}