List<dynamic> decodePrtcYear(int prtcYear) {
  int tt = ((prtcYear % 100) / 10).floor();
  String season = "";
  if (tt == 1) {
    season = "봄";
  } else if (tt == 2) {
    season = "여름";
  } else if (tt == 3) {
    season = "가을";
  } else if (tt == 4) {
    season = "겨울";
  } else {
    season = "??";
  }
  //연도, 계절, 분반
  return [(prtcYear / 100).floor(), season, (prtcYear % 10).floor()];
}
