void main() async {
  List<int> a = List<int>.generate(5, (index) => index + 1);
  print(a);

  // a.f
  // print(a.);
}

void test() async {
  DateTime time;
  int currentMinute;
  int toWait = 0;
  while (true) {
    time = DateTime.now();
    currentMinute = time.second;
    if (currentMinute < 30) {
      toWait = 30 - currentMinute;
    } else if (currentMinute >= 30) {
      toWait = 60 - currentMinute;
    }
    await Future.delayed(Duration(seconds: toWait)).then(
      (value) {
        time = DateTime.now();
        print("called $time");
      },
    );
  }
}

void test1() async {
  int a = 3;
  while (a != 5) {
    await Future.delayed(Duration(seconds: 0)).then(
      (value) {
        print(a);
        a++;
      },
    );
  }
}
