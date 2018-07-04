pragma solidity 0.4.23;

import "../stores/Uint256sStoreExternal.sol";
import "../protections/FullProtection.sol";


contract Uint256sStoreManaged is Uint256sStoreExternal, FullProtection {
  bool public fnProtection = true;
  bool public keyProtection = true;

  constructor(bool _fnProtection, bool _keyProtection) public {
    fnProtection = _fnProtection;
    keyProtection = _keyProtection;
  }

  function createUint256(bytes32 key, uint256 value) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    if (keyProtection && !canCreateKey(key)) return false;
    
    return super._createUint256(key, value);
  }

  function createUint256s(bytes32[] keys, uint256[] values) external returns (bool) {
    if (fnProtection && !canCreate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canCreateKey(keys[i]);
      
      if (allowed) super._createUint256(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function updateUint256(bytes32 key, uint256 value) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    if (keyProtection && !canUpdateKey(key)) return false;
    
    return super._updateUint256(key, value);
  }
  
  function updateUint256s(bytes32[] keys, uint256[] values) external returns (bool) {
    if (fnProtection && !canUpdate()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canUpdateKey(keys[i]);
      
      if (allowed) super._updateUint256(keys[i], values[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }

  function removeUint256(bytes32 key) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    if (keyProtection && !canRemoveKey(key)) return false;
    
    return super._removeUint256(key);
  }
  
  function removeUint256s(bytes32[] keys) external returns (bool) {
    if (fnProtection && !canRemove()) return false;
    
    bool success = true;
    
    for (uint256 i = 0; i < keys.length; i++) {
      bool allowed = !keyProtection || canRemoveKey(keys[i]);
      
      if (allowed) super._removeUint256(keys[i]);
      else if (success && !allowed) success = false;
    }
    
    return success;
  }
}