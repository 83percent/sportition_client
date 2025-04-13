class BoardElementDTO {
  final String uid;
  final String name;
  final String league;
  final int workingOutDt;
  final int score;
  final int squart;
  final int benchPress;
  final int deadLift;
  final String gender;

  BoardElementDTO({
    required this.uid,
    required this.name,
    required this.league,
    required this.workingOutDt,
    required this.score,
    required this.squart,
    required this.benchPress,
    required this.deadLift,
    required this.gender,
  });
}
