// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'control_bloc.dart';

@immutable
abstract class ControlState {}

class ControlInitial extends ControlState {}

//=======================================================================
//========================= AutomatedRulesState =========================
//=======================================================================

class AddAutomationRulesSuccess extends ControlState {
  final AutomationRuleModel rules;
  AddAutomationRulesSuccess({
    required this.rules,
  });
}

class AddAutomationRulesFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  AddAutomationRulesFailure({
    required this.errMessage,
    required this.errors,
  });

}

class ViewAutomationRulesSuccess extends ControlState {
  final List<AutomationRuleModel> rules;
  ViewAutomationRulesSuccess({
    required this.rules,
  });
}
class ViewAutomationRulesFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  ViewAutomationRulesFailure({
    required this.errMessage,
    required this.errors,
  });

}
class AutomationRulesEmpty extends ControlState{}

class ViewAutomationRuleSuccess extends ControlState {
  final AutomationRuleModel rule;
  ViewAutomationRuleSuccess({
    required this.rule,
  });
}
class ViewAutomationRuleFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  ViewAutomationRuleFailure({
    required this.errMessage,
    required this.errors,
  });

}
class AutomationRulesEditSuccess extends ControlState{}

class AutomationRulesEditFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
 AutomationRulesEditFailure({
    required this.errMessage,
    required this.errors,
  });
  

}

class DeleteAutomationRulesSuccess extends ControlState {}

final class DeleteAutomationRulesFailure extends ControlState {
  final String errMessage;
  final dynamic errors;

  DeleteAutomationRulesFailure({required this.errMessage, required this.errors});
}



//========================================================================
//============================== TasksState ==============================
//========================================================================

class AddTaskSuccess extends ControlState {
  final TaskModel task;
  AddTaskSuccess({
    required this.task,
  });
}
class AddTaskFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  AddTaskFailure({
    required this.errMessage,
    required this.errors,
  });

}

class ViewTasksSuccess extends ControlState {
  final List<TaskModel> tasks;
  ViewTasksSuccess({
    required this.tasks,
  });
}
class ViewTasksFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  ViewTasksFailure({
    required this.errMessage,
    required this.errors,
  });

}
class TasksEmpty extends ControlState{}

class ViewTaskSuccess extends ControlState {
  final TaskModel task;
  ViewTaskSuccess({
    required this.task,
  });
}
class ViewTaskFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  ViewTaskFailure({
    required this.errMessage,
    required this.errors,
  });

}

class EditTaskSuccess extends ControlState {}
class EditTaskFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  EditTaskFailure({
    required this.errMessage,
    required this.errors,
  });
}


class DeleteTaskSuccess extends ControlState {}
class DeleteTaskFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  DeleteTaskFailure({
    required this.errMessage,
    required this.errors,
  });
}

class CompleteTaskSuccess extends ControlState {}
class CompleteTaskFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  CompleteTaskFailure({
    required this.errMessage,
    required this.errors,
  });

}

//========================================================================
//============================== Item State ==============================
//========================================================================

class AddItemSuccess extends ControlState {
  final InvItemModel item;
  AddItemSuccess({
    required this.item,
  });

}

class AddItemFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  AddItemFailure({
    required this.errMessage,
    required this.errors,
  });

}

class ViewItemsSuccess extends ControlState {
  final List<InvItemModel> items;
  ViewItemsSuccess({
    required this.items,
  });
}
class ViewItemsFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  ViewItemsFailure({
    required this.errMessage,
    required this.errors,
  });

}
class ItemEmpty extends ControlState{}

class ViewItemSuccess extends ControlState {
  final InvItemModel item;
  ViewItemSuccess({
    required this.item,
  });

}

class ViewItemFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  ViewItemFailure({
    required this.errMessage,
    required this.errors,
  });

}

class DeleteItemSuccess extends ControlState {}
class DeleteItemFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  DeleteItemFailure({
    required this.errMessage,
    required this.errors,
  });
}

class ItemEditSuccess extends ControlState{}

class ItemEditFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
 ItemEditFailure({
    required this.errMessage,
    required this.errors,
  });
  
}

class ChangeLogSuccess extends ControlState{}

class ChangeLogFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
 ChangeLogFailure({
    required this.errMessage,
    required this.errors,
  });
  
}


//=====================================================================
//========================= Disease Detection =========================
//=====================================================================
class DiseaseScanSuccess extends ControlState {
  final DiseaseDetectionModel info;
  DiseaseScanSuccess({
    required this.info,
  });
}

class DiseaseScanFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  DiseaseScanFailure({
    required this.errMessage,
    required this.errors,
  });

}

class ViewDetectionsSuccess extends ControlState{
  final List<DiseaseDetectionModel> info;
  ViewDetectionsSuccess({
    required this.info});
}
class ViewDiseaseDetectionsFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  ViewDiseaseDetectionsFailure({
    required this.errMessage,
    required this.errors,
  });

}
class DiseaseDetectionEmpty extends ControlState{}
class DiseaseDetectionSuccess extends ControlState {
  final DiseaseDetectionModel info;
  DiseaseDetectionSuccess({
    required this.info,
  });
  
}
class DiseaseDetectionFailure extends ControlState {
  final String errMessage;
  final dynamic errors;
  DiseaseDetectionFailure({
    required this.errMessage,
    required this.errors,
  });
}
