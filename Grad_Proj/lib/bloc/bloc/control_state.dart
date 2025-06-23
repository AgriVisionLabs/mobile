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
