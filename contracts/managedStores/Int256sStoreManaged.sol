pragma solidity 0.4.23;

import "../stores/Int256sStore.sol";
import "../StoreProtections.sol";


// admin has total power
contract Int256sStoreManaged is Int256sStore, StoreProtectionFunctions, StoreProtectionKeys {
  bool constant public FN_PROTECTION = true;
  bool constant public KEY_PROTECTION = true;
  
  function createInt256(bytes32 key, int256 value) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    if (KEY_PROTECTION && !canCreateKey(key)) return false;
    
    return super._createInt256(key, value);
  }

  function createInt256s(bytes32[] keys, int256[] values) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canCreateKey(keys[i]);
      
      if (allowed) super._createInt256(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateInt256(bytes32 key, int256 value) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    if (KEY_PROTECTION && !canUpdateKey(key)) return false;
    
    return super._updateInt256(key, value);
  }
  
  function updateInt256s(bytes32[] keys, int256[] values) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canUpdateKey(keys[i]);
      
      if (allowed) super._updateInt256(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeInt256(bytes32 key) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    if (KEY_PROTECTION && !canRemoveKey(key)) return false;
    
    return super._removeInt256(key);
  }
  
  function removeInt256s(bytes32[] keys) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canRemoveKey(keys[i]);
      
      if (allowed) super._removeInt256(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}