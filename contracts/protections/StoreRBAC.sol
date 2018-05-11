pragma solidity 0.4.23;


contract StoreRBAC {
  // stores: storeName -> key -> addr -> isAllowed
  mapping(string => mapping (bytes32 => mapping(address => bool))) private stores;

  // store names
  string public constant STORE_RBAC = "rbac";
  string public constant STORE_FUNCTIONS = "functions";
  string public constant STORE_KEYS = "keys";
  // rbac roles
  bytes32 public constant RBAC_ROLE_ADMIN = 0x61646d696e000000000000000000000000000000000000000000000000000000; // "admin"

  // events
  event RoleAdded(string storeName, address addr, bytes32 role);
  event RoleRemoved(string storeName, address addr, bytes32 role);

  constructor() public {
    addRole(STORE_RBAC, msg.sender, RBAC_ROLE_ADMIN);
  }

  function hasRole(string storeName, address addr, bytes32 role) public view returns (bool) {
    return stores[storeName][role][addr];
  }

  function checkRole(string storeName, address addr, bytes32 role) public view {
    require(hasRole(storeName, addr, role));
  }

  function addRole(string storeName, address addr, bytes32 role) internal {
    stores[storeName][role][addr] = true;

    emit RoleAdded(storeName, addr, role);
  }

  function removeRole(string storeName, address addr, bytes32 role) internal {
    stores[storeName][role][addr] = false;

    emit RoleRemoved(storeName, addr, role);
  }

  function adminAddRole(string storeName, address addr, bytes32 role) onlyAdmin public {
    addRole(storeName, addr, role);
  }

  function adminRemoveRole(string storeName, address addr, bytes32 role) onlyAdmin public {
    removeRole(storeName, addr, role);
  }

  modifier onlyRole(string storeName, bytes32 role) {
    checkRole(storeName, msg.sender, role);
    _;
  }

  modifier onlyAdmin() {
    checkRole(STORE_RBAC, msg.sender, RBAC_ROLE_ADMIN);
    _;
  }
}