//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract EquiGive {
    using SafeMath for uint256;

    event DonationEvent(address _from, uint256 _ong, uint256 _amount);
    event WithdrawalEvent(uint256 timestamp, uint256 _ong, uint256 _amount);

    address owner;
    Ong[] public ong; //To be filled by a dynamic proposal of ONGs addition in future iterations

    Category[] public categories;
    Region[] public regions;



    mapping(address => Donation[]) public userDonations;
    mapping(address => Questionnaire) public userQuestionnaires;

    uint256 fee = 10; //Means 1% fee
    uint256 constant DIVIDER = 1000;

    uint256 constant MAX_FEE = 100000000000000000; // 0.1 ETH

    uint256 constant THRESHOLD = 26; //Means that ONGs with final score > threshold will be discarded

    struct Donation {
        uint256 ong;
        uint256 amount;
    }
    struct Category {
        string name;
        uint256 amount;
        uint256 qty;
    }
    struct Region {
        string name;
        uint256 amount;
        uint256 qty;
    }
    struct Withdrawal {
        uint256 amount;
        uint256 timestamp;
    }
    struct Ong {
        uint256 id;
        string logo;
        string name;
        uint32 category;
        uint32 region;
        uint256 amount;
        uint256 withdrawn;
        Withdrawal[] withdrawals;
        address owner;
        uint256 qty;
        address payable donationsWallet;
        Questionnaire questionnaire;
    }
    struct Questionnaire {
        uint8 q1;
        uint8 q2;
        uint8 q3;
        uint8 q4;
        uint8 q5;
    }

    constructor() {
        owner = msg.sender;
        categories.push(Category("Children and youth", 0, 0));
        categories.push(Category("Access to health", 0, 0));
        categories.push(Category("Disasters relief", 0, 0));
        categories.push(Category("Animal welfare", 0, 0));
        categories.push(Category("Access to food", 0, 0));
        categories.push(Category("Access to water", 0, 0));
        categories.push(Category("Environment", 0, 0));

        regions.push(Region("Sub-Saharan Africa", 0, 0));
        regions.push(Region("Middle East and North Africa", 0, 0));
        regions.push(Region("South Asia", 0, 0));
        regions.push(Region("Southeast Asia", 0, 0));
        regions.push(Region("Central America and The Caribbean", 0, 0));
        regions.push(Region("South America", 0, 0));


        //TODO
        //Default ONGs for the MVP
    }

    // Owner only
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function setOwner(address _owner) external isOwner {
        owner = _owner;
    }

    function removeCategory(uint32 _category) external isOwner {
        categories[_category] = categories[categories.length - 1];
        categories.pop();
    }

    function addCategory(string calldata _name) external isOwner {
        categories.push(Category(_name, 0, 0));
    }

    function removeRegion(uint32 _region) external isOwner {
        regions[_region] = regions[regions.length - 1];
        regions.pop();
    }

    function addRegion(string calldata _name) external isOwner {
        regions.push(Region(_name, 0, 0));
    }


    function setFee(uint256 _fee) external isOwner {
        require(_fee < DIVIDER, "Fee cannot be more than 100%");
        fee = _fee;
    }
    //End of owner only


    function withdraw(uint256 _amount) external {
        require(_amount > 0, "Amount cannot be 0");
        Ong storage _ong = ong[0];
        uint256 i;
        bool found = false;
        for(i = 0; i < ong.length; i++) {
            if(ong[i].owner == msg.sender) {
                _ong = ong[i];
                found = true;
                break;
            }
        }
        require(found, "ONG not found");
        require(_amount <= _ong.amount.sub(_ong.withdrawn), "Amount cannot be more than available");

        _ong.withdrawn = _ong.withdrawn.add(_amount);
        _ong.withdrawals.push(Withdrawal(_amount, block.timestamp));
        payable(_ong.donationsWallet).transfer(_amount);
        emit WithdrawalEvent(block.timestamp, i, _amount);
    }
    //End of ONG functions




    //Public functions

    function getONGsByFilter(uint32 _category, uint32 _region) public view returns (Ong[] memory, uint256) {
        //TODO ver si funciona bien
        Ong[] memory _ongs = new Ong[](ong.length);
        uint256 _qty = 0;
        for(uint256 i = 0; i < ong.length; i++) {
            if(_category == ong[i].category && _region == ong[i].region) {
                _ongs[_qty] = ong[i];
                _qty++;
            }
        }
        return (_ongs,_qty);
    }

    function deposit(address _donor, uint256 _ong, uint256 _amount) internal {
        ong[_ong].amount = ong[_ong].amount.add(_amount);
        ong[_ong].qty++;

        userDonations[_donor].push(Donation(_ong, _amount));

        emit DonationEvent(_donor, _ong, _amount);
    }

    function donate(Questionnaire calldata _questionnaire, uint32 _category, uint32 _region) external payable {
        require(msg.value > 0, "Amount cannot be 0");

        uint256 _fee = msg.value.mul(fee).div(DIVIDER);
        if(_fee > MAX_FEE) {
            _fee = MAX_FEE;
        }
        uint256 _amount = msg.value.sub(_fee);

        categories[_category].amount = categories[_category].amount.add(_amount);
        categories[_category].qty++;
        regions[_region].amount = regions[_region].amount.add(_amount);
        regions[_region].qty++;

        (Ong[] memory ongs, uint256 cantOngs) = getONGsByFilter(_category, _region);
        uint16 cantOngsToDonate = 0;
        Ong[] memory ongsToDonate = new Ong[](cantOngs);
        uint256[] memory scoresOngsToDonate = new uint256[](cantOngs);
        uint256[] memory originalOngIds = new uint256[](cantOngs);

        uint256 totalScore = 0;

        

        for(uint256 i = 0; i < cantOngs; i++) {
            uint256 finalScore;

            uint256 scoreUser = _questionnaire.q1;
            scoreUser = scoreUser.add(_questionnaire.q2);
            scoreUser = scoreUser.add(_questionnaire.q3);
            scoreUser = scoreUser.add(_questionnaire.q4);
            scoreUser = scoreUser.add(_questionnaire.q5);

            uint256 scoreOng = ongs[i].questionnaire.q1 + ongs[i].questionnaire.q2 + ongs[i].questionnaire.q3 + ongs[i].questionnaire.q4 + ongs[i].questionnaire.q5;
            if(scoreUser > scoreOng) {
                finalScore = scoreUser.sub(scoreOng);
            } else {
                finalScore = scoreOng.sub(scoreUser);
            }
            
            if(finalScore < THRESHOLD) {
                ongsToDonate[cantOngsToDonate] = ongs[i];
                scoresOngsToDonate[cantOngsToDonate] = finalScore;
                totalScore = totalScore.add(finalScore);
                originalOngIds[cantOngsToDonate] = i;
                cantOngsToDonate++;
            }    
        }


        for(uint256 i = 0; i < cantOngsToDonate; i++) {
            uint256 amountToDonate = _amount.mul(scoresOngsToDonate[i]).div(totalScore);
            deposit(msg.sender, originalOngIds[i], amountToDonate);
        }

        userQuestionnaires[msg.sender] = _questionnaire;

        //Pay platform fee
        payable(owner).transfer(_fee);
        
    }

    

    

    



}