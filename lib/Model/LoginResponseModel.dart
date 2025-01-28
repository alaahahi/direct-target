class LoginResponseModel {
  String? message;
  String? description;
  String? username;
  String? branchId;
  String? branchName;
  String? empName;

  LoginResponseModel(
      {this.message,
      this.description,
      this.username,
      this.branchId,
      this.branchName,
      this.empName});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    description = json['description'];
    username = json['username'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    empName = json['emp_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['description'] = description;
    data['username'] = username;
    data['branch_id'] = branchId;
    data['branch_name'] = branchName;
    data['emp_name'] = empName;
    return data;
  }
}
