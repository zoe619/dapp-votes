pragma solidity ^0.5.16;

contract Election
{
    // string public candidate;

// model a candidate
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    // store accounts that have voted
    mapping(address => bool) public voters;
    // Fetch candidates
    mapping(uint => Candidate ) public candidates;

    // store candidates counts
    uint public candidateCount;

    // create event to listen to a vote event
    event votedEvent(
        uint indexed _candidateId
    );

    constructor() public
    {
        // add a candidate anytime contract is deployed on network
        addCandidates("Candidate 1");
        addCandidates("Candidate 2");
    }

    // store candidates
    function addCandidates(string memory _name) private
    {
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, _name, 0);
    }
    // voting
    function vote(uint _candidateId) public
    {
        // require that voter has not voted before
        require(!voters[msg.sender]);

        // require that voting is made to a ligit candidate
        require(_candidateId > 0 && _candidateId <= candidateCount);

        // record that this account has voted
        // msg.sender is the voters address
        voters[msg.sender] = true;
        // update candidates vote count
        candidates[_candidateId].voteCount++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }


}