pragma solidity ^0.4.23;

import "./Uint256sStore.sol";


contract Uint256sStoreExternal is Uint256sStore {
  function createUint256(bytes32 key, uint256 value) external returns (bool) {
    return _createUint256(key, value);
  }
  
  function createUint256s(bytes32[] keys, uint256[] values) external returns (bool) {
    return _createUint256s(keys, values);
  }
  
  function updateUint256(bytes32 key, uint256 value) external returns (bool) {
    return _updateUint256(key, value);   
  }
  
  function updateUint256s(bytes32[] keys, uint256[] values) external returns (bool) {
    return _updateUint256s(keys, values);
  }
  
  function removeUint256(bytes32 key) external returns (bool) {
    return _removeUint256(key);
  }
  
  function removeUint256s(bytes32[] keys) external returns (bool) {
    return _removeUint256s(keys);
  }

  function readUint256(bytes32 key) external view returns (uint256) {
    return _readUint256(key);
  }
  
  function readUint256s(bytes32[] keys) external view returns (uint256[]) {
    return _readUint256s(keys);
  }
}