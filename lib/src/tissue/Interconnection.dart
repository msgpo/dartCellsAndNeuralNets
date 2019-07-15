
import 'package:neuralNetExperiments/src/tissue/TissueChangeListener.dart';
import 'package:neuralNetExperiments/src/tissue/tissue.dart';

/// Connection from one tissue to another.  Represents an
class Interconnection implements TissueChangeListener {

  Tissue _from;
  Tissue _to;

  List<List<double>> _tissueConnections;

  Interconnection(this._from, this._to) {
    this._tissueConnections = List<List<double>>.filled(_to.cellCount, 
      List<double>.filled(_from.cellCount, 0.0, growable: true),
      growable: true
    );

    this._to.listen(this);
  }

  double weight(int from, int to) {
    return _tissueConnections[from][to];
  }

  void connect(int from, int to, double strength) {
    _tissueConnections[from][to] = strength;
  }

  void updateOutgoingConnections() {
    _tissueConnections.forEach((destinationCellRow) => destinationCellRow.add(0.0));
  }

  @override
  void onAddCell() {
    _tissueConnections.add(List<double>.filled(_from.cellCount, 0.0));
  }

}