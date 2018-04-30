pragma solidity 0.4.23;

import "./managedStores/AddressesStoreManaged.sol";
import "./managedStores/BoolsStoreManaged.sol";
import "./managedStores/Bytes32sStoreManaged.sol";
import "./managedStores/Int256sStoreManaged.sol";
import "./managedStores/Uint256sStoreManaged.sol";


contract EternalStoreManaged is AddressesStoreManaged, BoolsStoreManaged, Bytes32sStoreManaged, Int256sStoreManaged, Uint256sStoreManaged {
  bool constant public FN_PROTECTION = true;
  bool constant public KEY_PROTECTION = true;
}