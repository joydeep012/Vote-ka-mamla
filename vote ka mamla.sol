// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VoteKaMamla {
    // Contract owner (who deploys)
    address public owner;

    // Candidate structure
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store candidates and voters
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    // Track total number of candidates
    uint public candidatesCount;

    // Events for logging
    event CandidateAdded(uint id, string name);
    event Voted(address voter, uint candidateId);

    // Constructor sets the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier: only owner can do certain actions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this");
        _;
    }

    // Add a candidate (only owner)
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    // Vote for a candidate
    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;

        emit Voted(msg.sender, _candidateId);
    }

    // Get total votes of a candidate
    function getVotes(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");
        return candidates[_candidateId].voteCount;
    }
}

