
class BackendResponse<T>{
  final T data;
  final String error;

  BackendResponse(this.data, this.error);

  BackendResponse.fromJson(Map json) :
    data = json["data"],
    error = json["error"];
}