/* global describe contract before beforeEach it artifacts */
/* eslint-disable no-unused-vars */
const dummyItems = require("./helpers/dummyItems");
const interactions = require("./helpers/interactions");
const utils = require("./helpers/utils");

const EternalStoreManaged = artifacts.require("EternalStoreManaged");

contract("EternalStoreManaged", accounts => {
  const [owner] = accounts;
  let store;
  let RBACStore;
  let fnStore;
  let keysStore;
  let createFn;
  let updateFn;
  let removeFn;

  const createStore = () => EternalStoreManaged.new(true, true);

  before(async () => {
    store = await createStore();

    const [_RBACStore, _fnStore, _keysStore, _createFn, _updateFn, _removeFn] = await Promise.all([
      store.STORE_RBAC(),
      store.STORE_FUNCTIONS(),
      store.STORE_KEYS(),
      store.FN_ROLE_CREATE(),
      store.FN_ROLE_UPDATE(),
      store.FN_ROLE_REMOVE(),
    ]);
    RBACStore = _RBACStore;
    fnStore = _fnStore;
    keysStore = _keysStore;
    createFn = _createFn;
    updateFn = _updateFn;
    removeFn = _removeFn;
  });

  beforeEach(async () => {
    store = await createStore();
  });

  describe("single", async () => {
    it("create", async () => {
      await Promise.all(dummyItems.singleUniqItems.map(async item => {
        const itemEmpty = utils.toEmpty(item);

        // no permissions
        await interactions.createItem(store, item);
        await interactions.testItem(store, itemEmpty);

        // add function permission
        await store.adminAddRole(fnStore, owner, createFn);
        await interactions.createItem(store, item);
        await interactions.testItem(store, itemEmpty);

        // add key permission
        await store.adminAddRole(keysStore, owner, item.keyStr);
        await interactions.createItem(store, item);
        await interactions.testItem(store, item);
      }));
    });

    it("update", async () => {
      const items = dummyItems.singleDupItems;
      const items0 = [items[0], items[2], items[4], items[6], items[8]];
      const items1 = [items[1], items[3], items[5], items[7], items[9]];

      await Promise.all(items0.map(async (item0, i) => {
        const item1 = items1[i];

        // add permissions & create item
        await store.adminAddRole(fnStore, owner, createFn);
        await store.adminAddRole(keysStore, owner, item0.keyStr);
        await interactions.createItem(store, item0);

        // remove permissions
        await store.adminRemoveRole(fnStore, owner, createFn);
        await store.adminRemoveRole(keysStore, owner, item0.keyStr);

        // no permissions
        await interactions.updateItem(store, item1);
        await interactions.testItem(store, item0);

        // add function permission
        await store.adminAddRole(fnStore, owner, updateFn);
        await interactions.updateItem(store, item1);
        await interactions.testItem(store, item0);

        // add key permission
        await store.adminAddRole(keysStore, owner, item1.keyStr);
        await interactions.updateItem(store, item1);
        await interactions.testItem(store, item1);
      }));
    });

    it("remove", async () => {
      const items = dummyItems.singleUniqItems;

      await Promise.all(items.map(async item => {
        const itemEmpty = utils.toEmpty(item);

        // add permissions & create item
        await store.adminAddRole(fnStore, owner, createFn);
        await store.adminAddRole(keysStore, owner, item.keyStr);
        await interactions.createItem(store, item);

        // remove permissions
        await store.adminRemoveRole(fnStore, owner, createFn);
        await store.adminRemoveRole(keysStore, owner, item.keyStr);

        // no permissions
        await interactions.removeItem(store, item);
        await interactions.testItem(store, item);

        // add function permission
        await store.adminAddRole(fnStore, owner, removeFn);
        await interactions.removeItem(store, item);
        await interactions.testItem(store, item);

        // add key permission
        await store.adminAddRole(keysStore, owner, item.keyStr);
        await interactions.removeItem(store, item);
        await interactions.testItem(store, itemEmpty);
      }));
    });
  });

  describe("multi", async () => {
    it("create", async () => {
      await Promise.all(dummyItems.stackedUniqItems.map(async itemStacked => {
        const itemStackedEmpty = utils.stack(utils.stackedToItems(itemStacked).map(utils.toEmpty))[0];

        // no permissions
        await interactions.createStackedItem(store, itemStacked);
        await interactions.testStackedItem(store, itemStackedEmpty);

        // add function permission
        await store.adminAddRole(fnStore, owner, createFn);
        await interactions.createStackedItem(store, itemStacked);
        await interactions.testStackedItem(store, itemStackedEmpty);

        // add key permission
        await Promise.all(itemStacked.keysStr.map(keyStr => store.adminAddRole(keysStore, owner, keyStr)));
        await interactions.createStackedItem(store, itemStacked);
        await interactions.testStackedItem(store, itemStacked);
      }));
    });

    it("update", async () => {
      const { singleDupItems } = dummyItems;
      const itemsStacked0 = utils.stack([singleDupItems[0], singleDupItems[2], singleDupItems[4], singleDupItems[6], singleDupItems[8]]);
      const itemsStacked1 = utils.stack([singleDupItems[1], singleDupItems[3], singleDupItems[5], singleDupItems[7], singleDupItems[9]]);

      await Promise.all(itemsStacked0.map(async itemStacked0 => {
        // add permissions & create item
        await store.adminAddRole(fnStore, owner, createFn);
        await Promise.all(itemStacked0.keysStr.map(keyStr => store.adminAddRole(keysStore, owner, keyStr)));
        await interactions.createStackedItem(store, itemStacked0);

        // remove permissions
        await store.adminRemoveRole(fnStore, owner, createFn);
        await Promise.all(itemStacked0.keysStr.map(keyStr => store.adminRemoveRole(keysStore, owner, keyStr)));
      }));

      await Promise.all(itemsStacked0.map(async (itemStacked0, i) => {
        const itemStacked1 = itemsStacked1[i];

        // no permissions
        await interactions.updateStackedItem(store, itemStacked1);
        await interactions.testStackedItem(store, itemStacked0);

        // add function permission
        await store.adminAddRole(fnStore, owner, updateFn);
        await interactions.updateStackedItem(store, itemStacked1);
        await interactions.testStackedItem(store, itemStacked0);

        // add key permission
        await Promise.all(itemStacked1.keysStr.map(keyStr => store.adminAddRole(keysStore, owner, keyStr)));
        await interactions.updateStackedItem(store, itemStacked1);
        await interactions.testStackedItem(store, itemStacked1);
      }));
    });

    it("remove", async () => {
      const { singleUniqItems, stackedUniqItems } = dummyItems;
      const singleUniqItemsEmpty = singleUniqItems.map(utils.toEmpty);
      const stackedUniqItemsEmpty = utils.stack(singleUniqItemsEmpty);

      await Promise.all(stackedUniqItems.map(async itemStacked => {
        // add permissions & create item
        await store.adminAddRole(fnStore, owner, createFn);
        await Promise.all(itemStacked.keysStr.map(keyStr => store.adminAddRole(keysStore, owner, keyStr)));
        await interactions.createStackedItem(store, itemStacked);

        // remove permissions
        await store.adminRemoveRole(fnStore, owner, createFn);
        await Promise.all(itemStacked.keysStr.map(keyStr => store.adminRemoveRole(keysStore, owner, keyStr)));
      }));

      await Promise.all(stackedUniqItems.map(async (itemStacked0, i) => {
        const itemStackedEmpty = stackedUniqItemsEmpty[i];

        // no permissions
        await interactions.removeStackedItem(store, itemStackedEmpty);
        await interactions.testStackedItem(store, itemStacked0);

        // add function permission
        await store.adminAddRole(fnStore, owner, removeFn);
        await interactions.removeStackedItem(store, itemStackedEmpty);
        await interactions.testStackedItem(store, itemStacked0);

        // add key permission
        await Promise.all(itemStackedEmpty.keysStr.map(keyStr => store.adminAddRole(keysStore, owner, keyStr)));
        await interactions.removeStackedItem(store, itemStackedEmpty);
        await interactions.testStackedItem(store, itemStackedEmpty);
      }));
    });
  });
});
