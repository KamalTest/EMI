public class GoogleDriveController {
        private String code;
        
        public boolean val {
            get;
            set;
            }
        
        public blob file {
            get;
            set;
            }
        
        public String filetype {
            get;
            set;
            }
           
        public String filename {
            get;
            set;
            }
        string key = '343234672829-ndfl29mpjntnu80nmgs3f0pa202lhcv9.apps.googleusercontent.com';
        string secret = 'hNJ09rcMrHpQlfvZV5XcPo5s';
        string redirect_uri = 'https://c.ap5.visual.force.com/apex/GoogleDrive';
        private String accesstoken;
        private Integer expiresIn;
        private String tokentype;
        public GoogleDriveController() {
            key = '343234672829-ndfl29mpjntnu80nmgs3f0pa202lhcv9.apps.googleusercontent.com';
          secret = 'hNJ09rcMrHpQlfvZV5XcPo5s';
          redirect_uri = 'https://c.ap5.visual.force.com/apex/GoogleDrive';
            system.debug(GoogleDriveAuthUri(key, redirect_uri));
        AccessToken();
       /* code = ApexPages.currentPage().getParameters().get('code');
        //Get the access token once we have code
        if (code != '' ) {
        AccessToken();
         }*/
        }
        public PageReference DriveAuth() {
          key = '343234672829-ndfl29mpjntnu80nmgs3f0pa202lhcv9.apps.googleusercontent.com';
          secret = 'hNJ09rcMrHpQlfvZV5XcPo5s';
          redirect_uri = 'https://c.ap5.visual.force.com/apex/GoogleDrive';
        //Authenticating
        PageReference pg = new PageReference(GoogleDriveAuthUri(key, redirect_uri));
        return pg;
        }
        
        public String GoogleDriveAuthUri(String Clientkey, String redirect_uri) {
        String key = EncodingUtil.urlEncode(Clientkey, 'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri, 'UTF-8');
        String authuri = '';
       authuri = 'https://accounts.google.com/o/oauth2/auth?'+
            'client_id='+key+        
           '&response_type=code' +
            '&scope=https://www.googleapis.com/auth/drive'+
            '&redirect_uri='+uri+
            '&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome'+
            '&login_hint=er.kamal26@gmail.com&'+
            'access_type=offline';
           /* authuri = 'https://accounts.google.com/o/oauth2/auth?'+        
            'access_type=offline'+
             '&approval_prompt=force';*/
            system.debug(authUri);
               return authuri;
            }
        public void UploadFile() {
        String boundary = '----------9889464542212';
        String delimiter = '\r\n--' + boundary + '\r\n';
        String close_delim = '\r\n--' + boundary + '--';
        String bodyEncoded = EncodingUtil.base64Encode(file);
        String body = delimiter + 'Content-Type: application/json\r\n\r\n' + '{ "title" : "' + filename + '",' + ' "mimeType" : "' + filetype + '" }' + delimiter + 'Content-Type: ' + filetype + '\r\n' + 'Content-Transfer-Encoding: base64\r\n' + '\r\n' + bodyEncoded + close_delim;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart');
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-Type', 'multipart/mixed; boundary="' + boundary + '"');
        req.setHeader('Content-length', String.valueOf(body.length()));
        req.setBody(body);
        req.setMethod('POST');
        req.setTimeout(60 * 1000);
        HttpResponse resp = http.send(req);
            system.debug(resp);
        file = null;
        filetype = '';
        filename = '';
        }
        public void AccessToken() {
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code=' + code + '&client_id=' + key + '&client_secret=' + secret + '&redirect_uri=' + redirect_uri + '&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60 * 1000);
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        JSONParser parser = JSON.createParser(resp);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
            String fieldName = parser.getText();
            parser.nextToken();
            if (fieldName == 'access_token') {
            accesstoken = parser.getText();
            } else if (fieldName == 'expires_in') {
             expiresIn = parser.getIntegerValue();
            } else if (fieldname == 'token_type') {
             tokentype = parser.getText();
            }
         } }
         System.debug(' You can parse the response to get the access token ::: ' + resp);
            }
        }