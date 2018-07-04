pragma solidity 0.4.23;

import "./Bytes32sStore.sol";


contract Bytes32sStoreExternal is Bytes32sStore {
  function createBytes32(bytes32 key, bytes32 value) external returns (bool) {
    return _createBytes32(key, value);
  }
  
  function createBytes32s(bytes32[] keys, bytes32[] values) external returns (bool) {
    return _createBytes32s(keys, values);
  }
  
  function updateBytes32(bytes32 key, bytes32 value) external returns (bool) {
    return _updateBytes32(key, value);   
  }
  
  function updateBytes32s(bytes32[] keys, bytes32[] values) external returns (bool) {
    return _updateBytes32s(keys, values);
  }
  
  function removeBytes32(bytes32 key) external returns (bool) {
    return _removeBytes32(key);
  }
  
  function removeBytes32s(bytes32[] keys) external returns (bool) {
    return _removeBytes32s(keys);
  }

  function readBytes32(bytes32 key) external view returns (bytes32) {
    return _readBytes32(key);
  }
  
  function readBytes32s(bytes32[] keys) external view returns (bytes32[]) {
    return _readBytes32s(keys);
  }
}