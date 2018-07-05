pragma solidity ^0.4.23;

import "./managedStores/AddressesStoreManaged.sol";
import "./managedStores/BoolsStoreManaged.sol";
import "./managedStores/Bytes32sStoreManaged.sol";
import "./managedStores/Int256sStoreManaged.sol";
import "./managedStores/Uint256sStoreManaged.sol";


contract EternalStoreManaged is AddressesStoreManaged, BoolsStoreManaged, Bytes32sStoreManaged, Int256sStoreManaged, Uint256sStoreManaged {
  constructor(bool _fnProtection, bool _keyProtection) public
  AddressesStoreManaged(_fnProtection, _keyProtection)
  BoolsStoreManaged(_fnProtection, _keyProtection)
  Bytes32sStoreManaged(_fnProtection, _keyProtection)
  Int256sStoreManaged(_fnProtection, _keyProtection)
  Uint256sStoreManaged(_fnProtection, _keyProtection)
  {
    fnProtection = _fnProtection;
    keyProtection = _keyProtection;
  }
}