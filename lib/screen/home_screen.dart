import 'package:crud_flutter/model/user_model.dart';
import 'package:crud_flutter/network/user_request.dart';
import 'package:crud_flutter/screen/update_user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<UserModel> dataUsers = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  @override

  void addUser(){
    UserRequest.addUser(userName.text.trim(), phoneNumber.text.trim());
    UserRequest.fetchUsers().then((dataUser){
      setState(() {
        dataUsers = dataUser;
      });
    });
  }

  void deleteUser(int IdUser){
    UserRequest.deleteUser(IdUser);
    UserRequest.fetchUsers().then((dataUser){
      setState(() {
        dataUsers = dataUser;
      });
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    UserRequest.fetchUsers().then((dataUser){
      setState(() {
        dataUsers = dataUser;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Contact" , style: TextStyle(
                        color: Colors.teal,
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 15,),
                      Text("Demo create update delete program", style: TextStyle(
                        fontSize: 20,
                        color: Colors.black38
                      ),)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                  itemBuilder: (context,index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: 50,
                    child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex : 2,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(dataUsers[index].userName.toString() , style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    Text(dataUsers[index].userPhone.toString()),
                                  ],
                                )
                            ),
                            Expanded(
                              flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=> UpdateUserScreen(
                                                id: dataUsers[index].userID!.toInt(),
                                                userName: dataUsers[index].userName.toString(),
                                                userPhone: dataUsers[index].userPhone.toString()
                                            )));
                                        print("Change id : " + dataUsers[index].userID.toString());
                                      },
                                      child: Container(
                                        width : 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: const Icon(Icons.pending_outlined,color: Colors.amber,),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    InkWell(
                                      onTap:(){
                                        deleteUser(dataUsers[index].userID!.toInt());
                                        print("Delete id : " + dataUsers[index].userID.toString());
                                      },
                                      child: Container(
                                        width : 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: const Icon(Icons.delete_outline_outlined,color: Colors.red,),
                                      ),
                                    ),

                                  ],
                                )
                            )
                          ],
                        )
                  ),
                  separatorBuilder: (context ,index) => const SizedBox(height: 10,),
                  itemCount: dataUsers.length
              ),
            ),]
          ),
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()=> showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: const Text("Add new user"),
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                              TextFormField(
                                controller: userName,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  label: const Text("User name"),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  )
                                ),
                              ),
                            const SizedBox(height: 10,),
                               TextFormField(
                                 controller: phoneNumber,
                                 keyboardType: TextInputType.number,
                                validator: (val) => val!.length < 10 ?  "Phone number longer 10 character" : null,
                                decoration: InputDecoration(
                                    label: const Text("Phone number"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    )
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: TextButton(
                                  child: const Text("Add",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      try{
                                        addUser();
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Added : "+ userName.text),
                                        ));
                                      }catch (e){
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(e.toString())),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
          child: const Icon(Icons.add),
      ),
    );
  }

}
