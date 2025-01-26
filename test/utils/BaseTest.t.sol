pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {AtmAuction} from "../../src/AtmAuction.sol";
import {BnbStrategy} from "../../src/BnbStrategy.sol";
import {BnbStrategyGovernor, IVotes} from "../../src/BnbStrategyGovernor.sol";
import {USDCToken} from "./USDCToken.sol";
import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";
import {console} from "forge-std/console.sol";

interface IERC20 {
  function mint(address to, uint256 amount) external;
  function approve(address spender, uint256 amount) external;
}

contract BaseTest is Test {
  BnbStrategy bnbStrategy;
  BnbStrategyGovernor governor;
  USDCToken usdcToken;
  Account initialOwner;
  Account admin1;
  Account admin2;

  address alice;
  address bob;
  address charlie;

  function setUp() public virtual {
    initialOwner = makeAccount("initialOwner");
    admin1 = makeAccount("admin1");
    admin2 = makeAccount("admin2");
    address[] memory admins = new address[](2);
    admins[0] = admin1.addr;
    admins[1] = admin2.addr;
    vm.label(initialOwner.addr, "initialOwner");
    vm.label(admin1.addr, "admin1");
    vm.label(admin2.addr, "admin2");

    usdcToken = new USDCToken();

    bnbStrategy = new BnbStrategy(initialOwner.addr);
    vm.prank(initialOwner.addr);
    governor = new BnbStrategyGovernor(IVotes(address(bnbStrategy)), 4, 7200, 50400, 0);

    vm.prank(initialOwner.addr);
    bnbStrategy.transferOwnership(address(governor));
    alice = address(1);
    vm.label(alice, "alice");
    bob = address(2);
    vm.label(bob, "bob");
    charlie = address(3);
    vm.label(charlie, "charlie");
  }

  function mintAndApprove(address _to, uint256 _amount, address spender, address _token) public {
    IERC20(_token).mint(_to, _amount);
    vm.prank(_to);
    IERC20(_token).approve(spender, _amount);
  }

  function calculateFillPrice(uint64 _startTime, uint64 _duration, uint128 _startPrice, uint128 _endPrice, uint64 _currentTime) public pure returns (uint128) {
    uint64 delta_t = _duration - (_currentTime - _startTime);
    uint128 delta_p = _startPrice - _endPrice;
    return uint128(((delta_p * delta_t) / _duration) + _endPrice);
  }
}
