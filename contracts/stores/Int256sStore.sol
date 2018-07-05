pragma solidity ^0.4.23;


contract Int256sStore {
  mapping (bytes32 => int256) private int256s;

  function _createInt256(bytes32 key, int256 value) internal returns (bool) {
    if (int256s[key] > 0) return false;

    return _updateInt256(key, value);
  }

  function _createInt256s(bytes32[] keys, int256[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
       bool operationSuccess = _createInt256(keys[i], values[i]);
       if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _updateInt256(bytes32 key, int256 value) internal returns (bool) {
    int256s[key] = value;
    
    return true;
  }

  function _updateInt256s(bytes32[] keys, int256[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _updateInt256(keys[i], values[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _removeInt256(bytes32 key) internal returns (bool) {
    delete int256s[key];
    
    return true;
  }

  function _removeInt256s(bytes32[] keys) internal returns (bool) {
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _removeInt256(keys[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _readInt256(bytes32 key) internal view returns (int256) {
    return int256s[key];
  }

  function _readInt256s(bytes32[] keys) internal view returns (int256[]) {
    int256[] memory result = new int256[](keys.length);
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readInt256(keys[i]);
    }
    
    return result;
  }
}