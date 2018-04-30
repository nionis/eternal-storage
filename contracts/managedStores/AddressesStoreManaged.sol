pragma solidity 0.4.23;

import "../stores/AddressesStore.sol";
import "../StoreProtections.sol";


// admin has total power
contract AddressesStoreManaged is AddressesStore, StoreProtectionFunctions, StoreProtectionKeys {
  bool constant public FN_PROTECTION = true;
  bool constant public KEY_PROTECTION = true;
  
  function createAddress(bytes32 key, address value) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    if (KEY_PROTECTION && !canCreateKey(key)) return false;
    
    return super._createAddress(key, value);
  }

  function createAddresses(bytes32[] keys, address[] values) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canCreateKey(keys[i]);
      
      if (allowed) super._createAddress(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateAddress(bytes32 key, address value) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    if (KEY_PROTECTION && !canUpdateKey(key)) return false;
    
    return super._updateAddress(key, value);
  }
  
  function updateAddresses(bytes32[] keys, address[] values) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canUpdateKey(keys[i]);
      
      if (allowed) super._updateAddress(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeAddress(bytes32 key) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    if (KEY_PROTECTION && !canRemoveKey(key)) return false;
    
    return super._removeAddress(key);
  }
  
  function removeAddresses(bytes32[] keys) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canRemoveKey(keys[i]);
      
      if (allowed) super._removeAddress(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}