pragma solidity 0.4.23;

import "./BoolsStore.sol";


contract BoolsStoreExternal is BoolsStore {
  function createBool(bytes32 key, bool value) external returns (bool) {
    return _createBool(key, value);
  }
  
  function createBools(bytes32[] keys, bool[] values) external returns (bool) {
    return _createBools(keys, values);
  }
  
  function updateBool(bytes32 key, bool value) external returns (bool) {
    return _updateBool(key, value);   
  }
  
  function updateBools(bytes32[] keys, bool[] values) external returns (bool) {
    return _updateBools(keys, values);
  }
  
  function removeBool(bytes32 key) external returns (bool) {
    return _removeBool(key);
  }
  
  function removeBools(bytes32[] keys) external returns (bool) {
    return _removeBools(keys);
  }

  function readBool(bytes32 key) external view returns (bool) {
    return _readBool(key);
  }
  
  function readBools(bytes32[] keys) external view returns (bool[]) {
    return _readBools(keys);
  }
}