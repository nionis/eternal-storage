pragma solidity ^0.4.23;

import "./stores/AddressesStoreExternal.sol";
import "./stores/BoolsStoreExternal.sol";
import "./stores/Bytes32sStoreExternal.sol";
import "./stores/Int256sStoreExternal.sol";
import "./stores/Uint256sStoreExternal.sol";


contract EternalStoreExternal is AddressesStoreExternal, BoolsStoreExternal, Bytes32sStoreExternal, Int256sStoreExternal, Uint256sStoreExternal {}