class AppUrl {

  static var webSocketProtocol = 'wss' ;
  static var httpsProtocol = 'https' ;
  static var baseUrl = '://rdpms.in:7081' ;
  static var websocketApiEndPoint = '${webSocketProtocol}${baseUrl}/flow_api/event/sub' ; // Create
  static var dropdownApiEndPoint = '${httpsProtocol}${baseUrl}/flow_api/source' ; // Create

}
