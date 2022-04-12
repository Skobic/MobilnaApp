// ignore_for_file: file_names

class Korisnik {
  // ignore: non_constant_identifier_names
  final int KorisnikId;
  final String ime;
  final String prezime;
  final String korisnickoIme;
  final String lozinka;

  final String email;

  Korisnik(
      // ignore: non_constant_identifier_names
      {required this.KorisnikId,
      required this.ime,
      required this.prezime,
      required this.korisnickoIme,
      required this.lozinka,
      required this.email});

  factory Korisnik.fromJson(Map<String, dynamic> json) {
    return Korisnik(
      KorisnikId: json['id'],
      ime: json['ime'],
      prezime: json['prezime'],
      korisnickoIme: json['korisnickoIme'],
      email: json['mejl'],
      lozinka: json['lozinka'],
    );
  }
}
