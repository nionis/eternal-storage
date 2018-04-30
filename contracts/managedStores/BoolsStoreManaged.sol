pragma solidity 0.4.23;

import "../stores/BoolsStore.sol";
import "../StoreProtections.sol";


// admin has total power
contract BoolsStoreManaged is BoolsStore, StoreProtectionFunctions, StoreProtectionKeys {
  bool constant public FN_PROTECTION = true;
  bool constant public KEY_PROTECTION = true;
  
  function createBool(bytes32 key, bool value) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    if (KEY_PROTECTION && !canCreateKey(key)) return false;
    
    return super._createBool(key, value);
  }

  function createBools(bytes32[] keys, bool[] values) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canCreateKey(keys[i]);
      
      if (allowed) super._createBool(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateBool(bytes32 key, bool value) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    if (KEY_PROTECTION && !canUpdateKey(key)) return false;
    
    return super._updateBool(key, value);
  }
  
  function updateBools(bytes32[] keys, bool[] values) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canUpdateKey(keys[i]);
      
      if (allowed) super._updateBool(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeBool(bytes32 key) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    if (KEY_PROTECTION && !canRemoveKey(key)) return false;
    
    return super._removeBool(key);
  }
  
  function removeBools(bytes32[] keys) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canRemoveKey(keys[i]);
      
      if (allowed) super._removeBool(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}