pragma solidity >=0.4.22;

contract Election {
    // Read/write candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(address => bool) public voters;

    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public candidatesCount;
    // Constructor
    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");    
    }
    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
       emit votedEvent(_candidateId);
    }
    //create candidates
    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    

    event votedEvent (
        uint indexed _candidateId
    );
}