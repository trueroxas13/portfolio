class Major {
  String? majorID;
  String? majorName;
  List<String>? offeredByUniversity;
  List<String>? interests;
  List<String>? personalityTraits;

  Major({
    this.majorID,
    this.majorName,
    this.offeredByUniversity,
    this.interests,
    this.personalityTraits,
  });
}

void main() {
  Major major1 = Major(
    majorID: "1",
    majorName: "Computer Science",
    offeredByUniversity: ["University A", "University B"],
    interests: ["Investigative", "Conventional"],
    personalityTraits: ["Conscientiousness", "Openness_to_Experience"],
  );
  Major major2 = Major(
    majorID: "2",
    majorName: "Chemistry",
    offeredByUniversity: ["University C", "University D"],
    interests: ["Investigative", "Realistic"],
    personalityTraits: ["Conscientiousness"],
  );
  Major major3 = Major(
    majorID: "3",
    majorName: "Civil Engineering",
    offeredByUniversity: ["University E", "University F"],
    interests: ["Realistic", "Investigative"],
    personalityTraits: ["Conscientiousness", "Openness_to_Experience"],
  );

  Map<String, List<String>> categories = {
    // Interests
    "Realistic": [
      "Build",
      "Machines",
      "Things",
      "Plants",
      "Animals",
      "Outdoors",
      "Hands-on",
    ],
    "Investigative": [
      "Observe",
      "Analyze",
      "Problem Solving",
      "Science",
      "Math",
      "Ideas",
    ],
    "Artistic": [
      "Creative",
      "Music",
      "Drama",
      "Design",
      "Media",
      "Self-expression",
    ],
    "Social": ["Teach", "People", "Communicate", "Service", "Helping", "Guide"],
    "Enterprising": [
      "Lead",
      "Decisions",
      "Action",
      "Business",
      "Risk-taking",
      "Persuade",
    ],
    "Conventional": ["Data", "Procedures", "Routines", "Standards", "Detail"],

    // Personality Traits
    "Conscientiousness": [
      "Dependability",
      "Grit",
      "Organization",
      "Persistence",
      "Planning",
      "Punctuality",
      "Responsibility",
    ],
    "Agreeableness": [
      "Collaboration",
      "Collegiality",
      "Generosity",
      "Honesty",
      "Integrity",
      "Kindness",
      "Trustworthiness",
    ],
    "Emotional Stability": [
      "Confidence",
      "Coping with Stress",
      "Moderation",
      "Resilience",
      "Self-Esteem",
      "Self-Consciousness",
      "Self-Regulation",
    ],
    "Extraversion": [
      "Assertiveness",
      "Cheerfulness",
      "Communication",
      "Optimism",
      "Leadership",
      "Liveliness",
      "Sociability",
    ],
    "Openness_to_Experience": [
      "Curiosity",
      "Creativity",
      "Global Awareness",
      "Growth Mindset",
      "Imagination",
      "Innovation",
      "Tolerance",
    ],
  };

  List<String> selectedInterests = ["Build", "Data"];
  List<String> selectedPersonalityTraits = ["Imagination", "Planning"];

  Map<Major, int> majorScores = {major1: 0, major2: 0, major3: 0};
  for (var major in majorScores.keys) {
    int score = 0;

    //scoring interests
    for (var category in categories.keys) {
      if (major.interests != null && major.interests!.contains(category)) {
        for (var interest in categories[category]!) {
          if (selectedInterests.contains(interest)) {
            score += 1;
          }
        }
      }
    }
    //scoring personality traits
    for (var category in categories.keys) {
      if (major.personalityTraits != null &&
          major.personalityTraits!.contains(category)) {
        for (var trait in categories[category]!) {
          if (selectedPersonalityTraits.contains(trait)) {
            score += 1;
          }
        }
      }
    }
    majorScores[major] = score;
  }
  var sortedMajors =
      majorScores.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  for (var entry in sortedMajors) {
    print("${entry.key.majorName}: ${entry.value}");
  }
}
