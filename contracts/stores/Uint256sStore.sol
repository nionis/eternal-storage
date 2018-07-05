pragma solidity ^0.4.23;


contract Uint256sStore {
  mapping (bytes32 => uint256) private uint256s;

  function _createUint256(bytes32 key, uint256 value) internal returns (bool) {
    if (uint256s[key] > 0) return false;

    return _updateUint256(key, value);
  }

  function _createUint256s(bytes32[] keys, uint256[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _createUint256(keys[i], values[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _updateUint256(bytes32 key, uint256 value) internal returns (bool) {
    uint256s[key] = value;
    
    return true;
  }

  function _updateUint256s(bytes32[] keys, uint256[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _updateUint256(keys[i], values[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _removeUint256(bytes32 key) internal returns (bool) {
    delete uint256s[key];
    
    return true;
  }

  function _removeUint256s(bytes32[] keys) internal returns (bool) {
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _removeUint256(keys[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _readUint256(bytes32 key) internal view returns (uint256) {
    return uint256s[key];
  }

  function _readUint256s(bytes32[] keys) internal view returns (uint256[]) {
    uint256[] memory result = new uint256[](keys.length);
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readUint256(keys[i]);
    }
    
    return result;
  }
}