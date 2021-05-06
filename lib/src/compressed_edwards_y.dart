import 'package:curve25519/src/edwards_point.dart';
import 'package:curve25519/src/extensions.dart';
import 'package:curve25519/src/field_element.dart';

final _d = FieldElement([
  -10913610, 13857413, -15372611, 6949391, 114729, //
  -8787816, -6275908, -3247719, -18696448, -12055116,
]);

class CompressedEdwardsY {
  CompressedEdwardsY(this.data);

  final List<int> data;

  EdwardsPoint decompress() {
    final FieldElement y = FieldElement.fromByteArray(data);
    final FieldElement ySquare = y.square();
    final FieldElement u = ySquare - FieldElement.one;
    final FieldElement v = ySquare * _d + FieldElement.one;
    final SqrtRatioM1Result sqrt = FieldElement.sqrtRatioM1(u, v);
    if (sqrt.wasSquare != 1) {
      throw const FormatException('not a valid point');
    }
    final FieldElement sqrtResult = sqrt.result;
    final int isNegative = sqrtResult.isNegative();
    final FieldElement x =
        (-sqrt.result).select(sqrt.result, isNegative.fastEqual(data.bit(255)));
    return EdwardsPoint(x, y, FieldElement.one, x * y);
  }

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) =>
      other is CompressedEdwardsY && fastEqual(other) == 1;

  int fastEqual(CompressedEdwardsY other) => data.fastEqual(other.data);
}
