/* global describe contract beforeEach it artifacts */
const dummyItems = require("./helpers/dummyItems");
const interactions = require("./helpers/interactions");
const utils = require("./helpers/utils");

const EternalStoreExternal = artifacts.require("EternalStoreExternal");

contract("EternalStoreExternal", () => {
  let store;

  beforeEach(async () => {
    store = await EternalStoreExternal.new();
  });

  describe("single", async () => {
    it("create", async () => {
      const items = dummyItems.singleUniqItems;

      await Promise.all(items.map(async item => {
        await interactions.createItem(store, item);
        await interactions.testItem(store, item);
      }));
    });

    it("create twice", async () => {
      const items = dummyItems.singleDupItems;
      const items0 = [items[0], items[2], items[4], items[6], items[8]];
      const items1 = [items[1], items[3], items[5], items[7], items[9]];

      await Promise.all(items0.map(async (item0, i) => {
        const item1 = items1[i];

        await interactions.createItem(store, item0);

        await interactions.createItem(store, item1);
        await interactions.testItem(store, item0);
      }));
    });

    it("update", async () => {
      const items = dummyItems.singleDupItems;
      const items0 = [items[0], items[2], items[4], items[6], items[8]];
      const items1 = [items[1], items[3], items[5], items[7], items[9]];

      await Promise.all(items0.map(async item => {
        await interactions.createItem(store, item);
      }));
      await Promise.all(items1.map(async item => {
        await interactions.updateItem(store, item);
        await interactions.testItem(store, item);
      }));
    });

    it("remove", async () => {
      const items = dummyItems.singleUniqItems;
      const itemsEmpty = items.map(utils.toEmpty);

      await Promise.all(items.map(async item => {
        await interactions.createItem(store, item);
        await interactions.removeItem(store, item);
      }));
      await Promise.all(itemsEmpty.map(async item => {
        await interactions.testItem(store, item);
      }));
    });
  });

  describe("multi", async () => {
    it("create", async () => {
      const stackedItems = dummyItems.stackedUniqItems;

      await Promise.all(stackedItems.map(async item => {
        await interactions.createStackedItem(store, item);
        await interactions.testStackedItem(store, item);
      }));
    });

    it("update", async () => {
      const { singleDupItems } = dummyItems;
      const itemsStacked0 = utils.stack([singleDupItems[0], singleDupItems[2], singleDupItems[4], singleDupItems[6], singleDupItems[8]]);
      const itemsStacked1 = utils.stack([singleDupItems[1], singleDupItems[3], singleDupItems[5], singleDupItems[7], singleDupItems[9]]);

      await Promise.all(itemsStacked0.map(async item => {
        await interactions.createStackedItem(store, item);
      }));
      await Promise.all(itemsStacked1.map(async item => {
        await interactions.updateStackedItem(store, item);
        await interactions.testStackedItem(store, item);
      }));
    });

    it("remove", async () => {
      const { singleUniqItems, stackedUniqItems } = dummyItems;
      const singleUniqItemsEmpty = singleUniqItems.map(utils.toEmpty);
      const stackedUniqItemsEmpty = utils.stack(singleUniqItemsEmpty);

      await Promise.all(stackedUniqItems.map(async item => {
        await interactions.createStackedItem(store, item);
        await interactions.removeStackedItem(store, item);
      }));
      await Promise.all(stackedUniqItemsEmpty.map(async item => {
        await interactions.testStackedItem(store, item);
      }));
    });
  });
});
