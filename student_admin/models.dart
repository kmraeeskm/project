class student {
  final String id;
  final String m1;
  final String m2;
  final String m3;
  final String m4;

  const student({
    required this.id,
    required this.m1,
    required this.m2,
    required this.m3,
    required this.m4,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'm1': m1,
        'm2': m2,
        'm3': m3,
        'm4': m4,
      };
}
