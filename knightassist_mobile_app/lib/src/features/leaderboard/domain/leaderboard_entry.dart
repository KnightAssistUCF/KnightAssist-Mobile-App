class LeaderboardEntry {
  const LeaderboardEntry({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.eventHistory,
    required this.totalVolunteerHours,
    required this.profilePicPath,
  });

  final String id;
  final String firstName;
  final String lastName;
  final List<String> eventHistory;
  final int totalVolunteerHours;
  final String profilePicPath;

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map) {
    return LeaderboardEntry(
        id: map['_id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        eventHistory: List<String>.from(map['eventsHistory']),
        totalVolunteerHours: map['totalVolunteerHours'],
        profilePicPath: map['profilePicPath']);
  }
}
