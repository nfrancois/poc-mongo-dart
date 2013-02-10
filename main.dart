//import 'package:objectory/objectory.dart';
import 'package:objectory/objectory_console.dart';
import 'dart:io';

var dao;

main(){
  objectory = new ObjectoryDirectConnectionImpl("mongodb://poc:pocd4rt@ds037857.mongolab.com:37857/poc",_registerClasses, false);
  objectory.initDomainModel();  
  
  dao = new  BuildDao();
  
  var server = new HttpServer()
  ..listen("0.0.0.0", 8080)
  ..defaultRequestHandler = _serve;
  
}

_registerClasses(){
  objectory.registerClass(Build.NAME, () => new Build()); 
}  

_serve(HttpRequest request, HttpResponse response){
  if(request.path == "/"){
    dao.all().then((List builds) => _handleResponse(response, builds));
  } else {
    String job = request.path.substring(1);
    dao.findByJob(job).then((List builds) => _handleResponse(response, builds));
  }
  
}

_handleResponse(HttpResponse response, List builds){
  response.outputStream..writeString(builds.toString())
                       ..close();  
}

class Build extends PersistentObject {
  
  static final String NAME = "Build";
  static final String BUILD_ID_PARAM = "buildId";
  static final String JOB_PARAM = "job";
  //static final String DATE_PARAM = "date";
  static final String STATUS_PARAM = "status";
  
  Build();
  
  Build.from(this.buildId, this.job, this.status);
  
  int get buildId => getProperty(BUILD_ID_PARAM);
  set buildId(int value) => setProperty(BUILD_ID_PARAM, value);
  
  String get job => getProperty(JOB_PARAM);
  set job(String value) => setProperty(JOB_PARAM, value); 

  //String get date => getProperty(DATE_PARAM);
  //set date(String value) => setProperty(DATE_PARAM, value);
  
  String get status => getProperty(STATUS_PARAM);
  set status(String value) => setProperty(STATUS_PARAM, value);
  
  String toString() => "[buildId=$buildId job=$job status=$status]";
  
}


class BuildDao {
  
  BuildDao(){

  }
  
  Future<List<Build>> all(){
    return objectory.find(_where);
  }
  
  Future<List<Build>> findByJob(String jobName){
    return objectory.find(_where.eq(Build.JOB_PARAM, jobName));
  }
  
  ObjectoryQueryBuilder get _where => new ObjectoryQueryBuilder(Build.NAME);
  
}

