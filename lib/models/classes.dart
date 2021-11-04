class MotherClass {
  int duration;
  MotherClass({required this.duration});
}

class Study extends MotherClass {
  @override
  int duration = 25;
  int nbs = 0;
  bool isActive = false;
  Study({
    required this.duration,
    required this.nbs,
    required this.isActive,
  }) : super(duration: duration);
}

class ShortBreak extends MotherClass {
  @override
  int duration = 5;
  int nbsb = 0;
  bool isActive = false;
  ShortBreak({
    required this.duration,
    required this.nbsb,
    required this.isActive,
  }) : super(duration: duration);
}

class LongBreak extends MotherClass {
  @override
  int duration = 15;
  int nblb = 0;
  bool isActive = false;
  LongBreak({
    required this.duration,
    required this.nblb,
    required this.isActive,
  }) : super(duration: duration);
}

class Cycle {
  int nbc = 4;
  int currentCycle = 0;
  Cycle({
    required this.nbc,
    required this.currentCycle,
  });
}

var s = Study(duration: 25, nbs: 0, isActive: false);
var sb = ShortBreak(duration: 5, nbsb: 0, isActive: false);
var lb = LongBreak(duration: 15, nblb: 0, isActive: false);
var c = Cycle(nbc: 3, currentCycle: 0);

durationProvider(int nb) {
  int duration = s.duration;
  if (nb == c.nbc * 2) {
    lb.nblb++;
    duration = lb.duration;
    sb.nbsb++;
    c.currentCycle++;
    nb = 0;
  } else {
    if (nb % 2 == 0) {
      duration = sb.duration;
      sb.nbsb++;
      c.currentCycle++;
    } else {
      duration = s.duration;
      s.nbs++;
    }
  }
  return duration;
}

String durationTextProvider(MotherClass m) {
  int duration = m.duration;
  return "$duration Minutes";
}
