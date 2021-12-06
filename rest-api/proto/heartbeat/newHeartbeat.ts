// Original file: heartbeat.proto

import type { HeartbeatClient as _heartbeat_HeartbeatClient, HeartbeatClient__Output as _heartbeat_HeartbeatClient__Output } from '../heartbeat/HeartbeatClient';
import type { HeartbeatDevice as _heartbeat_HeartbeatDevice, HeartbeatDevice__Output as _heartbeat_HeartbeatDevice__Output } from '../heartbeat/HeartbeatDevice';

export interface newHeartbeat {
  'client'?: (_heartbeat_HeartbeatClient | null);
  'device'?: (_heartbeat_HeartbeatDevice | null);
}

export interface newHeartbeat__Output {
  'client': (_heartbeat_HeartbeatClient__Output | null);
  'device': (_heartbeat_HeartbeatDevice__Output | null);
}
