pragma solidity ^0.4.18;

contract signUp {

    uint8 numberOfMembers; // 총 제품의 수입니다.
    address contractOwner;

    struct memberStruct {
        string userID;
        string password;
        string email;
        uint timestamp;
    }

    memberStruct[] public members;
    event isval(bool dupl);

    constructor() public {
        contractOwner = msg.sender;
    }
    function addMember (string _firstString, string _secondString, string _thirdString) public {
        bool isdupl = false;
        for(uint i = 0; i < numberOfMembers; i++)
        {
            if(keccak256(members[i].userID) == keccak256(_firstString))
                isdupl = true;
        }
        if(!isdupl)
        {
            emit isval(true);
            members.push(memberStruct(_firstString,_secondString,_thirdString, now)) -1;
            numberOfMembers++;
        }
        else
        {
            emit isval(false);
        }
    }

    //제품 등록의 수를 리턴합니다.
    function getNumOfMembers() public view returns(uint8) {
        return numberOfMembers;
    }

    //번호에 해당하는 제품의 이름을 리턴합니다.
    function getmeberStruct(uint _index) public view returns (string, string, string,uint) {
        return (members[_index].userID, members[_index].password, members[_index].email, members[_index].timestamp);
    }

    //컨트랙트를 삭제합니다.
    function killContract() public {
        if(contractOwner == msg.sender)
            selfdestruct(contractOwner);
    }
}
