pragma solidity 0.4.23;

import "../stores/AddressesStore.sol";
import "../protections/FullProtection.sol";


contract AddressesStoreManaged is AddressesStore, FullProtection {
  bool public fnProtection = true;
  bool public keyProtection = true;

  constructor(bool _fnProtection, bool _keyProtection) public {
    fnProtection = _fnProtection;
    keyProtection = _keyProtection;
  }

  function createAddress(bytes32 key, address value) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    if (keyProtection && !canCreateKey(key)) return false;
    
    return super._createAddress(key, value);
  }

  function createAddresses(bytes32[] keys, address[] values) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canCreateKey(keys[i]);
      
      if (allowed) super._createAddress(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateAddress(bytes32 key, address value) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    if (keyProtection && !canUpdateKey(key)) return false;
    
    return super._updateAddress(key, value);
  }
  
  function updateAddresses(bytes32[] keys, address[] values) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canUpdateKey(keys[i]);
      
      if (allowed) super._updateAddress(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeAddress(bytes32 key) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    if (keyProtection && !canRemoveKey(key)) return false;
    
    return super._removeAddress(key);
  }
  
  function removeAddresses(bytes32[] keys) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canRemoveKey(keys[i]);
      
      if (allowed) super._removeAddress(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}