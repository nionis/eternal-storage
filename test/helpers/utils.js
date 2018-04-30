const getFn = (prefix, type, suffix = "") => `${prefix}${type.charAt(0).toUpperCase() + type.slice(1)}${suffix}`;
const pluralSuffix = item => (item.type === "address" ? "es" : "s");

// convert stack items to single item
const stackedToItems = items =>
  items.keys.map((o, i) => ({
    type: items.type,
    key: items.keys[i],
    keyStr: items.keysStr[i],
    value: items.values[i],
  }));

// convert item to empty item
const toEmpty = item => {
  const newItem = Object.assign({}, item);

  const value = (() => {
    const { type } = newItem;

    if (type === "bool") return false;
    else if (type === "uint256" || type === "int256") return 0;
    else if (type === "bytes32") return "0x0000000000000000000000000000000000000000000000000000000000000000";
    else if (type === "address") return "0x0000000000000000000000000000000000000000";
  })();

  newItem.value = value;

  return newItem;
};

// convert items to stacked items
const stack = items => {
  const grouped = items.reduce((obj, item) => {
    if (!obj[item.type]) {
      obj[item.type] = {
        type: item.type,
        keys: [],
        keysStr: [],
        values: [],
      };
    }

    obj[item.type].keys.push(item.key);
    obj[item.type].keysStr.push(item.keyStr);
    obj[item.type].values.push(item.value);

    return obj;
  }, {});

  return Object.values(grouped);
};

module.exports = {
  getFn,
  pluralSuffix,
  stackedToItems,
  toEmpty,
  stack,
};
