// Original file: heartbeat.proto


export interface HeartbeatLocation {
  'ip'?: (string);
  'city'?: (string);
  'region'?: (string);
  'country'?: (string);
  'latitude'?: (number | string);
  'longitude'?: (number | string);
  'org'?: (string);
  'postal'?: (string);
  'timezone'?: (string);
  '_ip'?: "ip";
  '_city'?: "city";
  '_region'?: "region";
  '_country'?: "country";
  '_latitude'?: "latitude";
  '_longitude'?: "longitude";
  '_org'?: "org";
  '_postal'?: "postal";
  '_timezone'?: "timezone";
}

export interface HeartbeatLocation__Output {
  'ip'?: (string);
  'city'?: (string);
  'region'?: (string);
  'country'?: (string);
  'latitude'?: (number);
  'longitude'?: (number);
  'org'?: (string);
  'postal'?: (string);
  'timezone'?: (string);
  '_ip': "ip";
  '_city': "city";
  '_region': "region";
  '_country': "country";
  '_latitude': "latitude";
  '_longitude': "longitude";
  '_org': "org";
  '_postal': "postal";
  '_timezone': "timezone";
}
