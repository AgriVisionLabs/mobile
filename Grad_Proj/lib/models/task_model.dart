class TaskModel {
  final String id;
  final String farmId;
  final String fieldId;
  final String createdById;
  final String createdBy;
  final DateTime createdAt;
  final String? assignedToId;
  final String? assignedTo;
  final DateTime? assignedAt;
  final String? claimedById;
  final String? claimedBy;
  final DateTime? claimedAt;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final int itemPriority;
  final int category;

  TaskModel({
    required this.id,
    required this.farmId,
    required this.fieldId,
    required this.createdById,
    required this.createdBy,
    required this.createdAt,
    this.assignedToId,
    this.assignedTo,
    this.assignedAt,
    this.claimedById,
    this.claimedBy,
    this.claimedAt,
    required this.title,
    this.description,
    this.dueDate,
    this.completedAt,
    required this.itemPriority,
    required this.category,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      farmId: json['farmId'],
      fieldId: json['fieldId'],
      createdById: json['createdById'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      assignedToId: json['assignedToId'],
      assignedTo: json['assignedTo'],
      assignedAt:
          json['assignedAt'] != null ? DateTime.parse(json['assignedAt']) : null,
      claimedById: json['claimedById'],
      claimedBy: json['claimedBy'],
      claimedAt:
          json['claimedAt'] != null ? DateTime.parse(json['claimedAt']) : null,
      title: json['title'],
      description: json['description'] == "null" ? null : json['description'],
      dueDate: json['dueDate'] != null ? DateTime.tryParse(json['dueDate']) : null,
      completedAt: json['completedAt'] != null
          ? DateTime.tryParse(json['completedAt'])
          : null,
      itemPriority: json['itemPriority'],
      category: json['category'],
    );
  }

  
}
