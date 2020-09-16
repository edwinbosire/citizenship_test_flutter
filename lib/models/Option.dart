import 'OptionStatus.dart';

class Option {
  final String title;
  OptionStatus status;

  Option(this.title, {this.status = OptionStatus.notSelected});

  set updateStatus(OptionStatus newStatus) {
    status = newStatus;
    print('new status set');
  }
}
