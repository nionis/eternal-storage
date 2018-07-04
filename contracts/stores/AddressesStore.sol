pragma solidity 0.4.23;


contract AddressesStore {
  mapping (bytes32 => address) private addresses;

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
}