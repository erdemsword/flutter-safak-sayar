class User {
  String ad;
  String soyad;
  String sulus;
  String askerliksuresi;
  String toplamizinhakki;
  String kullanilanizin;
  String yolhakki;
  String alinanceza;
  String erkenterhis;
  String askerlikyeri;
  String memleket;
  User();

  User.fromJson(Map<String, dynamic> json)
      : ad = json['ad'],
        soyad = json['soyad'],
        sulus = json['sulus'],
        askerliksuresi = json['askerliksuresi'],
        toplamizinhakki = json['toplamizinhakki'],
        kullanilanizin = json['kullanilanizin'],
        yolhakki = json['yolhakki'],
        alinanceza = json['alinanceza'],
        erkenterhis = json['erkenterhis'],
        askerlikyeri = json['askerlikyeri'],
        memleket = json['memleket'];

  Map<String, dynamic> toJson() => {
        'ad': ad,
        'soyad': soyad,
        'sulus': sulus,
        'askerliksuresi': askerliksuresi,
        'toplamizinhakki': toplamizinhakki,
        'kullanilanizin': kullanilanizin,
        'yolhakki': yolhakki,
        'alinanceza': alinanceza,
        'erkenterhis': erkenterhis,
        'askerlikyeri': askerlikyeri,
        'memleket': memleket,
      };
}