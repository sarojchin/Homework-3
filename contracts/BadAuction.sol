pragma solidity ^0.4.15;

import "./AuctionInterface.sol";

/** @title BadAuction */
contract BadAuction is AuctionInterface {
	/* Bid function, vulnerable to attack
	 * Must return true on successful send and/or bid,
	 * bidder reassignment
	 * Must return false on failure and send people
	 * their funds back
	 */
	 
	//modifier hasEnough() { require(msg.sender.send(msg.value)); _;}
	function bid() payable external returns (bool) {
			if (msg.value <= highestBid) {
				if (!msg.sender.send(msg.value)) {
					throw;
				}
			return false;
		}

		if (!highestBidder.send(highestBid)) {
			if (!msg.sender.send(msg.value)) {
				throw;
			}
			return false;
		}

		highestBidder = msg.sender;
		highestBid = msg.value;

	}

	/* Give people their funds back */
	function () payable {
		msg.sender.transfer(msg.value);
	}
}
