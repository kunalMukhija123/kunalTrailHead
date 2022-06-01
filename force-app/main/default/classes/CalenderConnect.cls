public class CalenderConnect {
    private final string googleClientID = ' Your Project ID';
    private final string googleSecretCode = 'Your Project Secret';
    private final string redirectURI = 'https://c.ap1.visual.force.com/apex/calender';
    private string authorizationCode = '';
    private string state = '';
    private string accessToken;
    private string refreshToken;
    private string expiresIn;
    private string tokenType;
 
     public CalenderConnect(){
        authorizationCode = System.currentPageReference().getParameters().get('code');
        if(authorizationCode != null){
            state = System.currentPageReference().getParameters().get('state');
            accessToken = '';
                retrieveGoogleAccessToken();
                if(accessToken <> ''){
                    addCalendarEntry();
                }              
        }
    }

    public pageReference doGoogleConnectCall(){

        PageReference pr = new PageReference('https://accounts.google.com/o/oauth2/auth' +
            '?response_type=code' +
            '&client_id=' + googleClientID +
            '&redirect_uri=' + redirectURI +
            '&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar' +
            '&state=' + 'vcalender ' +
            '&access_type=online' +
            '&approval_prompt=auto' +  //auto, force
            '&login_hint=Svikas.csi@gmail.com');
            System.debug(pr);
        return pr;
    }
    private void retrieveGoogleAccessToken(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string endPointValue = 'https://accounts.google.com/o/oauth2/token';  
        req.setEndpoint(endPointValue);
     
        string bodyRequest = '';
        bodyRequest = 'code=' + EncodingUtil.urlEncode(authorizationCode, 'UTF-8');
        bodyRequest += '&client_id=' + EncodingUtil.urlEncode(googleClientID, 'UTF-8');
        bodyRequest += '&client_secret=' + EncodingUtil.urlEncode(googleSecretCode, 'UTF-8');
        bodyRequest += '&redirect_uri=' + EncodingUtil.urlEncode(redirectURI, 'UTF-8');
        bodyRequest += '&grant_type=authorization_code';
        req.setBody(bodyRequest);    
        req.setHeader('Content-length', string.ValueOf(bodyRequest.length()));
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setMethod('POST');
        req.setTimeout(10000);
        HttpResponse res = h.send(req);  
        map<string, string> jsonValues = new map<string, string>();
     
        System.debug('Response Value:'+res.getBody());
        jsonValues = parseJSONToMap(res.getBody());
        if(jsonValues.containsKey('error')){
        }else{
            //Try to get a cell value in the Google Spreadsheet
            accessToken = jsonValues.get('access_token');
            refreshToken = jsonValues.get('refresh_token');
            expiresIn = jsonValues.get('expires_in');
            tokenType = jsonValues.get('token_type');        
        }    
    }
      private void addCalendarEntry(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string endPointValue = 'https://www.googleapis.com/calendar/v3/calendars/primary/events';
        //This end point does seem to work, but it is not creating an event, just creating a new calendar
        //endPointValue = 'https://www.googleapis.com/calendar/v3/calendars?key=' + googleClientID;
        req.setEndpoint(endPointValue);  
        string bodyRequest = '';
        bodyRequest = '{';
        bodyRequest += '\r\n';
        bodyRequest += '"summary": "Sales Call",';
        bodyRequest += '\r\n';
        bodyRequest += '"location": "Conference Room A",';
        bodyRequest += '\r\n';
        bodyRequest += '"start": {';
        bodyRequest += '\r\n';
        bodyRequest += '"dateTime": "2014-07-26T08:00:00.000-07:00",';
        bodyRequest += '\r\n';
        bodyRequest += '"timeZone": "America/Los_Angeles"';
        bodyRequest += '\r\n';
        bodyRequest += '},';
        bodyRequest += '\r\n';
        bodyRequest += '"end": {';
        bodyRequest += '\r\n';
        bodyRequest += '"dateTime": "2014-07-26T08:30:00.000-07:00",';
        bodyRequest += '\r\n';
        bodyRequest += '"timeZone": "America/Los_Angeles"';
        bodyRequest += '\r\n';
        bodyRequest += '},';
        bodyRequest += '\r\n';
        bodyRequest += '"recurrence": [';
        bodyRequest += '\r\n';
        bodyRequest += '"RRULE:FREQ=WEEKLY;UNTIL=20131226T000000Z"';
        bodyRequest += '\r\n';
        bodyRequest += '],';      
        bodyRequest += '\r\n';
        bodyRequest += '"attendees": [';
        bodyRequest += '\r\n';
        bodyRequest += '{';
        bodyRequest += '\r\n';
        bodyRequest += '"email": "xxxxx@gmail.com"';
        bodyRequest += '\r\n';
        bodyRequest += '}';
        bodyRequest += '\r\n';
        bodyRequest += ']';
        bodyRequest += '}';
     
        req.setBody(bodyRequest);    
        System.debug(bodyRequest);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-length', string.ValueOf(bodyRequest.length()));
        req.setHeader('Content-Type', 'application/json; charset=UTF-8');
        req.setMethod('POST');
        req.setTimeout(10000);
        HttpResponse res = h.send(req);
        System.debug(res.getBody());
    }
 
    private map<string, string> parseJSONToMap(string JSONValue){
        JSONParser parser = JSON.createParser(JSONValue);
        map<string, string> jsonMap = new map<string, string>();
        string keyValue = '';
        string tempValue = '';
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME){
                keyValue = parser.getText();
                parser.nextToken();
                tempValue = parser.getText();
                jsonMap.put(keyValue, tempValue);            
            }
        }
        return jsonMap;
    }
 
}