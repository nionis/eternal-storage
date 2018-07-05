pragma solidity ^0.4.23;

import "../stores/Bytes32sStoreExternal.sol";
import "../protections/FullProtection.sol";


contract Bytes32sStoreManaged is Bytes32sStoreExternal, FullProtection {
  bool public fnProtection = true;
  bool public keyProtection = true;

  constructor(bool _fnProtection, bool _keyProtection) public {
    fnProtection = _fnProtection;
    keyProtection = _keyProtection;
  }

  function createBytes32(bytes32 key, bytes32 value) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    if (keyProtection && !canCreateKey(key)) return false;
    
    return super._createBytes32(key, value);
  }

  function createBytes32s(bytes32[] keys, bytes32[] values) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canCreateKey(keys[i]);
      
      if (allowed) super._createBytes32(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateBytes32(bytes32 key, bytes32 value) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    if (keyProtection && !canUpdateKey(key)) return false;
    
    return super._updateBytes32(key, value);
  }
  
  function updateBytes32s(bytes32[] keys, bytes32[] values) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canUpdateKey(keys[i]);
      
      if (allowed) super._updateBytes32(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeBytes32(bytes32 key) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    if (keyProtection && !canRemoveKey(key)) return false;
    
    return super._removeBytes32(key);
  }
  
  function removeBytes32s(bytes32[] keys) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canRemoveKey(keys[i]);
      
      if (allowed) super._removeBytes32(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}