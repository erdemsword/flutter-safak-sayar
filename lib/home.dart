import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:safak_sayar_2020/model/sharedPref.dart';
import 'package:safak_sayar_2020/model/users.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:safak_sayar_2020/profile.dart';
import 'package:intl/intl.dart'; 
import 'package:jiffy/jiffy.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Şafak Sayar +2020',
      home: MyHomePage(title: 'Erdem KILIÇ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  var terhistrh;
  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        userLoad = user;
        
      });
    } catch (Excepetion) {

    }
  }

  var isOnline;
  Future<bool> check() async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile) {
          return true;
        } else if (connectivityResult == ConnectivityResult.wifi) {
          return true;
        }
        return false;
      }

    @override
      void initState() {
        super.initState();
        loadSharedPrefs();
        check().then((intenet) {
        if (intenet != null && intenet) {
          isOnline = true;
        }
      });
      }

  @override
  Widget build(BuildContext context) {
    
    int askerlksure = 6;
    int askerlkizin = 6;
    int askerlkkulizin = int.parse(userLoad.kullanilanizin);
    int askerlkyolhak = 0;
    DateFormat inputFormat = DateFormat("dd-MM-yyyy");
    DateTime dateTime = inputFormat.parse(userLoad.sulus);
    if(userLoad.askerliksuresi == "6 Ay"){
      askerlksure = 6;
    }else if(userLoad.askerliksuresi == "12 Ay"){
      askerlksure = 12;
    }
    if(userLoad.toplamizinhakki == "6 Gün"){
      askerlkizin = 6;
    }else if(userLoad.toplamizinhakki == "12 Gün"){
      askerlkizin = 12;
    }
    if(userLoad.yolhakki == "1 (Terhis)"){
      askerlkyolhak = 1;
    }else if(userLoad.yolhakki == "1 + 1 (İzin)"){
      askerlkyolhak = 2;
    }else if(userLoad.yolhakki == "2 (Terhis)"){
      askerlkyolhak = 2;
    }else if(userLoad.yolhakki == "2 + 2 (İzin)"){
      askerlkyolhak = 4;
    }else if(userLoad.yolhakki == "3 (Terhis)"){
      askerlkyolhak = 3;
    }else if(userLoad.yolhakki == "3 + 3 (İzin)"){
      askerlkyolhak = 6;
    }
    DateTime d = Jiffy(dateTime).add(months: askerlksure);
    int msecond = currentTimeInSeconds(dateTime) - currentTimeInSeconds(DateTime.now());
    int msecondays = currentTimeInSeconds(dateTime) - currentTimeInSeconds(d);
    double secondsa = msecondays / 1000;
    double minutesa = secondsa / 60;
    double hoursa = minutesa / 60;
    double daysa = hoursa / 24;
    double seconds = msecond / 1000;
    double minutes = seconds / 60;
    double hours = minutes / 60;
    double days = hours / 24 + askerlkkulizin - askerlkizin - askerlkyolhak;
    double kalanGun = days.abs();
    double toplamGun = daysa.abs();
    double gecenGun = toplamGun - kalanGun;
    double kalanSure = (gecenGun / toplamGun);
    double gecenSure = (kalanGun / toplamGun);
    String kalanGunString = gecenGun.toStringAsFixed(0).padLeft(2,"0");
    DateTime ds = Jiffy(d).subtract(days: askerlkyolhak + askerlkizin - askerlkkulizin);
    var terhistrh = Jiffy(ds).format('dd-MM-yyyy');
    double fontsize = 72.0;
    var imgsrc;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:30.0,left:12.0, right:12.0,bottom:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    userLoad.ad + " " + userLoad.soyad,style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: "Raleway"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 28.0,
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: DefaultAssetBundle.of(context).loadString("assets/iller.json"),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  var myData = json.decode(snapshot.data.toString());
                  if(gecenGun<82){
                    imgsrc = myData['iller'][gecenGun.toInt()]['imgsrc'];
                  }
                  if(gecenGun>81){
                      imgsrc="https://i.hizliresim.com/mlnk87.png";
                  }
                  if (gecenGun<1){
                    kalanGunString= "Askerliğiniz bitmiştir.";
                    imgsrc = "https://i.hizliresim.com/IAqNnI.gif";
                    fontsize = 38.0;
                  }
                  return Stack(
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          child:
                            Builder(builder: (context){
                              if(isOnline==true){
                                return Image.network(
                                  imgsrc, fit: BoxFit.cover,width: double.infinity,height: 140,
                                );
                              }else{
                                return Image(image: AssetImage('assets/images/backg.png'), fit: BoxFit.cover,width: double.infinity, height: 140,);
                              }
                            },)
                            
                        ),
                      ),
                      Padding( //Kalan gün
                        padding: const EdgeInsets.only(top:35.0),
                        child: Center(
                          child: Text("${kalanGunString.toString()}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]
                  );
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
            Padding( //Kalan Gün/Geçen Gün Progress
              padding: const EdgeInsets.only(top:30.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: gecenSure,
                      center: new Text(
                        "${kalanGun.toStringAsFixed(0)}\nGün",
                        textAlign: TextAlign.center,
                        style:
                            new TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        "Geçen Süre",
                        style:
                            new TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.orange,
                    ),
                    SizedBox(width: 50.0,),
                    new CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: kalanSure,
                      center: new Text(
                        "${gecenGun.toStringAsFixed(0)}\nGün",
                        textAlign: TextAlign.center,
                        style:
                            new TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        "Kalan Süre",
                        style:
                            new TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                  ],
                ),
            ),
            SizedBox(height: 15.0,),
            
            Row(
              children: <Widget>[
                Flexible(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: <Widget>[
                      new Card(
                      color: Color.fromARGB(255, 221, 161, 50),
                      child: new Container(
                        width: double.infinity,
                        padding: new EdgeInsets.all(5.0),
                        child: new Column(
                          children: <Widget>[
                            Icon(Icons.person_pin_circle,size: 32.0, color: Colors.white,),
                            SizedBox(height: 5.0,),
                            new Text('Askerlik Yeri',style:TextStyle(color: Colors.white, fontSize: 20.0, fontWeight:FontWeight.bold)),
                            SizedBox(height: 10.0,),
                            new Text(userLoad.askerlikyeri,style: TextStyle(fontSize: 15.0, color: Colors.white), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    )
                  ],),
                ),),
                Flexible(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: <Widget>[
                      new Card(
                      color: Color.fromARGB(255, 221, 161, 50),
                      child: new Container(
                        width: double.infinity,
                        padding: new EdgeInsets.all(5.0),
                        child: new Column(
                          children: <Widget>[
                            Icon(Icons.room,size: 32.0, color: Colors.white,),
                            SizedBox(height: 5.0,),
                            new Text('Memleket',style:TextStyle(color: Colors.white, fontSize: 20.0, fontWeight:FontWeight.bold)),
                            SizedBox(height: 10.0,),
                            new Text(userLoad.memleket,style: TextStyle(fontSize: 15.0, color: Colors.white), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    )
                  ],),
                ),),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: <Widget>[
                      new Card(
                      color: Color.fromARGB(255, 221, 161, 50),
                      child: new Container(
                        width: double.infinity,
                        padding: new EdgeInsets.all(5.0),
                        child: new Column(
                          children: <Widget>[
                            Icon(Icons.schedule,size: 32.0, color: Colors.white,),
                            SizedBox(height: 5.0,),
                            new Text('Sülüs Tarihi',style:TextStyle(color: Colors.white, fontSize: 20.0, fontWeight:FontWeight.bold)),
                            SizedBox(height: 10.0,),
                            new Text(userLoad.sulus,style: TextStyle(fontSize: 15.0, color: Colors.white), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    )
                  ],),
                ),),
                Flexible(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: <Widget>[
                      new Card(
                      color: Color.fromARGB(255, 221, 161, 50),
                      child: new Container(
                        width: double.infinity,
                        padding: new EdgeInsets.all(5.0),
                        child: new Column(
                          children: <Widget>[
                            Icon(Icons.watch_later,size: 32.0, color: Colors.white,),
                            SizedBox(height: 5.0,),
                            new Text('Terhis Tarihi',style:TextStyle(color: Colors.white, fontSize: 20.0, fontWeight:FontWeight.bold)),
                            SizedBox(height: 10.0,),
                            new Text(terhistrh.toString(),style: TextStyle(fontSize: 15.0, color: Colors.white), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    )
                  ],),
                ),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(children: <Widget>[
                  new Card(
                  color: Color.fromARGB(255, 221, 161, 50),
                  child: new Container(
                    width: double.infinity,
                    padding: new EdgeInsets.all(5.0),
                    child: new Column(
                      children: <Widget>[
                        Icon(Icons.bookmark_border,size: 32.0, color: Colors.white,),
                        new Text('Mani / Söz',style:TextStyle(color: Colors.white, fontSize: 20.0, fontWeight:FontWeight.bold)),
                        SizedBox(height: 10.0,),
                        new Text('How are you?jkjklsdjgjsahakjshajksgakkajfafjaksfhajkfhkafhasfhjassfhakfkasfhkafhajfhaskufafjabfkasgfkasf\nHow are you?\nHow are you?\nHow are you?\nHow are you?\nHow are you?',style: TextStyle(fontSize: 15.0, color: Colors.white), textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                )
              ],),
            )
          ],
        ),
      ),
    );
  }
}

int currentTimeInSeconds(DateTime date) {
    var ms = (date).millisecondsSinceEpoch;
    return ms;
}

String formatDate(int milliseconds) {
  final template = DateFormat('dd-MM-yyyy');
  return template.format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
}