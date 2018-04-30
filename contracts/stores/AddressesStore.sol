pragma solidity 0.4.23;

import "zeppelin-solidity/contracts/ownership/rbac/RBAC.sol";
import "solidity-utils/contracts/FromBytes32.sol";


// simple store
contract AddressesStore {
  mapping (bytes32 => address) private addresses;

  // core functions
  function _createAddress(bytes32 key, address value) internal returns (bool) {
    if (addresses[key] != address(0x0)) return false;

    return _updateAddress(key, value);
  }

  function _createAddresses(bytes32[] keys, address[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
       bool operationSuccess = _createAddress(keys[i], values[i]);
       if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _updateAddress(bytes32 key, address value) internal returns (bool) {
    addresses[key] = value;
    
    return true;
  }

  function _updateAddresses(bytes32[] keys, address[] values) internal returns (bool) {
    if (keys.length != values.length) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _updateAddress(keys[i], values[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _removeAddress(bytes32 key) internal returns (bool) {
    delete addresses[key];
    
    return true;
  }

  function _removeAddresses(bytes32[] keys) internal returns (bool) {
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool operationSuccess = _removeAddress(keys[i]);
      if (success && !operationSuccess) success = false;
    }
    
    return success;
  }

  function _readAddress(bytes32 key) internal view returns (address) {
    return addresses[key];
  }

  function _readAddresses(bytes32[] keys) internal view returns (address[]) {
    address[] memory result = new address[](keys.length);
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readAddress(keys[i]);
    }
    
    return result;
  }
  
  function _readAddresses5(bytes32[] keys) internal view returns (address[5]) {
    address[5] memory result;
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readAddress(keys[i]);
    }
    
    return result;
  }
  
  function _readAddresses10(bytes32[] keys) internal view returns (address[10]) {
    address[10] memory result;
    
    for (uint256 i = 0; i < keys.length; i++) {
      result[i] = _readAddress(keys[i]);
    }
    
    return result;
  }

  // external
  function createAddress(bytes32 key, address value) external returns (bool) {
    return _createAddress(key, value);
  }
  
  function createAddresses(bytes32[] keys, address[] values) external returns (bool) {
    return _createAddresses(keys, values);
  }
  
  function updateAddress(bytes32 key, address value) external returns (bool) {
    return _updateAddress(key, value);   
  }
  
  function updateAddresses(bytes32[] keys, address[] values) external returns (bool) {
    return _updateAddresses(keys, values);
  }
  
  function removeAddress(bytes32 key) external returns (bool) {
    return _removeAddress(key);
  }
  
  function removeAddresses(bytes32[] keys) external returns (bool) {
    return _removeAddresses(keys);
  }

  function readAddress(bytes32 key) external view returns (address) {
    return _readAddress(key);
  }
  
  function readAddresses(bytes32[] keys) external view returns (address[]) {
    return _readAddresses(keys);
  }
  
  function readAddresses5(bytes32[] keys) external view returns (address[5]) {
    return _readAddresses5(keys);
  }
  
  function readAddresses10(bytes32[] keys) external view returns (address[10]) {
    return _readAddresses10(keys);
  }
}