
class Stats {
  final int countAllRessource;
  final List<Map<String, dynamic>> ressourceByCategories;
  final Map<String, int> ressourceByDays;
  final List<dynamic> commentByDays;

  Stats({
    required this.countAllRessource,
    required this.ressourceByCategories,
    required this.ressourceByDays,
    required this.commentByDays,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      countAllRessource: json['countAllRessource'],
      ressourceByCategories: List<Map<String, dynamic>>.from(json['ressourceByCategories']),
      ressourceByDays: Map<String, int>.from(json['ressourceByDays']),
      commentByDays: json['commentByDays'] ?? [],
    );
  }
}
