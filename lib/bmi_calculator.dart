import 'package:bmi_calculator/auth_controller.dart';
import 'package:bmi_calculator/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  int currentindex=0;
  String result="";
  double height=0.0;
  double weight=0.0;
  TextEditingController heightController= TextEditingController();
  TextEditingController weightController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      child:Scaffold(
        appBar:AppBar(
          title: Text("BMI Calculator",
              style:TextStyle(color:Colors.black)
          ),
          elevation: 0.0,
          backgroundColor: Color(0xfffafafa),
          actions:[
            IconButton(onPressed: (){},
              icon: Icon(
                Icons.settings,
                color:Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    radioButton("Man",Colors.orangeAccent, 0),
                    radioButton("Woman", Colors.orangeAccent, 1),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Your height in cm:",style:TextStyle(
                  fontSize: 18.0,
                ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    decoration:InputDecoration(
                        hintText: "Your height in cm",
                        prefixIcon: Icon(Icons.height, color:Colors.deepOrangeAccent),
                        filled:true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        )
                    )
                ),

                SizedBox(
                  height: 20.0,
                ),

                Text("Your Weight in Kg:",style:TextStyle(
                  fontSize: 18.0,
                ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    decoration:InputDecoration(
                        hintText: "Your Weight in Kg",
                        prefixIcon: Icon(Icons.monitor_weight, color:Colors.deepOrangeAccent),
                        filled:true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        )
                    )
                ),
                SizedBox(height: 40.0,),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    child: MaterialButton(
                      onPressed: (){
                        setState((){
                          height=double.parse(heightController.value.text);
                          weight=double.parse(weightController.value.text);

                        });
                        height = double.parse(heightController.value.text);
                        weight = double.parse(weightController.value.text);
                        calculateBmi(height,weight);

                      },


                      child: Text("Calculate",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color:Colors.white,
                          )
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(30),
                        image: DecorationImage(
                          image: AssetImage(
                              "img/btn-bckground.jpg"
                          ),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                ),

                SizedBox(height:20.0,),
                Container(
                  width: double.infinity,
                  child: Text("Your BMI is:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,

                    ),),
                ),
                SizedBox(height: 50.0,),
                Container(
                  width: double.infinity,
                  child: Text("$result",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,

                    ),),
                ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      AuthController.instance.logOut();
                    },
                    child: Container(
                      width: w*0.2,
                      height: h*0.05,
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage(
                                "img/btn-bckground.jpg"
                            ),
                            fit: BoxFit.cover,
                          )
                      ),
                      child: Center(
                        child: Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color:Colors.white,

                            )


                        ),
                      ) ,
                    ),
                ),
              ],
            ),

          ),

        ),
      ),
    );

  }

  void calculateBmi(double height,double weight){
    double finalresult=weight/(height*height/10000);
    String bmi=finalresult.toStringAsFixed(2);
    setState(() {
      result= bmi;
    });
  }


  void changeIndex(int index){
    setState(() {
      currentindex=index;
    });
  }

  Widget radioButton(String value, Color color,int index){
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:12.0 ),
        height: 80.0,
        child: MaterialButton(
          color: currentindex==index ? color:Colors.grey[200],
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),

          onPressed: (){
            changeIndex(index);
          },
          child: Text(value, style:TextStyle(
            color: currentindex == index ? Colors.white : color,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
      ),
    );

  }
}



