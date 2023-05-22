// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7;

contract Ballot {
    struct Voter {
        /*
        This declares a new complex type which will be
        used for variables later. It will represent a single voter.
        */
        uint weight; // weight is accumulated by delegation
        bool voted; // if true, that person already voted
        address delegate; // person delegated to
        uint vote; // index of the voted proposal
    }

    // this is type of single proposal.
    struct Proposal {
        bytes32 name; // short name (upto 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairperson;

    // this declares a state variable that 
    // stores a 'Voter' sturct for each possible address.
    mapping(address => Voter) public voters;

    Proposal[] public proposals;

    // A dynamically-sized array of `Proposal` structs
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function giveRightToVote(address voter) external {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote"
        );
        require(
            !voters[voter].voted,
            "The voter already voted"
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    function delegate(address to) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "You habe no right to vote");
        require(!sender.voted, "You have already voted");

        require(to != msg.sender, "Self-delegation is disallowed");

        while(voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            require(to != msg.sender, "Found loop in delegation");
        }
        
        Voter storage delegate_ = voters[to];

        require(delegate_.weight >= 1);

        sender.voted = true;
        sender.delegate = to;

        if(delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        }
        else {
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view
        returns (uint winningProposal_) 
    {
            uint winningVoteCount = 0;
            for (uint p = 0; p < proposals.length; p++) {
                if (proposals[p].voteCount > winningVoteCount) {
                    winningVoteCount = proposals[p].voteCount;
                    winningProposal_ = p;
                }
            }
        }

    function winnerName() external view
        returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}