pragma solidity 0.4.23;

import "../stores/Uint256sStore.sol";
import "../StoreProtections.sol";


// admin has total power
contract Uint256sStoreManaged is Uint256sStore, StoreProtectionFunctions, StoreProtectionKeys {
  bool constant public FN_PROTECTION = true;
  bool constant public KEY_PROTECTION = true;
  
  function createUint256(bytes32 key, uint256 value) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    if (KEY_PROTECTION && !canCreateKey(key)) return false;
    
    return super._createUint256(key, value);
  }

  function createUint256s(bytes32[] keys, uint256[] values) external returns (bool) {
    if (FN_PROTECTION && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canCreateKey(keys[i]);
      
      if (allowed) super._createUint256(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateUint256(bytes32 key, uint256 value) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    if (KEY_PROTECTION && !canUpdateKey(key)) return false;
    
    return super._updateUint256(key, value);
  }
  
  function updateUint256s(bytes32[] keys, uint256[] values) external returns (bool) {
    if (FN_PROTECTION && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canUpdateKey(keys[i]);
      
      if (allowed) super._updateUint256(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeUint256(bytes32 key) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    if (KEY_PROTECTION && !canRemoveKey(key)) return false;
    
    return super._removeUint256(key);
  }
  
  function removeUint256s(bytes32[] keys) external returns (bool) {
    if (FN_PROTECTION && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !KEY_PROTECTION || canRemoveKey(keys[i]);
      
      if (allowed) super._removeUint256(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}