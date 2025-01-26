// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {DutchAuction} from "./DutchAuction.sol";
import {SafeTransferLib} from "solady/src/utils/SafeTransferLib.sol";
import {IBnbStrategy} from "./DutchAuction.sol";
contract BondAuction is DutchAuction {

    struct Bond {
      uint128 amount;
      uint128 price;
      uint64 startRedemption;
    }

    error UnredeemedBond();
    error NoBondToRedeem();
    error RedemptionWindowNotStarted();
    error RedemptionWindowPassed();
    error NoBondToWithdraw();
    mapping(address => Bond) public bonds;
    uint256 public constant REDEMPTION_WINDOW = 1 days;

    constructor(address _bnbStrategy, address _governor, address _paymentToken) DutchAuction(_bnbStrategy, _governor, _paymentToken) {}

    function _fill(uint128 amount, uint128 price, uint64 startTime, uint64 duration) internal override {
        super._fill(amount, price, startTime, duration);
        if(bonds[msg.sender].startRedemption != 0) {
          revert UnredeemedBond();
        }
        SafeTransferLib.safeTransferFrom(paymentToken, msg.sender, address(this), amount * price);
        bonds[msg.sender] = Bond({
          amount: amount,
          price: price,
          startRedemption: startTime + duration
        });
    }

    function redeem() external {
      _redeem();
    }

    function _redeem() internal {
      Bond memory bond = bonds[msg.sender];
      if(bond.startRedemption == 0) {
        revert NoBondToRedeem();
      }
      uint256 currentTime = block.timestamp;
      if(currentTime < bond.startRedemption) {
        revert RedemptionWindowNotStarted();
      }
      if(currentTime > bond.startRedemption + REDEMPTION_WINDOW) {
        revert RedemptionWindowPassed();
      }
      delete bonds[msg.sender];
      SafeTransferLib.safeTransfer(paymentToken, owner(), bond.amount * bond.price);
      IBnbStrategy(bnbStrategy).mint(msg.sender, bond.amount);
    }

    function withdraw() external {
      _withdraw();
    }

    function _withdraw() internal {
      Bond memory bond = bonds[msg.sender];
      if(bond.startRedemption == 0) {
        revert NoBondToWithdraw();
      }
      uint256 currentTime = block.timestamp;
      if(currentTime < bond.startRedemption) {
        revert RedemptionWindowNotStarted();
      }
      SafeTransferLib.safeTransfer(paymentToken, msg.sender, bond.amount * bond.price);
      delete bonds[msg.sender];
    }
}

