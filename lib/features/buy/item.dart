import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Item {
  Item({
    required this.typeId,
    required this.title,
    required this.buyCents,
    required this.sellCents,
    required this.iconPath,
  }) : instanceId = _uuid.v4();

  final String instanceId;
  final String typeId;
  final String title;
  final int buyCents;
  final int sellCents;
  final String iconPath;

  String get buyLabel => '${(buyCents / 100).toStringAsFixed(2)}\$';

  String get sellLabel => '${(sellCents / 100).toStringAsFixed(2)}\$';

  Item duplicate() => Item(
    typeId: typeId,
    title: title,
    buyCents: buyCents,
    sellCents: sellCents,
    iconPath: iconPath,
  );
}
