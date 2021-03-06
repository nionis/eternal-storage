pragma solidity ^0.4.23;


contract BoolsStore {
  mapping (bytes32 => bool) private bools;

  function _createBool(bytes32 key, bool value) internal returns (bool) {
    if (bools[key]) return false;

    return _updateBool(key, value);
  }

  function _createBools(bytes32[] keys, bool[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _createBool(keys[i], values[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _updateBool(bytes32 key, bool value) internal returns (bool) {
    bools[key] = value;
    
    return true;
  }

  function _updateBools(bytes32[] keys, bool[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _updateBool(keys[i], values[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _removeBool(bytes32 key) internal returns (bool) {
    delete bools[key];
    
    return true;
  }

  function _removeBools(bytes32[] keys) internal returns (bool) {
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _removeBool(keys[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _readBool(bytes32 key) internal view returns (bool) {
    return bools[key];
  }

  function _readBools(bytes32[] keys) internal view returns (bool[]) {
    bool[] memory result = new bool[](keys.length);
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readBool(keys[i]);
    }
    
    return result;
  }
}