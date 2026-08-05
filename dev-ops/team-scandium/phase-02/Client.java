package current;

import java.io.*;
import java.net.Socket;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class Client {
    private static final String TICKET_FILE = "client/ticket.txt";

    public static void main(String[] args) {
        String generatedTicket;
        boolean ticketExists = false;
        boolean identified = false;
        String host = "localhost";
        int port = 13337;

        try (Socket socket = new Socket(host, port);
            BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter output = new PrintWriter(socket.getOutputStream(), true);
            final BufferedReader console = new BufferedReader(new InputStreamReader(System.in))) {
            generatedTicket = "";

            //handle identifying the user here
            String identityRequest = input.readLine();
            if (identityRequest.equals("ident")) {
                String ticket = getTicket();
                if (ticket != null){
                    ticketExists = true;
                    generatedTicket = ticket;
                }
                if (ticketExists) {
                    //send the identity ticket to the server
                    output.println("ticket " + ticket);
                    String response = input.readLine();

                    //print the welcome message
                    System.out.println(response);
                } else {
                    //get a new ticket issued by the server
                    output.println("DNI");
                    //server prompts for a pseudonym
                    System.out.println(input.readLine());
                    String pseudo = "";
                    while (!identified) {
                        pseudo = console.readLine();
                        output.println(pseudo);

                        generatedTicket = input.readLine();
                        System.out.println(generatedTicket);
                        if (!generatedTicket.endsWith("character.")) {
                            //setting this to true to break from the loop
                            identified = true;
                        } else {
                            //display error statement
                            System.out.println(input.readLine());
                        }
                    }
                    //server generated ticket is returned above
                    //use it later in case of needing to save the ticket via the ticket command
                    System.out.println(pseudo + ", your ticket has been generated. Don't forget to save it locally using 'ticket'!");
                }
            }


            String finalGeneratedTicket = generatedTicket;

            // thread that handles sending commands to server
            Runnable requests = () -> {
                    while (true){
                        String request;
                        try {
                            request = console.readLine();
                        } catch (IOException e) {
                            throw new RuntimeException(e);
                        }
                        if (request == null){
                            break;
                        }
                        String[] keys = request.split(" ");
                        switch (keys[0]) {
                            case "ticket":
                                ticket(finalGeneratedTicket);
                                break;
                            case "menu":
                                if (keys[1].equals("users") || keys[1].equals("rooms")) {
                                    output.println(keys[0] + " " + keys[1]);
                                } else {
                                    System.out.println(timestamp() + ": (ERROR) Bad syntax for 'menu'.");
                                }
                                break;
                            case "join":
                                output.println(keys[0] + " " + keys[1]);
                                break;
                            case "leave":
                                output.println(keys[0] + " " + keys[1]);
                                break;
                            default:
                                System.out.println(timestamp() + ": (ERROR) Invalid or bad syntax.");
                                break;
                        }
                    }
            };

            //thread that handles responses from the server
            Runnable responses = () -> {
                    while (true){
                        String response;
                        try {
                            response = input.readLine();
                        } catch (IOException e) {
                            throw new RuntimeException(e);
                        }
                        if (response == null){
                            break;
                        }
                        String[] keys = response.split(" ");
                        switch (keys[0]) {
                            case "join":
                                join(keys [1], keys [2]);
                                break;
                            case "leave":
                                leave(keys [1], keys [2]);
                                break;
                            case "MENU":
                                System.out.println( timestamp() + " : " + response);
                                break;
                        }
                    }
            };

            Thread threadReq = new Thread(requests, "ThreadReq");
            Thread threadRes = new Thread(responses, "ThreadRes");
            threadReq.start();
            threadRes.start();

            while (true){
                //keep this running to avoid closing any streams until connection terminates
            }

        } catch (IOException e) {
            System.err.println("Client error: " + e.getMessage());
        }
    }

    private static void menu (String arg){
        switch (arg.toLowerCase()){
            case "users":
                System.out.println(Server.getUsers());
                synchronized (Server.getUsers()){
                    System.out.println("There are currently " + Server.getUsers().size() + " user(s) online!");
                    for (User user : Server.getUsers()){
                        System.out.println(Server.getUsers().indexOf(user) + 1 + " - " + user.getNickname());
                    }
                }
                break;
            case "rooms":
                synchronized (Server.getRooms()){
                    if (Server.getRooms().isEmpty()){
                        System.out.println("There are no rooms currently made. Please create one using 'join <room>'!");
                        return;
                    }
                    System.out.println("There are currently " + Server.getRooms().size() + " room(s) available!");
                    for (Room room : Server.getRooms()){
                        System.out.println(Server.getRooms().indexOf(room) + 1 + " - " + room.name);
                    }
                }
                break;
            default:
                System.out.println(timestamp() + ": (ERROR) Bad syntax for 'menu'.");
        }
    }

    private static void leave (String room, String nickname){
        System.out.println(timestamp() + ": User " + nickname + " has left room " + room + "!");
    }

    private static void join (String room, String nickname){
        System.out.println(timestamp() + ": User " + nickname + " has joined room " + room + "!");
    }

    private static void kick (){

    }

    private static void room (){

    }

    private static void direct (){

    }

    private static void info (){

    }

    private static void error (){

    }

    private static void ticket (String ticket){
        try {
            Writer writer = new FileWriter(TICKET_FILE);
            writer.write(ticket);
            writer.flush();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        System.out.println(timestamp() + ": Saved ticket locally, you will log in automatically next time!");
    }

    public static String timestamp() {
        return LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
    }

    private static String getTicket() throws FileNotFoundException {
        try{
            BufferedReader input = new BufferedReader(new FileReader(TICKET_FILE));
            return input.readLine();
        } catch (FileNotFoundException e) {
            System.err.println("Ticket file not found: " + e.getMessage());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        throw new FileNotFoundException();
    }
}

