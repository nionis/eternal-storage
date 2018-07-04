pragma solidity 0.4.23;

import "../stores/Int256sStoreExternal.sol";
import "../protections/FullProtection.sol";


contract Int256sStoreManaged is Int256sStoreExternal, FullProtection {
  bool public fnProtection = true;
  bool public keyProtection = true;

  constructor(bool _fnProtection, bool _keyProtection) public {
    fnProtection = _fnProtection;
    keyProtection = _keyProtection;
  }

  function createInt256(bytes32 key, int256 value) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    if (keyProtection && !canCreateKey(key)) return false;
    
    return super._createInt256(key, value);
  }

  function createInt256s(bytes32[] keys, int256[] values) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canCreateKey(keys[i]);
      
      if (allowed) super._createInt256(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateInt256(bytes32 key, int256 value) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    if (keyProtection && !canUpdateKey(key)) return false;
    
    return super._updateInt256(key, value);
  }
  
  function updateInt256s(bytes32[] keys, int256[] values) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canUpdateKey(keys[i]);
      
      if (allowed) super._updateInt256(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeInt256(bytes32 key) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    if (keyProtection && !canRemoveKey(key)) return false;
    
    return super._removeInt256(key);
  }
  
  function removeInt256s(bytes32[] keys) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canRemoveKey(keys[i]);
      
      if (allowed) super._removeInt256(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}