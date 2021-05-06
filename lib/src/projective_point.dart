import 'package:curve25519/src/completed_point.dart';
import 'package:curve25519/src/edwards_point.dart';
import 'package:curve25519/src/field_element.dart';

class ProjectivePoint {
  ProjectivePoint(this.x, this.y, this.z);

  final FieldElement x;
  final FieldElement y;
  final FieldElement z;

  EdwardsPoint toExtended() => EdwardsPoint(
        x * z,
        y * z,
        z.square(),
        x * y,
      );

  CompletedPoint dbl() {
    final FieldElement xx = x.square();
    final FieldElement yy = y.square();
    final FieldElement zz2 = z.squareAndDouble();
    final FieldElement xPlusY = x + y;
    final FieldElement xPlusYSq = xPlusY.square();
    final FieldElement yyPlusXX = yy + xx;
    final FieldElement yyMinusXX = yy - xx;
    return CompletedPoint(
      xPlusYSq - yyPlusXX,
      yyPlusXX,
      yyMinusXX,
      zz2 - yyMinusXX,
    );
  }
}
