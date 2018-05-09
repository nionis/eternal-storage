pragma solidity 0.4.23;

import "./StoreRBAC.sol";


// store protection keys
contract KeyProtection is StoreRBAC {
  function canCreateKey(bytes32 key) internal view returns (bool) {
    return hasRole(STORE_KEYS, msg.sender, key);
  }
  
  function canUpdateKey(bytes32 key) internal view returns (bool) {
    return hasRole(STORE_KEYS, msg.sender, key);
  }
  
  function canRemoveKey(bytes32 key) internal view returns (bool) {
    return hasRole(STORE_KEYS, msg.sender, key);
  }
}