pragma solidity ^0.4.23;

import "./Int256sStore.sol";


contract Int256sStoreExternal is Int256sStore {
  function createInt256(bytes32 key, int256 value) external returns (bool) {
    return _createInt256(key, value);
  }
  
  function createInt256s(bytes32[] keys, int256[] values) external returns (bool) {
    return _createInt256s(keys, values);
  }
  
  function updateInt256(bytes32 key, int256 value) external returns (bool) {
    return _updateInt256(key, value);   
  }
  
  function updateInt256s(bytes32[] keys, int256[] values) external returns (bool) {
    return _updateInt256s(keys, values);
  }
  
  function removeInt256(bytes32 key) external returns (bool) {
    return _removeInt256(key);
  }
  
  function removeInt256s(bytes32[] keys) external returns (bool) {
    return _removeInt256s(keys);
  }

  function readInt256(bytes32 key) external view returns (int256) {
    return _readInt256(key);
  }
  
  function readInt256s(bytes32[] keys) external view returns (int256[]) {
    return _readInt256s(keys);
  }
}