// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.16;

contract CoffeeTip {
    address public owner;
    struct Memo {
        address from;
        address to;
        uint amt;
        string name;
        string message;
    }

    mapping(address => Memo[]) public Memos;

    event Sent(address from, address to, uint amt, string name, string message);

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function sendTransaction(
        uint etherAmount,
        address payable _to,
        address payable _from,
        string memory name,
        string memory message
    ) public payable {
        //   (bool sent, bytes memory data) = _to.call{value: etherAmount}("");
        // _to.transfer(etherAmount);
        _to.transfer(etherAmount);

        emit Sent(_from, _to, etherAmount, name, message);

        Memo memory memos = Memo(_from, _to, etherAmount, name, message);

        Memos[_from].push(memos);

        //   require(sent, "Failed to send Ether");
    }
}
