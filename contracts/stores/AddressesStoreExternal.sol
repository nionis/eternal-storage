pragma solidity ^0.4.23;

import "./AddressesStore.sol";


contract AddressesStoreExternal is AddressesStore {
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
}