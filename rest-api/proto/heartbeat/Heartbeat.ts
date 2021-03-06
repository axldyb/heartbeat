// Original file: heartbeat.proto

import type { Timestamp as _google_protobuf_Timestamp, Timestamp__Output as _google_protobuf_Timestamp__Output } from '../google/protobuf/Timestamp';
import type { HeartbeatClient as _heartbeat_HeartbeatClient, HeartbeatClient__Output as _heartbeat_HeartbeatClient__Output } from '../heartbeat/HeartbeatClient';
import type { HeartbeatDevice as _heartbeat_HeartbeatDevice, HeartbeatDevice__Output as _heartbeat_HeartbeatDevice__Output } from '../heartbeat/HeartbeatDevice';
import type { HeartbeatLocation as _heartbeat_HeartbeatLocation, HeartbeatLocation__Output as _heartbeat_HeartbeatLocation__Output } from '../heartbeat/HeartbeatLocation';

export interface Heartbeat {
  'id'?: (string);
  'timestamp'?: (_google_protobuf_Timestamp | null);
  'client'?: (_heartbeat_HeartbeatClient | null);
  'device'?: (_heartbeat_HeartbeatDevice | null);
  'location'?: (_heartbeat_HeartbeatLocation | null);
}

export interface Heartbeat__Output {
  'id': (string);
  'timestamp': (_google_protobuf_Timestamp__Output | null);
  'client': (_heartbeat_HeartbeatClient__Output | null);
  'device': (_heartbeat_HeartbeatDevice__Output | null);
  'location': (_heartbeat_HeartbeatLocation__Output | null);
}
