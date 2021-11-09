import 'package:crud_flutter/network/user_request.dart';
import 'package:crud_flutter/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateUserScreen extends StatefulWidget {
  int id;
  String userName;
  String userPhone;
  UpdateUserScreen({required this.id, required this.userName ,required this.userPhone});

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}



class _UpdateUserScreenState extends State<UpdateUserScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update user"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30,),
              TextFormField(
                controller: _userName,
                //initialValue: widget.userName,
                decoration: InputDecoration(
                  label: Text(widget.userName),
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _phoneNumber,
                //initialValue: widget.userPhone,
                decoration: InputDecoration(
                    label: Text(widget.userPhone),
                    hintText: "Number phone",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  print("Update");
                  if (_formKey.currentState!.validate()) {
                    if(_userName.text == "") {
                      _userName.text = widget.userName;
                    }
                      if(_phoneNumber.text == ""){
                      _phoneNumber.text = widget.userPhone;
                      }
                      try {
                        UserRequest.updateUser(widget.id, _userName.text, _phoneNumber.text);
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => const HomeScreen()));
                      } catch (e) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.lightGreen
                  ),
                  child: const Text("Update now" , style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
