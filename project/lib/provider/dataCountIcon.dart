class DataCount {
  double? data;
  Function(double?)? onDataReturned;

  DataCount({this.data, this.onDataReturned});

  void SetData(double newdata){
    print("Setdata");
    data = newdata;
    onDataReturned?.call(data);
  }
}