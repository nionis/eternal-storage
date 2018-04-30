pragma solidity 0.4.23;

import "../stores/Bytes32sStore.sol";
import "../StoreProtections.sol";


// admin has total power
contract Bytes32sStoreManaged is Bytes32sStore, StoreProtectionFunctions, StoreProtectionKeys {
  bool constant public FN_PROTECTION = true;
  bool constant public KEY_PROTECTION = true;
  
  function createBytes32(bytes32 key, bytes32 value) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    if (KEY_PROTECTION && !canCreateKey(key)) return false;
    
    return super._createBytes32(key, value);
  }

  function createBytes32s(bytes32[] keys, bytes32[] values) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canCreateKey(keys[i]);
      
      if (allowed) super._createBytes32(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateBytes32(bytes32 key, bytes32 value) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    if (KEY_PROTECTION && !canUpdateKey(key)) return false;
    
    return super._updateBytes32(key, value);
  }
  
  function updateBytes32s(bytes32[] keys, bytes32[] values) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canUpdateKey(keys[i]);
      
      if (allowed) super._updateBytes32(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeBytes32(bytes32 key) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    if (KEY_PROTECTION && !canRemoveKey(key)) return false;
    
    return super._removeBytes32(key);
  }
  
  function removeBytes32s(bytes32[] keys) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canRemoveKey(keys[i]);
      
      if (allowed) super._removeBytes32(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}