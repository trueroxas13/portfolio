import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Decorations {

  final String logo = 'assets/images/logo.svg';

  Widget buildCardButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: cardButtonStyle(
        const Color.fromARGB(255, 255, 245, 214),
      ),
      icon: Icon(icon, color: const Color(0xFFFF7F07), size: 30),
      label: cardButtonText(label),
      onPressed: onPressed,
    );
  }
  
  Widget displayCard(String info, int index) {
    return Card(
      elevation: 0.13,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Text(
          info,
          style: TextStyle(
            fontSize: 16,
            color: index % 2 == 0 ? Color.fromARGB(255,230,130,90) : Color.fromARGB(255, 57, 39, 156),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget displayCardButton(String info, int index, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Text(
            info,
            style: TextStyle(
              fontSize: 16,
              color: index % 2 == 0 ? Color.fromARGB(255,230,130,90) : Color.fromARGB(255, 57, 39, 156),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  InputDecoration fieldEntry (String label, Icon prefix){
    return InputDecoration(
      labelText: label,
      prefixIcon: prefix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder:  OutlineInputBorder(
        borderRadius:
            BorderRadius
                .circular(
                    12),
        borderSide:
            BorderSide(
          color: const Color
                  .fromARGB(
                  255,
                  230,
                  130,
                  90)
              .withAlpha(
                  77),
        ),
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius:
            BorderRadius
                .circular(
                    12),
        borderSide:
            BorderSide(
          color: const Color
              .fromARGB(
              255,
              230,
              130,
              90),
          width: 2,
        ),
      ),
    );
  }

  Animate buttonText (String label){
    return Text('  $label  ', 
      style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 212, 125, 90)),)
      .animate(
        delay: 1000.ms,
        onPlay: (controller) => controller.repeat(),
      ).tint(duration: 10.seconds, color: const Color.fromARGB(255, 57, 39, 156)).then(delay: 1.seconds).tint(color: const Color.fromARGB(255, 212, 125, 90), duration: 10.seconds);
  }

  Animate cardButtonText (String label){
    return Text('  $label  ', 
      style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 212, 125, 90)),)
      .animate(
        delay: 1000.ms,
        onPlay: (controller) => controller.repeat(),
      )
      .tint(duration: 10.seconds, color: const Color.fromARGB(255, 57, 39, 156))
      .then(delay: 1.seconds)
      .tint(color: const Color.fromARGB(255, 212, 125, 90), duration: 10.seconds);
  }

  ButtonStyle submitButtonStyle (){
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 255, 253, 249),
      elevation: 1.3,
      surfaceTintColor: const Color.fromARGB(255, 255, 253, 249),
      padding: EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
      animationDuration: Duration(seconds: 2),
    );
  }

  ButtonStyle cardButtonStyle (Color color){
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      elevation: 1.3,
      surfaceTintColor: color,
      padding: EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
      animationDuration: Duration(seconds: 2),
    );
  }

  SnackBar bottomPopup (String text, Color backgroundColor, Color textColor){
    return SnackBar(
          content: Card(
            elevation: 1,
            color: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w700),
                ))),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
  }

  Text cardText (String text){
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color.fromARGB(255, 255, 249, 236),
        fontStyle: FontStyle.italic
      ),
    );
  }

  Animate screenHeading (String label) {
    return Text(
                label,
                style: TextStyle(
                  color: Color.fromARGB(255, 224, 140, 29),
                  fontWeight: FontWeight.w900,
                  fontSize: 38,
                )
              )
              .animate(onPlay: (controller) => controller.loop())
              .tint(color: const Color.fromARGB(255, 61, 82, 175), duration: 10.seconds)
              .then(delay: 1.seconds)
              .tint(
                color: Color.fromARGB(255, 224, 140, 29),
                duration: 10.seconds,
              );
  }

  Animate heading (String label) {
    return Text(
                label,
                style: TextStyle(
                  color: Color.fromARGB(255, 224, 140, 29),
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                )
              )
              .animate(onPlay: (controller) => controller.loop())
              .tint(color: const Color.fromARGB(255, 61, 82, 175), duration: 10.seconds)
              .then(delay: 1.seconds)
              .tint(
                color: Color.fromARGB(255, 224, 140, 29),
                duration: 10.seconds,
              );
  }

  Animate subHeading (String label) {
    return Text(
                label,
                style: TextStyle(
                  color: Color.fromARGB(255, 224, 140, 29),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                )
              )
              .animate(onPlay: (controller) => controller.loop())
              .tint(color: const Color.fromARGB(255, 61, 82, 175), duration: 10.seconds)
              .then(delay: 1.seconds)
              .tint(
                color: Color.fromARGB(255, 224, 140, 29),
                duration: 10.seconds,
              );
  }

  TextStyle headingStyle (Color color) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: color,
    );
  }

  TextStyle largerHeadingStyle (Color color) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 19,
      color: color,
    );
  }

  TextStyle detailStyle (Color color) {
    return TextStyle(
      fontSize: 17,
      color: color,
    );
  }

  TextStyle largerDetailStyle (Color color) {
    return TextStyle(
      fontSize: 20,
      color: color,
    );
  }

  List<Widget> headingDetailEntry ({required String heading, required String detail, required Icon icon}){
    return [
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Text('  $heading   ', style: headingStyle(const Color.fromARGB(255, 122, 122, 122)),),
      ],
      ),
      const SizedBox(height: 10,),
      Text(detail, style: detailStyle(const Color.fromARGB(255, 122, 122, 122)),),
      const SizedBox(height: 30,)
    ];
  } 
}
