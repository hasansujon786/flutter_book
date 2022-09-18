import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FacePileScreen extends StatefulWidget {
  const FacePileScreen({Key? key}) : super(key: key);

  static const routeName = '/face_pile';
  @override
  State<FacePileScreen> createState() => _FacePileScreenState();
}

class _FacePileScreenState extends State<FacePileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FacePile'),
      ),
      body: const Center(
        child: AvaterCircle(
          user: UserData(id: 'sdf', firstName: 'Hasan Mahmud', avaterUrl: 'sdf'),
          nameLabelColor: Colors.black,
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}

class AvaterCircle extends StatefulWidget {
  const AvaterCircle({
    Key? key,
    required this.user,
    required this.nameLabelColor,
    required this.backgroundColor,
    this.size = 40.0,
  }) : super(key: key);

  final UserData user;
  final double size;
  final Color nameLabelColor;
  final Color backgroundColor;

  @override
  State<AvaterCircle> createState() => _AvaterCircleState();
}

class _AvaterCircleState extends State<AvaterCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 5,
          )
        ],
      ),
    );
  }
}

class UserData {
  const UserData({required this.id, required this.firstName, required this.avaterUrl});
  final String id;
  final String firstName;
  final String avaterUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserData && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
