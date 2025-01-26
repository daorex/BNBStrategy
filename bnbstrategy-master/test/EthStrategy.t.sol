pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BaseTest} from "./utils/BaseTest.t.sol";
import {BnbStrategy} from "../../src/BnbStrategy.sol";
import {Ownable} from "solady/src/auth/OwnableRoles.sol";
contract BnbStrategyTest is BaseTest {
  function test_constructor_success() public {
    BnbStrategy bnbStrategy = new BnbStrategy(address(governor));
    assertEq(bnbStrategy.owner(), address(governor), "governor not assigned correctly");
  }

  function test_mint_success() public {
    BnbStrategy bnbStrategy = new BnbStrategy(address(governor));
    vm.startPrank(address(governor));
    bnbStrategy.mint(address(alice), 100e18);
    assertEq(bnbStrategy.balanceOf(address(alice)), 100e18, "balance not assigned correctly");
  }

  function test_mint_revert_unauthorized() public {
    BnbStrategy bnbStrategy = new BnbStrategy(address(governor));
    vm.expectRevert(Ownable.Unauthorized.selector);
    bnbStrategy.mint(address(alice), 100e18);
  }

  function test_mint_success_with_role() public {
    BnbStrategy bnbStrategy = new BnbStrategy(address(governor));
    address admin = address(1);
    uint8 role = bnbStrategy.MINTER_ROLE();
    vm.prank(address(governor));
    bnbStrategy.grantRoles(admin, role);
    vm.prank(admin);
    bnbStrategy.mint(address(alice), 100e18);
    assertEq(bnbStrategy.balanceOf(address(alice)), 100e18, "balance not assigned correctly");
  }

  function test_name_success() public {
    BnbStrategy bnbStrategy = new BnbStrategy(address(governor));
    assertEq(bnbStrategy.name(), "BnbStrategy", "name not assigned correctly");
  }

  function test_symbol_success() public {
    BnbStrategy bnbStrategy = new BnbStrategy(address(governor));
    assertEq(bnbStrategy.symbol(), "BSTR", "symbol not assigned correctly");
  }
}
