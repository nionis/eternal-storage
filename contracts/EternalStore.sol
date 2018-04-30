pragma solidity 0.4.23;

import "./stores/AddressesStore.sol";
import "./stores/BoolsStore.sol";
import "./stores/Bytes32sStore.sol";
import "./stores/Int256sStore.sol";
import "./stores/Uint256sStore.sol";


contract EternalStore is AddressesStore, BoolsStore, Bytes32sStore, Int256sStore, Uint256sStore {}