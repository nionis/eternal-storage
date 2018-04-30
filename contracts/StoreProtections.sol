pragma solidity 0.4.23;

import "solidity-utils/contracts/FromString.sol";
import "./StoreRBAC.sol";


// store protection functions
contract StoreProtectionFunctions is StoreRBAC { 
  // standard roles
  bytes32 constant public FN_ROLE_CREATE = FromString.toBytes32("create");
  bytes32 constant public FN_ROLE_UPDATE = FromString.toBytes32("update");
  bytes32 constant public FN_ROLE_REMOVE = FromString.toBytes32("remove");

  function canCreate() internal view returns (bool) {
    return hasRole(STORE_FUNCTIONS, msg.sender, FN_ROLE_CREATE);
  }
  
  function canUpdate() internal view returns (bool) {
    return hasRole(STORE_FUNCTIONS, msg.sender, FN_ROLE_UPDATE);
  }
  
  function canRemove() internal view returns (bool) {
    return hasRole(STORE_FUNCTIONS, msg.sender, FN_ROLE_REMOVE);
  }
}


// store protection keys
contract StoreProtectionKeys is StoreRBAC {
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