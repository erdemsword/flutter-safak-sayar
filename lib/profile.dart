import 'package:flutter/material.dart';
import 'package:safak_sayar_2020/model/sharedPref.dart';
import 'package:safak_sayar_2020/model/users.dart';
import 'package:intl/intl.dart';  

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

String _dropDownValueSure;
String _dropDownValueIzin;
String _dropDownValueYol;
String _dropDownValueAskerlikYeri;
String _dropDownValueMemleket;

var ad = TextEditingController();
var soyad = TextEditingController();
var sulusTxt = TextEditingController();
var kullanilanIzinTxt = TextEditingController();
var alinanCezaTxt = TextEditingController();
var erkenTerhisTxt = TextEditingController();

DateFormat dateFormat = DateFormat("dd/MM/yyyy");

class _ProfileScreenState extends State<ProfileScreen> {
  var finaldate;
  

    void callDatePicker() async {
      var order = await getDate();
      setState(() {
        finaldate = order;
        final dates = DateFormat('dd-MM-yyyy');
        String date = dates.format(finaldate);
        sulusTxt.text = date;
      });
    }

    Future<DateTime> getDate() {
      // Imagine that this function is
      // more complex and slow.
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        },
      );
    }

  SharedPref sharedPref = SharedPref();
  User userSave = User();
  User userLoad = User();

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        userLoad = user;
        ad.text = userLoad.ad ?? "";
        soyad.text = userLoad.soyad ?? "";
        sulusTxt.text = userLoad.sulus ?? "";
        _dropDownValueSure = userLoad.askerliksuresi ?? null;
        _dropDownValueIzin = userLoad.toplamizinhakki ?? null;
        kullanilanIzinTxt.text = userLoad.kullanilanizin ?? "0";
        _dropDownValueYol = userLoad.yolhakki ?? null;
        alinanCezaTxt.text = userLoad.alinanceza ?? "0";
        erkenTerhisTxt.text = userLoad.erkenterhis ?? "0";
        _dropDownValueAskerlikYeri = userLoad.askerlikyeri ?? null;
        _dropDownValueMemleket = userLoad.memleket ?? null;
      });
    } catch (Excepetion) {}
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child:
      Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:50.0,left:12.0, right:12.0,bottom:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "ŞAFAK HESAPLA",textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 26.0, fontFamily: "Raleway",),
                ),
              ),
            ],
          ),
        ),
        Row(
            children: <Widget>[
                Expanded(
                    child: Divider()
                ),       

                SizedBox(width: 2.0,),
                Text("Ad - Soyad"),        
                SizedBox(width: 2.0,),
                Expanded(
                    child: Divider()
                ),
            ]
        ),
        SizedBox(height: 2.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: 
                Container(
                  height: 50.0,
                  child: TextField(
                    autofocus: false,
                    controller: ad,
                    decoration: InputDecoration(
                      hintText: "Ad",
                      prefixIcon: Icon(Icons.person),      
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(child: 
                Container(
                  height: 50.0,
                  child: TextField(
                    autofocus: false,
                    controller: soyad,
                    decoration: InputDecoration(
                      hintText: "Soyad",
                      prefixIcon: Icon(Icons.account_box),      
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                      ),
                    ),
                  ),
                ),
              ),
          ],),
        ),
        Row(
            children: <Widget>[
                Expanded(
                    child: Divider()
                ),       

                Text("Sülüs Tarihi"),        

                Expanded(
                    child: Divider()
                ),
            ]
        ),
        SizedBox(height: 5.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 3,
                child: 
                Container(
                  height: 50.0,
                  child: TextField(
                    controller: sulusTxt,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "Sülüs Tarihi",
                      prefixIcon: Icon(Icons.date_range),      
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(child: 
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text("Seç",textAlign: TextAlign.center,),
                    onPressed: callDatePicker,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
          ],),
        ),
        Row(
            children: <Widget>[
                Expanded(
                    child: Divider()
                ),       

                Text("Askerlik süresi - İzin hakkı"),        

                Expanded(
                    child: Divider()
                ),
            ]
        ),
        SizedBox(height: 5.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: 
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                    ),
                  child:
                  DropdownButton(
                    hint: _dropDownValueSure == null
                        ? Text('Askerlik süresi')
                        : Text(
                            _dropDownValueSure,
                            style: TextStyle(color: Colors.black),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ['6 Ay', '12 Ay'].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValueSure = val;
                        },
                      );
                    },
                    
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(child: 
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                    ),
                  child:
                  DropdownButton(
                    hint: _dropDownValueIzin == null
                        ? Text('Toplam İzin Hakkı')
                        : Text(
                            _dropDownValueIzin,
                            style: TextStyle(color: Colors.black),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ['6 Gün', '12 Gün'].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValueIzin = val;
                        },
                      );
                    },
                    
                  ),
                ),
              ),
          ],),
        ),
        Row(
            children: <Widget>[
                Expanded(
                    child: Divider()
                ),       

                Text("Kullanılan izin - Yol hakkı"),        

                Expanded(
                    child: Divider()
                ),
            ]
        ),
        SizedBox(height: 5.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: 
                Container(
                  height: 50.0,
                  child: TextField(
                    controller: kullanilanIzinTxt,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "Kullanl. İzin",
                      prefixIcon: Icon(Icons.directions_car),      
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(child: 
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                    ),
                  child:
                  DropdownButton(
                    hint: _dropDownValueYol == null
                        ? Text('Yol İzni')
                        : Text(
                            _dropDownValueYol,
                            style: TextStyle(color: Colors.black),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ['1 (Terhis)', '1 + 1 (İzin)', '2 (Terhis)', '2 + 2 (İzin)','3 (Terhis)','3 + 3(İzin)'].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValueYol = val;
                        },
                      );
                    },
                    
                  ),
                ),
              ),
          ],),
        ),
        Row(
            children: <Widget>[
                Expanded(
                    child: Divider()
                ),       

                Text("Alınan ceza - Erken terhis"),        

                Expanded(
                    child: Divider()
                ),
            ]
        ),
        SizedBox(width: 20.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: 
                Container(
                  height: 50.0,
                  child: TextField(
                    controller: alinanCezaTxt,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "Alınan Ceza",
                      prefixIcon: Icon(Icons.block),      
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(child: 
                Container(
                  height: 50.0,
                  child: TextField(
                    controller: erkenTerhisTxt,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "Erken Terhis",
                      prefixIcon: Icon(Icons.accessibility_new),      
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                      ),
                    ),
                  ),
                ),
              ),
          ],),
        ),
        Row(
            children: <Widget>[
                Expanded(
                    child: Divider()
                ),       

                Text("Askerlik yeri"),        

                Expanded(
                    child: Divider()
                ),
            ]
        ),
        SizedBox(width: 20.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 3,
                child: 
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                    ),
                  child:
                  DropdownButton(
                    hint: _dropDownValueAskerlikYeri == null
                        ? Text('Askerlik Yeri')
                        : Text(
                            _dropDownValueAskerlikYeri,
                            style: TextStyle(color: Colors.black),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ["Adana","Adıyaman","Afyonkarahisar","Ağrı","Amasya","Antalya","Artvin","Aydın","Balıkesir","Bilecik","Bingöl","Bitlis","Bolu","Burdur","Bursa","Çanakkale","Çankırı","Çorum","Denizli","Diyarbakır","Edirne","Elazığ","Erzincan","Erzurum","Eskişehir","Gaziantep","Giresun","Gümüşhane","Hakkari","Hatay","Isparta","Mersin","İstanbul","İzmir","Kars","Kastamonu","Kayseri","Kırklareli","Kırşehir","Kocaeli","Konya","Kütahya","Malatya","Manisa","Kahramanmaraş","Mardin","Muğla","Muş","Nevşehir","Niğde","Ordu","Rize","Sakarya","Samsun","Siirt","Sinop","Sivas","Tekirdağ","Tokat","Trabzon","Tunceli","Şanlıurfa","Uşak","Van","Yozgat","Zonguldak","Aksaray","Bayburt","Karaman","Kırıkkale","Batman","Şırnak","Bartın","Ardahan","Iğdır","Yalova","Karabük","Kilis","Osmaniye","Düzce"].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValueAskerlikYeri = val;
                        },
                      );
                    },
                    
                  ),
                ),
              ),
          ],),
        ),
        Row(
            children: <Widget>[
                Expanded(
                    child: Divider()
                ),       

                Text("Memleket"),        

                Expanded(
                    child: Divider()
                ),
            ]
        ),
        SizedBox(width: 20.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 3,
                child: 
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                    ),
                  child:
                  DropdownButton(
                    hint: _dropDownValueMemleket == null
                        ? Text('Memleket')
                        : Text(
                            _dropDownValueMemleket,
                            style: TextStyle(color: Colors.black),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ["Adana","Adıyaman","Afyonkarahisar","Ağrı","Amasya","Antalya","Artvin","Aydın","Balıkesir","Bilecik","Bingöl","Bitlis","Bolu","Burdur","Bursa","Çanakkale","Çankırı","Çorum","Denizli","Diyarbakır","Edirne","Elazığ","Erzincan","Erzurum","Eskişehir","Gaziantep","Giresun","Gümüşhane","Hakkari","Hatay","Isparta","Mersin","İstanbul","İzmir","Kars","Kastamonu","Kayseri","Kırklareli","Kırşehir","Kocaeli","Konya","Kütahya","Malatya","Manisa","Kahramanmaraş","Mardin","Muğla","Muş","Nevşehir","Niğde","Ordu","Rize","Sakarya","Samsun","Siirt","Sinop","Sivas","Tekirdağ","Tokat","Trabzon","Tunceli","Şanlıurfa","Uşak","Van","Yozgat","Zonguldak","Aksaray","Bayburt","Karaman","Kırıkkale","Batman","Şırnak","Bartın","Ardahan","Iğdır","Yalova","Karabük","Kilis","Osmaniye","Düzce"].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValueMemleket = val;
                        },
                      );
                    },
                    
                  ),
                ),
              ),
          ],),
        ),
        SizedBox(width: 20.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: 
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text("KAYDET",textAlign: TextAlign.center,style:TextStyle(fontSize: 16.0)),
                    onPressed: () {
                        if (ad.text.length < 2){
                            print("ad hata");
                        }else if (soyad.text.length < 2){
                            print("soyad hata");
                        }else if (sulusTxt.text.length < 1 ){
                            print("sulus hata");
                        }else if (_dropDownValueSure == null){
                            print("askerliksüresi hata");
                        }else if (_dropDownValueIzin == null){
                            print("izin hakkı hata");
                        }else if(kullanilanIzinTxt.text.length < 1){
                            print("kullanılan izin hata");
                        }else if(_dropDownValueYol == null){
                            print("yol izni hata");
                        }else if(alinanCezaTxt.text.length < 1){
                            print("alinan ceza hata");
                        }else if(erkenTerhisTxt.text.length < 1){
                            print("erken terhis hata");
                        }else if(_dropDownValueAskerlikYeri == null){
                            print("askerlik yeri hata");
                        }else if(_dropDownValueMemleket== null){
                            print("memleket hata");
                        }else{
                            setState(() {
                              userSave.ad = ad.text.toUpperCase();
                              userSave.soyad = soyad.text.toUpperCase();
                              userSave.sulus = sulusTxt.text;
                              userSave.askerliksuresi= _dropDownValueSure;
                              userSave.toplamizinhakki = _dropDownValueIzin;
                              userSave.kullanilanizin = kullanilanIzinTxt.text;
                              userSave.yolhakki = _dropDownValueYol;
                              userSave.alinanceza = alinanCezaTxt.text;
                              userSave.erkenterhis = erkenTerhisTxt.text;
                              userSave.askerlikyeri = _dropDownValueAskerlikYeri;
                              userSave.memleket = _dropDownValueMemleket;
                            });
                            sharedPref.save("user", userSave);
                            Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                        }
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
          ],),
        ),
       ]),
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