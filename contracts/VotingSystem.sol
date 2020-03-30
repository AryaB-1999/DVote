pragma solidity >=0.4.25;
pragma experimental ABIEncoderV2;


contract VotingSystem {
    uint256[] voteBallot;
    uint256 noOfVoters = 0;
    uint256 noOfCandidates;
    uint256 voterID;

    struct voter {
        string name;
        string publicKey;
        string password;
        uint256 voteTo;
    }

    function init(uint256 noOfC) public returns (bool) {
        voteBallot = new uint256[](noOfC);
        noOfCandidates = noOfC;
        noOfVoters = 100;
        return true;
    }

    mapping(uint256 => voter) voters;

    function setDetails(string memory n, string memory pass, string memory pk)
        public
        returns (uint256 vID)
    {
        voterID = noOfVoters;
        noOfVoters = noOfVoters + 1;
        voters[voterID].name = n;
        voters[voterID].publicKey = pk;
        voters[voterID].password = pass;
        return voterID;
    }

    function castVote(uint256 voterIDNum, uint256 to)
        public
        returns (bool ret)
    {
        if (to > 0 && to <= noOfCandidates) {
            voters[voterIDNum].voteTo = to;
            voteBallot[to]++;
            return true;
        } else {
            return false;
        }
    }

    function getDetails(uint256 voterIDNum)
        public
        view
        returns (voter memory v)
    {
        return voters[voterIDNum];
    }

    function getCount() public view returns (uint256[] memory vB) {
        return voteBallot;
    }
}
