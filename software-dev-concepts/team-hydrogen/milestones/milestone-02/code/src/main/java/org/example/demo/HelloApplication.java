package org.example.demo;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Pos;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.paint.Paint;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;
import javafx.stage.Stage;

import javax.swing.*;
import java.io.*;
import java.util.ArrayList;


public class HelloApplication extends Application {


    public void start(Stage stage) {
        Stage newWindow = new Stage();
        Setup setup=new Setup();

        VBox root = new VBox();
        Button b1 = new Button("Transfer registered vehicle");
        Button b2 = new Button("Report accident");

        b1.setOnAction((e)->{
            Stage newWindow1 = new Stage();
            VBox root2 = new VBox();
            Label l1,l2,l3,outcome;
            TextField tf1,tf2,tf3;
            Button b3;
            l1=new Label("Enter VIN:");
            l2= new Label("Enter QID:");
            l3= new Label("Enter Name:");
            tf1=new TextField();
            tf1.setMaxSize(200,20);
            tf2=new TextField();
            tf2.setMaxSize(200,20);
            tf3=new TextField();
            tf3.setMaxSize(200,20);
            b3=new Button("Confirm");
            outcome= new Label("");

            b3.setOnAction((r)->{

                boolean flag= setup.verifyInfo(tf1.getText(),tf2.getText(),tf3.getText());
                if(!flag){

                    outcome.setText("Incorrect Information Entered");
                    outcome.setTextFill(Color.RED);
                    tf1.clear();
                    tf2.clear();
                    tf3.clear();
                    stage.close();

                }else {


                    VBox root3 = new VBox();
                    Label l4, l5;
                    TextField tf4, tf5;
                    Button b4;
                    l4 = new Label("Enter new owner QID:");
                    l5 = new Label("Enter new owner name:");

                    tf4 = new TextField();
                    tf4.setMaxSize(200, 20);
                    tf5 = new TextField();
                    tf5.setMaxSize(200, 20);

                    b4 = new Button("Confirm");

                    b4.setOnAction((s) -> {
                        setup.changeOwner(tf1.getText(), new VehicleOwner(null, tf5.getText(), tf4.getText(), null));
                        VBox root5 = new VBox();
                        Button b6 = new Button("Close");
                        b6.setOnAction((k) -> {
                            newWindow.close();
                            stage.close();

                        });
                        Label label = new Label("New owner QID is: " + tf4.getText() + "\n" + "New owner name is: " + tf5.getText());
                        label.setWrapText(true);
                        System.out.println(setup.getVehicle(tf1.getText()));

                        root5.getChildren().addAll(label, b6);
                        root5.setStyle("-fx-alignment: center;");
                        Scene scene2 = new Scene(root5, 320, 240);
                        newWindow.setTitle("iQVR");
                        newWindow.setScene(scene2);

                    });

                    root3.getChildren().addAll(l4, tf4, l5, tf5, b4);
                    root3.setStyle("-fx-alignment: center;");
                    root3.setSpacing(5);

                    b4.setMaxSize(100, 20);
                    Scene scene2 = new Scene(root3, 320, 240);
                    newWindow.setTitle("iQVR");
                    newWindow.setScene(scene2);


                }});
            b3.setAlignment(Pos.BASELINE_LEFT);
            root2.getChildren().addAll(outcome,l1,tf1,l2,tf2,l3,tf3,b3);
            root2.setStyle("-fx-alignment: center;");
            root2.setSpacing(5);


            b3.setMaxSize(100,20);
            Scene scene2 = new Scene(root2, 320, 240);


            newWindow.setTitle("iQVR");
            newWindow.setScene(scene2);

            // Show the stage
            newWindow.show();



        });

        b2.setOnAction((e)->{
            VBox rootx = new VBox();
            Label l1,l2;
            TextField tf1,tf2;
            Button b3;
            l1=new Label("Enter first vehicle VIN:");
            l2= new Label("Enter second vehicle VIN:");

            tf1=new TextField();
            tf1.setMaxSize(200,20);
            tf2=new TextField();
            tf2.setMaxSize(200,20);
            b3=new Button("Confirm");
            b3.setOnAction((r)->{

                VBox root3 = new VBox();
                Label l4,l5,l6,l7;
                TextField tf4,tf5,tf6,tf7;
                Button b4;
                l4=new Label("Enter accident Date:");
                l5= new Label("Enter accident Time:");
                l6= new Label("Enter accident location:");
                l7= new Label("Enter accident description:");
                tf4=new TextField();
                tf4.setMaxSize(200,20);
                tf4.setPromptText(" yyyy-MM-dd ");
                tf5=new TextField();
                tf5.setMaxSize(200,20);
                tf5.setPromptText(" hh:mm ");
                tf6=new TextField();
                tf6.setMaxSize(200,20);
                tf6.setPromptText("  City, Zone, Street ");
                tf7=new TextField();
                tf7.setMaxSize(200,20);
                tf7.setPromptText(" description: ");

                b4=new Button("Confirm");
                b4.setOnAction((s)->{

                    VBox root4 = new VBox();
                    Label l8 = new Label("Please confirm provided information:");
                    Button b5=new Button("Confirm");

                    b5.setOnAction((z)->{
                        VBox root5 = new VBox();
                        Button b6=new Button("Send acknowledgement");
                        setup.setReport(tf1.getText(),tf2.getText(), tf4.getText(), tf5.getText(), tf6.getText(),tf7.getText());
                        Label label = new Label(setup.getReport());
                        label.setWrapText(true);
                        b6.setOnAction((x)->{
                            stage.close();
                                });
                        root5.getChildren().addAll(label,b6);
                        root5.setStyle("-fx-alignment: center;");
                        Scene scene2 = new Scene(root5, 320, 240);
                        stage.setTitle("iQVR");
                        stage.setScene(scene2);
                        System.out.println(setup.getReport(tf1.getText()));
                            });
                    root4.getChildren().addAll(l8,b5);
                    root4.setStyle("-fx-alignment: center;");
                    Scene scene2 = new Scene(root4, 320, 240);
                    stage.setTitle("iQVR");
                    stage.setScene(scene2);
                        });
                root3.getChildren().addAll(l4,tf4,l5,tf5,l6,tf6,l7,tf7,b4);
                root3.setStyle("-fx-alignment: center;");
                root3.setSpacing(5);

                b4.setMaxSize(100,20);
                Scene scene2 = new Scene(root3, 320, 240);
                stage.setTitle("iQVR");
                stage.setScene(scene2);

            });

            rootx.getChildren().addAll(l1,tf1,l2,tf2,b3);
            rootx.setStyle("-fx-alignment: center;");
            rootx.setSpacing(5);

            b3.setMaxSize(100,20);
            Scene scenex = new Scene(rootx, 320, 240);
            stage.setTitle("iQVR");
            stage.setScene(scenex);
        });
        root.getChildren().add(b1);
        root.getChildren().add(b2);
        root.setSpacing(20);

        root.setAlignment(Pos.CENTER);

        FXMLLoader fxmlLoader = new FXMLLoader(HelloApplication.class.getResource("hello-view.fxml"));
        Scene scene = new Scene(root, 320, 240);
        stage.setTitle("iQVR");
        stage.setScene(scene);
        stage.show();
    }



    private void openNewWindow() {
        Text newWindowText = new Text("Incorrect Information Entered");
        newWindowText.setFont(Font.font("Tahoma", 20)); // Set the font

        // Create a Button
        Button b1 = new Button("Back");

        // Create a VBox layout and center its content
        VBox newWindowLayout = new VBox(20); // 20 is the spacing between elements
        newWindowLayout.getChildren().addAll(newWindowText, b1);
        newWindowLayout.setStyle("-fx-alignment: center;"); // Center content in VBox

        // Create a Scene
        Scene newWindowScene = new Scene(newWindowLayout, 400, 300);

        b1.setOnAction((s)-> {

                });
        // Set up the new stage
        Stage newWindow = new Stage();
        newWindow.setTitle("iQVR");
        newWindow.setScene(newWindowScene);

        // Show the stage
        newWindow.show();
    }









    public static void main(String[] args) {
        launch();
    }
}