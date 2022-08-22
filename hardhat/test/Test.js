const { time, loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
let json = require("../tree.json");

describe("Test", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.

  describe("Load json", function () {
    it("Print all the json objects", async function () {
      console.log(json["claims"]["0x00E21E550021Af51258060A0E18148e36607C9df"]["proof"]);
      console.log();
    });
  });
});
