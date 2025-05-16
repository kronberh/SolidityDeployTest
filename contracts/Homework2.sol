// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Homework2 {
    struct PollOption {
        uint id;
        string text;
    }

    struct Poll {
        uint id;
        string subject;
        address publisher;
        PollOption[] options;
        mapping(address => PollOption) votes;
        address[] voters;
    }

    struct PollView {
        uint id;
        string subject;
        address publisher;
        PollOption[] options;
    }

    Poll[] polls;
    uint pollIdCounter = 0;

    function getPolls() public view returns(PollView[] memory) {
        PollView[] memory result = new PollView[](polls.length);
        for (uint i = 0; i < polls.length; i++) {
            result[i].id = polls[i].id;
            result[i].subject = polls[i].subject;
            result[i].publisher = polls[i].publisher;
            result[i].options = polls[i].options;
        }
        return result;
    }

    function getPoll(uint pollId) public view returns(PollView memory) {
        for (uint i = 0; i < polls.length; i++) {
            if (polls[i].id == pollId) {
                PollView memory result = PollView(
                    polls[i].id,
                    polls[i].subject,
                    polls[i].publisher,
                    polls[i].options
                );
                return result;
            }
        }
        revert('Invalid id');
    }

    function getVotes(uint pollId) public view returns(PollOption[] memory) {
        for (uint i = 0; i < polls.length; i++) {
            if (polls[i].id == pollId) {
                PollOption[] memory votes = new PollOption[](polls[i].voters.length);
                for (uint j = 0; j < polls[i].voters.length; j++) {
                    votes[j] = polls[i].votes[polls[i].voters[j]];
                }
                return votes;
            }
        }
        revert('Invalid id');
    }

    function vote(uint pollId, uint optionId) public {
        for (uint i = 0; i < polls.length; i++) {
            if (polls[i].id == pollId) {
                for (uint j = 0; j < polls[i].options.length; j++) {
                    if (polls[i].options[j].id == optionId) {
                        polls[i].votes[msg.sender] = polls[i].options[j];
                        int voterIndex = -1;
                        for (uint k = 0; k < polls[i].voters.length; k++) {
                            if (polls[i].voters[k] == msg.sender) {
                                voterIndex = int(k);
                                break;
                            }
                        }
                        if (voterIndex != -1) {
                            polls[i].voters.push(msg.sender);
                        }
                    }
                }
                revert('Invalid option id');
            }
        }
        revert('Invalid poll id');
    }

    function addPoll(string memory subject, string[] memory options) public returns(uint) {
        pollIdCounter++;
        polls.push();
        polls[polls.length - 1].id = pollIdCounter;
        polls[polls.length - 1].subject = subject;
        polls[polls.length - 1].publisher = msg.sender;
        for (uint i = 0; i < options.length; i++) {
            polls[polls.length - 1].options.push(PollOption(i + 1, options[i]));
        }
        return pollIdCounter;
    }
}
