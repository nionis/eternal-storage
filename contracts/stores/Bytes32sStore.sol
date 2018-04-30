pragma solidity 0.4.23;

import "zeppelin-solidity/contracts/ownership/rbac/RBAC.sol";
import "solidity-utils/contracts/FromBytes32.sol";


// simple store
contract Bytes32sStore {
  mapping (bytes32 => bytes32) private bytes32s;

  // core functions
  function _createBytes32(bytes32 key, bytes32 value) internal returns (bool) {
    if (bytes32s[key] != bytes32(0x0)) return false;

    return _updateBytes32(key, value);
  }

  function _createBytes32s(bytes32[] keys, bytes32[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
       bool operationSuccess = _createBytes32(keys[i], values[i]);
       if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _updateBytes32(bytes32 key, bytes32 value) internal returns (bool) {
    bytes32s[key] = value;
    
    return true;
  }

  function _updateBytes32s(bytes32[] keys, bytes32[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _updateBytes32(keys[i], values[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _removeBytes32(bytes32 key) internal returns (bool) {
    delete bytes32s[key];
    
    return true;
  }

  function _removeBytes32s(bytes32[] keys) internal returns (bool) {
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _removeBytes32(keys[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _readBytes32(bytes32 key) internal view returns (bytes32) {
    return bytes32s[key];
  }

  function _readBytes32s(bytes32[] keys) internal view returns (bytes32[]) {
    bytes32[] memory result = new bytes32[](keys.length);
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readBytes32(keys[i]);
    }
    
    return result;
  }
  
  function _readBytes32s5(bytes32[] keys) internal view returns (bytes32[5]) {
    bytes32[5] memory result;
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readBytes32(keys[i]);
    }
    
    return result;
  }
  
  function _readBytes32s10(bytes32[] keys) internal view returns (bytes32[10]) {
    bytes32[10] memory result;
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readBytes32(keys[i]);
    }
    
    return result;
  }

  // external
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
  
  function readBytes32s5(bytes32[] keys) external view returns (bytes32[5]) {
    return _readBytes32s5(keys);
  }
  
  function readBytes32s10(bytes32[] keys) external view returns (bytes32[10]) {
    return _readBytes32s10(keys);
  }
}