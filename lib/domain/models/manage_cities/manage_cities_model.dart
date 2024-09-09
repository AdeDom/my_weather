class ManageCitiesModel {
  ManageCitiesModel({
    required this.name,
    required this.state,
    required this.isRemove,
  });

  String name;
  String state;
  bool isRemove;

  ManageCitiesModel copyWith({
    String? name,
    String? state,
    bool? isRemove,
  }) {
    return ManageCitiesModel(
      name: name ?? this.name,
      state: state ?? this.state,
      isRemove: isRemove ?? this.isRemove,
    );
  }
}
