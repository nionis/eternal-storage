const { stack } = require("./utils");

const createItem = (obj, keyStr) => {
  const keys = [
    {
      keyStr: "a",
      key: "0x6100000000000000000000000000000000000000000000000000000000000000",
    },
    {
      keyStr: "b",
      key: "0x6200000000000000000000000000000000000000000000000000000000000000",
    },
  ];
  const key = keys.find(_key => _key.keyStr === keyStr);
  if (!key) throw Error("key for item not found");

  return Object.assign({}, obj, key);
};

const singleUniqItems = [
  createItem({ type: "bool", value: true }, "a"),
  createItem({ type: "bool", value: true }, "b"),
  createItem({ type: "uint256", value: 1337 }, "a"),
  createItem({ type: "uint256", value: 666 }, "b"),
  createItem({ type: "int256", value: -1337 }, "a"),
  createItem({ type: "int256", value: -666 }, "b"),
  createItem({ type: "bytes32", value: "0x1000000000000000000000000000000000000000000000000000000000000000" }, "a"),
  createItem({ type: "bytes32", value: "0x2000000000000000000000000000000000000000000000000000000000000000" }, "b"),
  createItem({ type: "address", value: "0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c" }, "a"),
  createItem({ type: "address", value: "0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C" }, "b"),
];

const singleDupItems = singleUniqItems.map(item => createItem(item, item.keyStr));

const stackedUniqItems = stack(singleUniqItems);

const stackedDupItems = stack(singleDupItems);

module.exports = {
  singleUniqItems,
  singleDupItems,
  stackedUniqItems,
  stackedDupItems,
};
