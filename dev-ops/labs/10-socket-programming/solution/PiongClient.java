import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class PiongClient {
  public static void main(String[] args) {
    try {
      Socket socket = new Socket("localhost", 13333);
      BufferedReader input =
          new BufferedReader(new InputStreamReader(socket.getInputStream()));
      PrintWriter output = new PrintWriter(socket.getOutputStream(), true);
      Scanner console = new Scanner(System.in);

      String request, reply;
      do {
        request = console.nextLine();
        output.println(request);
        reply = input.readLine();
        System.out.println(reply);
      } while (request != null && reply != null);

      console.close();
      output.close();
      input.close();
      socket.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}