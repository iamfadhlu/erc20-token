// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployToken} from "../script/DeployToken.s.sol";


contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployToken public deployer;

    address Bob = makeAddr("Bob");
    address Alice = makeAddr("Alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployToken();
        ourToken = deployer.run();
        vm.prank(msg.sender);
        ourToken.transfer(Bob, STARTING_BALANCE);
    }
    function testBobBalance() public {
        // Check the balance of Bob using the balanceOf function
        assertEq(STARTING_BALANCE, ourToken.balanceOf(Bob));
    }
    function testAllowanceWorks() public {
        // Arrange
        uint256 initialAllowance = 10 ether;
        uint256 transferAmount = 5 ether;
        // Bob approves Alice to spend his tokens
        vm.prank(Bob);
        ourToken.approve(Alice, initialAllowance);

        // Act
        vm.prank(Alice);
        ourToken.transferFrom(Bob, Alice, transferAmount);

        // Assert
        assertEq(ourToken.balanceOf(Alice), transferAmount);
        assertEq(ourToken.balanceOf(Bob), STARTING_BALANCE - transferAmount);
    }
    function testTransferFailsInsufficientBalance() public {
        // Arrange - Bob tries to transfer more than he has
        uint256 invalidAmount = STARTING_BALANCE + 1 ether;

        // Act / Assert
        vm.prank(Bob);
        vm.expectRevert();
        ourToken.transfer(Alice, invalidAmount);
    }

    function testTransferFromFailsInsufficientAllowance() public {
        // Arrange
        uint256 initialAllowance = 10 ether;
        uint256 transferAmount = 20 ether;
        
        vm.prank(Bob);
        ourToken.approve(Alice, initialAllowance);

        // Act / Assert
        vm.prank(Alice);
        vm.expectRevert();
        ourToken.transferFrom(Bob, Alice, transferAmount);
    }

    function testApprovalWorks() public {
        // Arrange
        uint256 amount = 100 ether;

        // Act
        vm.prank(Bob);
        ourToken.approve(Alice, amount);

        // Assert
        assertEq(ourToken.allowance(Bob, Alice), amount);
    }

    function testTransferWorks() public {
        // Arrange
        uint256 transferAmount = 50 ether;

        // Act
        vm.prank(Bob);
        ourToken.transfer(Alice, transferAmount);

        // Assert
        assertEq(ourToken.balanceOf(Alice), transferAmount);
        assertEq(ourToken.balanceOf(Bob), STARTING_BALANCE - transferAmount);
    }

}