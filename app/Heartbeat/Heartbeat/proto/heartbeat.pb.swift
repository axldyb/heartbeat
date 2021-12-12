// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: heartbeat.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Heartbeat_Empty {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Heartbeat_HeartbeatList {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var heartbeats: [Heartbeat_Heartbeat] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Heartbeat_HeartbeatId {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Heartbeat_HeartbeatCount {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var count: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Heartbeat_Heartbeat {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String {
    get {return _storage._id}
    set {_uniqueStorage()._id = newValue}
  }

  var timestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._timestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._timestamp = newValue}
  }
  /// Returns true if `timestamp` has been explicitly set.
  var hasTimestamp: Bool {return _storage._timestamp != nil}
  /// Clears the value of `timestamp`. Subsequent reads from it will return its default value.
  mutating func clearTimestamp() {_uniqueStorage()._timestamp = nil}

  var client: Heartbeat_HeartbeatClient {
    get {return _storage._client ?? Heartbeat_HeartbeatClient()}
    set {_uniqueStorage()._client = newValue}
  }
  /// Returns true if `client` has been explicitly set.
  var hasClient: Bool {return _storage._client != nil}
  /// Clears the value of `client`. Subsequent reads from it will return its default value.
  mutating func clearClient() {_uniqueStorage()._client = nil}

  var device: Heartbeat_HeartbeatDevice {
    get {return _storage._device ?? Heartbeat_HeartbeatDevice()}
    set {_uniqueStorage()._device = newValue}
  }
  /// Returns true if `device` has been explicitly set.
  var hasDevice: Bool {return _storage._device != nil}
  /// Clears the value of `device`. Subsequent reads from it will return its default value.
  mutating func clearDevice() {_uniqueStorage()._device = nil}

  var location: Heartbeat_HeartbeatLocation {
    get {return _storage._location ?? Heartbeat_HeartbeatLocation()}
    set {_uniqueStorage()._location = newValue}
  }
  /// Returns true if `location` has been explicitly set.
  var hasLocation: Bool {return _storage._location != nil}
  /// Clears the value of `location`. Subsequent reads from it will return its default value.
  mutating func clearLocation() {_uniqueStorage()._location = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Heartbeat_HeartbeatClient {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var name: String = String()

  var version: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Heartbeat_HeartbeatDevice {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var name: String = String()

  var os: String = String()

  var osVersion: String = String()

  var model: String = String()

  var language: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Heartbeat_HeartbeatLocation {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var ip: String {
    get {return _ip ?? String()}
    set {_ip = newValue}
  }
  /// Returns true if `ip` has been explicitly set.
  var hasIp: Bool {return self._ip != nil}
  /// Clears the value of `ip`. Subsequent reads from it will return its default value.
  mutating func clearIp() {self._ip = nil}

  var city: String {
    get {return _city ?? String()}
    set {_city = newValue}
  }
  /// Returns true if `city` has been explicitly set.
  var hasCity: Bool {return self._city != nil}
  /// Clears the value of `city`. Subsequent reads from it will return its default value.
  mutating func clearCity() {self._city = nil}

  var region: String {
    get {return _region ?? String()}
    set {_region = newValue}
  }
  /// Returns true if `region` has been explicitly set.
  var hasRegion: Bool {return self._region != nil}
  /// Clears the value of `region`. Subsequent reads from it will return its default value.
  mutating func clearRegion() {self._region = nil}

  var country: String {
    get {return _country ?? String()}
    set {_country = newValue}
  }
  /// Returns true if `country` has been explicitly set.
  var hasCountry: Bool {return self._country != nil}
  /// Clears the value of `country`. Subsequent reads from it will return its default value.
  mutating func clearCountry() {self._country = nil}

  var latitude: Double {
    get {return _latitude ?? 0}
    set {_latitude = newValue}
  }
  /// Returns true if `latitude` has been explicitly set.
  var hasLatitude: Bool {return self._latitude != nil}
  /// Clears the value of `latitude`. Subsequent reads from it will return its default value.
  mutating func clearLatitude() {self._latitude = nil}

  var longitude: Double {
    get {return _longitude ?? 0}
    set {_longitude = newValue}
  }
  /// Returns true if `longitude` has been explicitly set.
  var hasLongitude: Bool {return self._longitude != nil}
  /// Clears the value of `longitude`. Subsequent reads from it will return its default value.
  mutating func clearLongitude() {self._longitude = nil}

  var org: String {
    get {return _org ?? String()}
    set {_org = newValue}
  }
  /// Returns true if `org` has been explicitly set.
  var hasOrg: Bool {return self._org != nil}
  /// Clears the value of `org`. Subsequent reads from it will return its default value.
  mutating func clearOrg() {self._org = nil}

  var postal: String {
    get {return _postal ?? String()}
    set {_postal = newValue}
  }
  /// Returns true if `postal` has been explicitly set.
  var hasPostal: Bool {return self._postal != nil}
  /// Clears the value of `postal`. Subsequent reads from it will return its default value.
  mutating func clearPostal() {self._postal = nil}

  var timezone: String {
    get {return _timezone ?? String()}
    set {_timezone = newValue}
  }
  /// Returns true if `timezone` has been explicitly set.
  var hasTimezone: Bool {return self._timezone != nil}
  /// Clears the value of `timezone`. Subsequent reads from it will return its default value.
  mutating func clearTimezone() {self._timezone = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _ip: String? = nil
  fileprivate var _city: String? = nil
  fileprivate var _region: String? = nil
  fileprivate var _country: String? = nil
  fileprivate var _latitude: Double? = nil
  fileprivate var _longitude: Double? = nil
  fileprivate var _org: String? = nil
  fileprivate var _postal: String? = nil
  fileprivate var _timezone: String? = nil
}

struct Heartbeat_newHeartbeat {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var client: Heartbeat_HeartbeatClient {
    get {return _client ?? Heartbeat_HeartbeatClient()}
    set {_client = newValue}
  }
  /// Returns true if `client` has been explicitly set.
  var hasClient: Bool {return self._client != nil}
  /// Clears the value of `client`. Subsequent reads from it will return its default value.
  mutating func clearClient() {self._client = nil}

  var device: Heartbeat_HeartbeatDevice {
    get {return _device ?? Heartbeat_HeartbeatDevice()}
    set {_device = newValue}
  }
  /// Returns true if `device` has been explicitly set.
  var hasDevice: Bool {return self._device != nil}
  /// Clears the value of `device`. Subsequent reads from it will return its default value.
  mutating func clearDevice() {self._device = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _client: Heartbeat_HeartbeatClient? = nil
  fileprivate var _device: Heartbeat_HeartbeatDevice? = nil
}

struct Heartbeat_result {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var status: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "heartbeat"

extension Heartbeat_Empty: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Empty"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_Empty, rhs: Heartbeat_Empty) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_HeartbeatList: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".HeartbeatList"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "heartbeats"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.heartbeats) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.heartbeats.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.heartbeats, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_HeartbeatList, rhs: Heartbeat_HeartbeatList) -> Bool {
    if lhs.heartbeats != rhs.heartbeats {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_HeartbeatId: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".HeartbeatId"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.id) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_HeartbeatId, rhs: Heartbeat_HeartbeatId) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_HeartbeatCount: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".HeartbeatCount"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "count"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.count) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.count != 0 {
      try visitor.visitSingularInt32Field(value: self.count, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_HeartbeatCount, rhs: Heartbeat_HeartbeatCount) -> Bool {
    if lhs.count != rhs.count {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_Heartbeat: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Heartbeat"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "timestamp"),
    3: .same(proto: "client"),
    4: .same(proto: "device"),
    5: .same(proto: "location"),
  ]

  fileprivate class _StorageClass {
    var _id: String = String()
    var _timestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _client: Heartbeat_HeartbeatClient? = nil
    var _device: Heartbeat_HeartbeatDevice? = nil
    var _location: Heartbeat_HeartbeatLocation? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _id = source._id
      _timestamp = source._timestamp
      _client = source._client
      _device = source._device
      _location = source._location
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularStringField(value: &_storage._id) }()
        case 2: try { try decoder.decodeSingularMessageField(value: &_storage._timestamp) }()
        case 3: try { try decoder.decodeSingularMessageField(value: &_storage._client) }()
        case 4: try { try decoder.decodeSingularMessageField(value: &_storage._device) }()
        case 5: try { try decoder.decodeSingularMessageField(value: &_storage._location) }()
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every if/case branch local when no optimizations
      // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
      // https://github.com/apple/swift-protobuf/issues/1182
      if !_storage._id.isEmpty {
        try visitor.visitSingularStringField(value: _storage._id, fieldNumber: 1)
      }
      try { if let v = _storage._timestamp {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      } }()
      try { if let v = _storage._client {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      } }()
      try { if let v = _storage._device {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      } }()
      try { if let v = _storage._location {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
      } }()
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_Heartbeat, rhs: Heartbeat_Heartbeat) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._id != rhs_storage._id {return false}
        if _storage._timestamp != rhs_storage._timestamp {return false}
        if _storage._client != rhs_storage._client {return false}
        if _storage._device != rhs_storage._device {return false}
        if _storage._location != rhs_storage._location {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_HeartbeatClient: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".HeartbeatClient"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "name"),
    3: .same(proto: "version"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.version) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 2)
    }
    if !self.version.isEmpty {
      try visitor.visitSingularStringField(value: self.version, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_HeartbeatClient, rhs: Heartbeat_HeartbeatClient) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.name != rhs.name {return false}
    if lhs.version != rhs.version {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_HeartbeatDevice: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".HeartbeatDevice"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "name"),
    3: .same(proto: "os"),
    4: .same(proto: "osVersion"),
    5: .same(proto: "model"),
    6: .same(proto: "language"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.os) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.osVersion) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self.model) }()
      case 6: try { try decoder.decodeSingularStringField(value: &self.language) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 2)
    }
    if !self.os.isEmpty {
      try visitor.visitSingularStringField(value: self.os, fieldNumber: 3)
    }
    if !self.osVersion.isEmpty {
      try visitor.visitSingularStringField(value: self.osVersion, fieldNumber: 4)
    }
    if !self.model.isEmpty {
      try visitor.visitSingularStringField(value: self.model, fieldNumber: 5)
    }
    if !self.language.isEmpty {
      try visitor.visitSingularStringField(value: self.language, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_HeartbeatDevice, rhs: Heartbeat_HeartbeatDevice) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.name != rhs.name {return false}
    if lhs.os != rhs.os {return false}
    if lhs.osVersion != rhs.osVersion {return false}
    if lhs.model != rhs.model {return false}
    if lhs.language != rhs.language {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_HeartbeatLocation: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".HeartbeatLocation"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "ip"),
    2: .same(proto: "city"),
    3: .same(proto: "region"),
    4: .same(proto: "country"),
    5: .same(proto: "latitude"),
    6: .same(proto: "longitude"),
    7: .same(proto: "org"),
    8: .same(proto: "postal"),
    9: .same(proto: "timezone"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._ip) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._city) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self._region) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self._country) }()
      case 5: try { try decoder.decodeSingularDoubleField(value: &self._latitude) }()
      case 6: try { try decoder.decodeSingularDoubleField(value: &self._longitude) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self._org) }()
      case 8: try { try decoder.decodeSingularStringField(value: &self._postal) }()
      case 9: try { try decoder.decodeSingularStringField(value: &self._timezone) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._ip {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._city {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._region {
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._country {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._latitude {
      try visitor.visitSingularDoubleField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._longitude {
      try visitor.visitSingularDoubleField(value: v, fieldNumber: 6)
    } }()
    try { if let v = self._org {
      try visitor.visitSingularStringField(value: v, fieldNumber: 7)
    } }()
    try { if let v = self._postal {
      try visitor.visitSingularStringField(value: v, fieldNumber: 8)
    } }()
    try { if let v = self._timezone {
      try visitor.visitSingularStringField(value: v, fieldNumber: 9)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_HeartbeatLocation, rhs: Heartbeat_HeartbeatLocation) -> Bool {
    if lhs._ip != rhs._ip {return false}
    if lhs._city != rhs._city {return false}
    if lhs._region != rhs._region {return false}
    if lhs._country != rhs._country {return false}
    if lhs._latitude != rhs._latitude {return false}
    if lhs._longitude != rhs._longitude {return false}
    if lhs._org != rhs._org {return false}
    if lhs._postal != rhs._postal {return false}
    if lhs._timezone != rhs._timezone {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_newHeartbeat: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".newHeartbeat"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "client"),
    2: .same(proto: "device"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._client) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._device) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._client {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._device {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_newHeartbeat, rhs: Heartbeat_newHeartbeat) -> Bool {
    if lhs._client != rhs._client {return false}
    if lhs._device != rhs._device {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Heartbeat_result: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".result"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "status"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.status) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.status.isEmpty {
      try visitor.visitSingularStringField(value: self.status, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Heartbeat_result, rhs: Heartbeat_result) -> Bool {
    if lhs.status != rhs.status {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
