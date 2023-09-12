// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Voting {
    struct Voter {
        bool voted;
        uint vote;
    }

    mapping(address => Voter) public voters;
    mapping(uint => uint) public voteCounts;

    uint[] public proposals;

    constructor(uint[] memory _proposals) {
        proposals = _proposals;
    }

    function vote(uint proposal) public {
        require(!voters[msg.sender].voted, "Already voted.");
        require(proposal < proposals.length, "Invalid proposal.");

        voters[msg.sender].voted = true;
        voters[msg.sender].vote = proposal;

        voteCounts[proposal]++;
    }

    function winningProposal() public view returns (uint) {
        uint winningVoteCount = 0;
        uint winningProposalIndex = 0;

        for (uint i = 0; i < proposals.length; i++) {
            if (voteCounts[proposals[i]] > winningVoteCount) {
                winningVoteCount = voteCounts[proposals[i]];
                winningProposalIndex = i;
            }
        }

        return proposals[winningProposalIndex];
    }
}