package current;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HexFormat;
import java.util.List;

import static java.lang.Thread.sleep;

public class User implements Runnable {
    public static int TICKET_COUNTER;
    public final Socket socket; // User's connection to the server
    private String nickname; // User's nickname
    private String ticket; // User's unique ticket
    private String currentRoom; // Room the user is in

    public User(Socket socket) {
        this.socket = socket;
    }

    public void run (){
        try (
                BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                PrintWriter output = new PrintWriter(socket.getOutputStream(), true)
        ) {
            //handle the command responses here, not server
            //start with identifying the client
            output.println("ident");
            String identResponse = input.readLine();
            if (identResponse.equals("DNI")){
                //issue a new ticket
                output.println("[Server : " + Client.timestamp() + "] : Provide a nickname: ");
                String nickname;
                while ((nickname = input.readLine()).isEmpty()){
                    output.println("[Server : " + Client.timestamp() + "] : (ERROR) The nickname must comprise of at least 1 character.");
                }
                //this generates the ticket, and saves it in server memory and in a json file
                Ticket t = pseudo(nickname);
                //send the ticket to the client instance in case they want to save it

                output.println(t.ticket);
            } else {
                //search for the saved ticket and 'log in' the user
                String[] command_keys = identResponse.split(" ");
                Ticket t = ticket(command_keys[1]);
                if (t != null) {
                    //'log in' the user
                    synchronized (Server.getUsers()){
                        this.nickname = t.pseudonym;
                        this.ticket = t.ticket;
                        //update the user on the server
                        Server.removeUser(this);
                        Server.addUser(this);
                        System.out.println(Server.getUsers().size() + " hello");
                    }
                    output.println("[Server : " + Client.timestamp() + "] : Welcome " + nickname + "!\n");
                } else {
                    System.out.println("Something went wrong. Could not locate ticket.\n");
                }
            }

            //once identified, allow client to interact with the server via requests/commands

                String command;
                while ((command = input.readLine()) != null) {
                    String[] keys = command.split(" ");
                    System.out.println(command);
                    boolean valid = false;
                    switch (keys[0]) {
                        case "pseudo":
                            Ticket gen = pseudo(keys[1]);
                            valid = true;
                            break;
                        case "ticket":
                            Ticket t = ticket(keys[1]);
                            if (t != null) {
                                output.println("Welcome " + nickname + "!\n");
                                valid = true;
                            }
                            break;
                        case "join":
                            valid = join(keys[1]);
                            if (valid) {
                                output.println("join "+ keys[1] + " " + nickname );
                            }
                            break;
                        case "leave":
                            valid = leave(keys[1]);
                            if (valid) {
                                output.println("leave "+ keys[1] + " " + nickname );
                            }
                            break;
                        case "kick":
                            valid = kick(keys[1], keys[2], keys[3]);
                            break;
                        case "send":
                            keys = command.split(" ", 2);
                            valid = send(keys[1], keys[2]);
                            break;
                        case "direct":
                            keys = command.split(" ", 2);
                            valid = direct(keys[1], keys[2]);
                            break;
                        case "menu":
                            output.println("menu");
                            switch (keys[1]) {
                                case "users":
                                    List<User> users = getUsers();
                                    for (User user : users) {
                                        output.println( "MENU :" + users.indexOf(user) +1 + " - " + user.nickname);
                                    }
                                    break;
                                case "rooms":
                                    List<Room> rooms = getRooms();
                                    for (Room room : rooms) {
                                        output.println( "MENU :" +rooms.indexOf(room) +1 + " - " + room.name);
                                    }
                                    break;
                            }
                            break;
                        default:
                            output.println(Client.timestamp() + ": Invalid command/syntax.");
                    }
                    if (!valid) {
                        output.println("Bad syntax for " + keys[0] + ".");
                    }
                    sleep(250);
                }

        } catch (IOException e) {
            System.err.println("User error: " + e.getMessage());
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        } finally {
            if (currentRoom != null) {
                synchronized (Server.getRooms()) {
                    leave(currentRoom);
                }
            }
            try {
                socket.close(); // Close the connection
            } catch (IOException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
    private Ticket pseudo(String pseudonym){
        TICKET_COUNTER++;
        String ticket = generate(pseudonym);
        Ticket t = new Ticket(pseudonym, ticket);
        synchronized (Server.getUsers()) {
            this.ticket = t.ticket;
            this.nickname = pseudonym;
            //update the user on server
            Server.removeUser(this);
            Server.addUser(this);
        }
        try {
            //we save the ticket on the server regardless of the client choosing to save it
            //this method also updates the server's ticket array list
            Server.SaveTicket(t);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return t;
    }
    //ticket command, validation happens using separate booleans at runtime
    private Ticket ticket (String ticket) {
        synchronized (Server.getTickets()) {
            for (Ticket t : Server.getTickets()) {
                if (t.ticket.equals(ticket)) {
                    return t;
                }
            }
        }
        throw new RuntimeException("Ticket not found: " + ticket);
    }

    private boolean join (String room){
        synchronized (Server.getRooms()) {
            for (Room r : Server.getRooms()) {
                if (r.name.equals(room)) {
                    //add the user to the required room
                    r.addUser(this);
                    //update the local room change
                    this.currentRoom = r.name;
                    synchronized (Server.getUsers()) {
                        //update the current room on server for this user
                        Server.removeUser(this);
                        Server.addUser(this);
                    }
                    return true;
                }
            }
            Room newRoom = new Room(room, this);
            synchronized (Server.getRooms()) {
                Server.addRoom(newRoom);
                currentRoom = room;
                return true;
            }
        }
    }

    private boolean leave (String room){
        synchronized (Server.getRooms()) {
            for (Room r : Server.getRooms()) {
                if (r.name.equals(room)) {
                    //remove the user from the room and update room state on server
                    r.removeUser(this);
                    Server.removeRoom(r);
                    Server.addRoom(r);

                    //reflect the changes personally and on the server
                    synchronized (Server.getUsers()) {
                        for (User u : Server.getUsers()) {
                            if (u.ticket.equals(this.ticket)) {
                                u.currentRoom = null;
                                currentRoom = null;
                                break;
                            }
                        }
                    }
                    return true;
                }
            }
        }
        System.out.println("Room not found: " + room);
        return false;
    }

    private boolean kick (String room, String userPseudonym, String reason){
        synchronized (Server.getUsers()) {
            for (User u : Server.getUsers()) {
                if (u.nickname.equals(userPseudonym) && u.currentRoom == null) {
                    System.out.println("User " + userPseudonym + " is not in any room.");
                    return false;
                } else if(u.nickname.equals(userPseudonym) && u.currentRoom.equals(room)) {
                    System.out.println("Kicked " + userPseudonym + " from room '" + room + "' for reason: " + reason);
                    u.currentRoom = null;
                    //reflect the changes globally
                    synchronized (Server.getRooms()) {
                        for (Room r : Server.getRooms()) {
                            if (r.name.equals(room)) {
                                r.removeUser(u);
                                break;
                            }
                        }
                    }
                    return true;
                }
            }
        }
        System.out.println("Bad syntax for kick.");
        return false;
    }
    public static List<User> getUsers (){
        System.out.println(Server.getUsers().size());
        return Server.getUsers();
    }

    public static List<Room> getRooms (){
        return Server.getRooms();
    }

    private boolean send (String room, String message) {
        return false;
    }

    private boolean direct(String user, String message) {
        return false;
    }

    private static String generate(String seq) {
        byte[] hash = String.format("%32s", seq).getBytes();
        try {
            for (int i = 0; i < Math.random() * 64 + 1; ++i) {
                hash = MessageDigest.getInstance("SHA-256").digest(hash);
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return HexFormat.ofDelimiter(":").formatHex(hash).toString().substring(78);
    }

    public String getNickname() {
        return nickname;
    }

    public String getTicket() {
        return ticket;
    }

    public String getCurrentRoom() {
        return currentRoom;
    }

    public void setCurrentRoom(String currentRoom) {
        this.currentRoom = currentRoom;
    }
}
