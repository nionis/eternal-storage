pragma solidity 0.4.23;

import "../stores/BoolsStore.sol";
import "../protections/FullProtection.sol";


contract BoolsStoreManaged is BoolsStore, FullProtection {
  bool public fnProtection = true;
  bool public keyProtection = true;

  function BoolsStoreManaged(bool _fnProtection, bool _keyProtection) public {
    fnProtection = _fnProtection;
    keyProtection = _keyProtection;
  }

  function createBool(bytes32 key, bool value) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    if (keyProtection && !canCreateKey(key)) return false;
    
    return super._createBool(key, value);
  }

  function createBools(bytes32[] keys, bool[] values) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canCreateKey(keys[i]);
      
      if (allowed) super._createBool(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateBool(bytes32 key, bool value) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    if (keyProtection && !canUpdateKey(key)) return false;
    
    return super._updateBool(key, value);
  }
  
  function updateBools(bytes32[] keys, bool[] values) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canUpdateKey(keys[i]);
      
      if (allowed) super._updateBool(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeBool(bytes32 key) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    if (keyProtection && !canRemoveKey(key)) return false;
    
    return super._removeBool(key);
  }
  
  function removeBools(bytes32[] keys) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canRemoveKey(keys[i]);
      
      if (allowed) super._removeBool(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}