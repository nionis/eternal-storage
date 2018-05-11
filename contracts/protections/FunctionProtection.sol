pragma solidity 0.4.23;

import "./StoreRBAC.sol";


// store protection functions
contract FunctionProtection is StoreRBAC { 
  // standard roles
  bytes32 constant public FN_ROLE_CREATE = 0x6372656174650000000000000000000000000000000000000000000000000000; // create
  bytes32 constant public FN_ROLE_UPDATE = 0x7570646174650000000000000000000000000000000000000000000000000000; // update
  bytes32 constant public FN_ROLE_REMOVE = 0x72656d6f76650000000000000000000000000000000000000000000000000000; // remove

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