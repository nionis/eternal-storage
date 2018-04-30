/* global assert */
const web3Utils = require("web3-utils");
const { getFn, stackedToItems, pluralSuffix } = require("./utils");

const createItem = (store, item, opt = {}) => store[getFn("create", item.type)](item.key, item.value, opt);
const createStackedItem = (store, item, opt = {}) => store[getFn("create", item.type, pluralSuffix(item))](item.keys, item.values, opt);

const updateItem = (store, item, opt = {}) => store[getFn("update", item.type)](item.key, item.value, opt);
const updateStackedItem = (store, item, opt = {}) => store[getFn("update", item.type, pluralSuffix(item))](item.keys, item.values, opt);

const removeItem = (store, item, opt = {}) => store[getFn("remove", item.type)](item.key, opt);
const removeStackedItem = (store, item, opt = {}) => store[getFn("remove", item.type, pluralSuffix(item))](item.keys, opt);

const testItem = async (store, item) => {
  let response = await store[getFn("read", item.type)](item.key);

  if (item.type === "address") response = web3Utils.toChecksumAddress(response);

  // console.log(item.type, response.toString(), item.value);
  assert.equal(response, item.value, `type: ${item.type}`);

  return item;
};
const testStackedItem = async (store, items) => {
  const singleItems = stackedToItems(items);

  return Promise.all(singleItems.map(item => testItem(store, item)));
};

module.exports = {
  testItem,
  testStackedItem,
  createItem,
  createStackedItem,
  updateItem,
  updateStackedItem,
  removeItem,
  removeStackedItem,
};
