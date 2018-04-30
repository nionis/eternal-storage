pragma solidity 0.4.23;

import "solidity-utils/contracts/FromBytes32.sol";


// simple store
contract Uint256sStore {
  mapping (bytes32 => uint256) private uint256s;

  // core functions
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
  
  function _readUint256s5(bytes32[] keys) internal view returns (uint256[5]) {
    uint256[5] memory result;
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readUint256(keys[i]);
    }
    
    return result;
  }
  
  function _readUint256s10(bytes32[] keys) internal view returns (uint256[10]) {
    uint256[10] memory result;
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readUint256(keys[i]);
    }
    
    return result;
  }

  // external
  function createUint256(bytes32 key, uint256 value) external returns (bool) {
    return _createUint256(key, value);
  }
  
  function createUint256s(bytes32[] keys, uint256[] values) external returns (bool) {
    return _createUint256s(keys, values);
  }
  
  function updateUint256(bytes32 key, uint256 value) external returns (bool) {
    return _updateUint256(key, value);   
  }
  
  function updateUint256s(bytes32[] keys, uint256[] values) external returns (bool) {
    return _updateUint256s(keys, values);
  }
  
  function removeUint256(bytes32 key) external returns (bool) {
    return _removeUint256(key);
  }
  
  function removeUint256s(bytes32[] keys) external returns (bool) {
    return _removeUint256s(keys);
  }

  function readUint256(bytes32 key) external view returns (uint256) {
    return _readUint256(key);
  }
  
  function readUint256s(bytes32[] keys) external view returns (uint256[]) {
    return _readUint256s(keys);
  }
  
  function readUint256s5(bytes32[] keys) external view returns (uint256[5]) {
    return _readUint256s5(keys);
  }
  
  function readUint256s10(bytes32[] keys) external view returns (uint256[10]) {
    return _readUint256s10(keys);
  }
}