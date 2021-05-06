import 'package:curve25519/src/edwards_point.dart';
import 'package:curve25519/src/field_element.dart';
import 'package:curve25519/src/projective_point.dart';

class CompletedPoint {
  CompletedPoint(this.x, this.y, this.z, this.t);

  final FieldElement x;
  final FieldElement y;
  final FieldElement z;
  final FieldElement t;

  ProjectivePoint toProjective() => ProjectivePoint(
        x * t,
        y * z,
        z * t,
      );

  EdwardsPoint toExtended() => EdwardsPoint(
        x * t,
        y * z,
        z * t,
        x * y,
      );
}
