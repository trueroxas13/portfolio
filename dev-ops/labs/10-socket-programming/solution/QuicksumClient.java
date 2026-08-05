import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class QuicksumClient {
  public static void main(String[] args) {
    try (Socket socket = new Socket("localhost", 3333);
         BufferedReader input =
             new BufferedReader(new InputStreamReader(socket.getInputStream()));
         PrintWriter output = new PrintWriter(socket.getOutputStream());
         BufferedReader console =
             new BufferedReader(new InputStreamReader(System.in))) {
      System.out.printf("Connected to %s:%s%n", socket.getInetAddress(),
                        socket.getPort());
      socket.setSoTimeout(2000);

      while (true) {
        String message = input.readLine();
        if (message == null) {
          break;
        }
        System.out.println(message);
        output.println(console.readLine());
        output.flush();
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}