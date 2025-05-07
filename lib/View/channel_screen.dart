import 'package:chat_app/Model/ChatRoom.dart';
import 'package:chat_app/Model/User.dart';
import 'package:chat_app/View/chat_screen.dart';
import 'package:flutter/material.dart';

class ChannelScreen extends StatelessWidget {
   ChannelScreen({super.key});

  TextEditingController _meCtrlr = TextEditingController(),_receiverController = TextEditingController();
  FocusNode _meFocus = FocusNode(),_receiverFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txtField(
                    _meFocus, _meCtrlr, 'Enter your name'),
                txtField(
                    _receiverFocus, _receiverController, 'Enter receiver name'),

            FilledButton(onPressed:() {_moveToChatScreen(context);}, child: Text('Start Chat'))
          ],
        ),
      ),
    );
  }

  Widget txtField(
      FocusNode focus, TextEditingController controller, String hint,) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextField(
        textInputAction: TextInputAction.next,
        
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            fillColor: Colors.white,
            focusColor: Colors.white,
            label: Text(
              hint,
            ),),
        controller: controller,
        focusNode: focus,
      ),
    );
  }

   _moveToChatScreen(BuildContext context) {
    String id = _meCtrlr.text;
    String name = _meCtrlr.text;
    String receiverId = _receiverController.text;
    String receiverName = _receiverController.text;

    User user = User(id, name);
    User receiver = User(receiverId, receiverName);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>ChatScreen(user: user,receiver: receiver)));
  }
}