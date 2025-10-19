class StudentModel {
  Id? iId;
  String? studentId;
  String? password;
  StudentData? studentData;

  StudentModel({this.iId, this.studentId, this.password, this.studentData});

  StudentModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? Id.fromJson(json['_id']) : null;
    studentId = json['studentId'];
    password = json['password'];
    studentData = json['studentData'] != null
        ? StudentData.fromJson(json['studentData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iId != null) {
      data['_id'] = iId!.toJson();
    }
    data['studentId'] = studentId;
    data['password'] = password;
    if (studentData != null) {
      data['studentData'] = studentData!.toJson();
    }
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$oid'] = oid;
    return data;
  }
}

class StudentData {
  BioData? bioData;
  PresentPerformance? presentPerformance;

  StudentData({this.bioData, this.presentPerformance});

  StudentData.fromJson(Map<String, dynamic> json) {
    bioData = json['bioData'] != null
        ? BioData.fromJson(json['bioData'])
        : null;
    presentPerformance = json['presentPerformance'] != null
        ? PresentPerformance.fromJson(json['presentPerformance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bioData != null) {
      data['bioData'] = bioData!.toJson();
    }
    if (presentPerformance != null) {
      data['presentPerformance'] = presentPerformance!.toJson();
    }
    return data;
  }
}

class BioData {
  String? admissionNo;
  String? rollNo;
  String? name;
  String? course;
  String? branch;
  String? semester;
  String? mobileNo;
  String? email;
  String? entranceType;
  String? seatType;
  String? joiningDate;
  String? eamcetEcetRank;
  String? caste;
  String? dob;
  String? adharNo;

  BioData({
    this.admissionNo,
    this.rollNo,
    this.name,
    this.course,
    this.branch,
    this.semester,
    this.mobileNo,
    this.email,
    this.entranceType,
    this.seatType,
    this.joiningDate,
    this.eamcetEcetRank,
    this.caste,
    this.dob,
    this.adharNo,
  });

  BioData.fromJson(Map<String, dynamic> json) {
    admissionNo = json['admissionNo'];
    rollNo = json['rollNo'];
    name = json['name'];
    course = json['course'];
    branch = json['branch'];
    semester = json['semester'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    entranceType = json['entranceType'];
    seatType = json['seatType'];
    joiningDate = json['joiningDate'];
    eamcetEcetRank = json['eamcet/ecetRank'];
    caste = json['caste'];
    dob = json['dob'];
    adharNo = json['adharNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admissionNo'] = admissionNo;
    data['rollNo'] = rollNo;
    data['name'] = name;
    data['course'] = course;
    data['branch'] = branch;
    data['semester'] = semester;
    data['mobileNo'] = mobileNo;
    data['email'] = email;
    data['entranceType'] = entranceType;
    data['seatType'] = seatType;
    data['joiningDate'] = joiningDate;
    data['eamcet/ecetRank'] = eamcetEcetRank;
    data['caste'] = caste;
    data['dob'] = dob;
    data['adharNo'] = adharNo;
    return data;
  }
}

class PresentPerformance {
  List<Attendance>? attendance;
  List<InternalMarks>? internalMarks;

  PresentPerformance({this.attendance, this.internalMarks});

  PresentPerformance.fromJson(Map<String, dynamic> json) {
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(Attendance.fromJson(v));
      });
    }
    if (json['internalMarks'] != null) {
      internalMarks = <InternalMarks>[];
      json['internalMarks'].forEach((v) {
        internalMarks!.add(InternalMarks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    if (internalMarks != null) {
      data['internalMarks'] = internalMarks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  String? subject;
  int? held;
  int? attended;
  double? percentage;

  Attendance({this.subject, this.held, this.attended, this.percentage});

  Attendance.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    held = json['held'];
    attended = json['attended'];
    percentage = (json['percentage'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['held'] = held;
    data['attended'] = attended;
    data['percentage'] = percentage;
    return data;
  }
}

class InternalMarks {
  String? exam;
  Marks? marks;
  String? total;

  InternalMarks({this.exam, this.marks, this.total});

  InternalMarks.fromJson(Map<String, dynamic> json) {
    exam = json['exam'];
    marks = json['marks'] != null ? Marks.fromJson(json['marks']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam'] = exam;
    if (marks != null) {
      data['marks'] = marks!.toJson();
    }
    data['total'] = total;
    return data;
  }
}

class Marks {
  late Map<String, dynamic> _subjectMarks;

  Marks({required Map<String, dynamic> subjectMarks})
    : _subjectMarks = subjectMarks;

  Marks.fromJson(Map<String, dynamic> json) {
    _subjectMarks = Map<String, dynamic>.from(json);
  }

  /// Returns the mark for a given subject, e.g., "PA", "WSMA LAB".
  /// Returns null if the subject is not found.
  String? getMarkForSubject(String subjectKey) {
    // Use toString() to handle different data types gracefully.
    return _subjectMarks[subjectKey]?.toString();
  }

  Map<String, dynamic> toJson() {
    return _subjectMarks;
  }
}
