//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract EquiGive {
    using SafeMath for uint256;

    event DonationEvent(address _from, uint256 _ong, uint256 _amount);
    event WithdrawalEvent(uint256 timestamp, uint256 _ong, uint256 _amount);

    address owner;
    Ong[] public ong; //To be filled by a dynamic proposal of ONGs addition in future iterations

    Category[] public categories; //To be updateable in future iterations
    Region[] public regions; //To be updateable in future iterations



    mapping(address => Donation[]) public userDonations;
    mapping(address => DonationPackage[]) private userDonationPackages;
    mapping(address => Questionnaire) public userQuestionnaires;

    uint256 fee = 10; //Means 1% fee  To be updateable in future iterations
    uint256 constant DIVIDER = 1000;

    uint256 constant MAX_FEE = 100000000000000000; // 0.1 ETH

    uint256 constant THRESHOLD = 26; //Means that ONGs with final score > threshold will be discarded

    struct Donation {
        uint256 ong;
        uint256 amount;
    }
    struct DonationPackage {
        uint256 id;
        Donation[] donations;
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
        categories.push(Category("Affordable housing", 0, 0));

        regions.push(Region("Sub-Saharan Africa", 0, 0));
        regions.push(Region("Middle East and North Africa", 0, 0));
        regions.push(Region("South Asia", 0, 0));
        regions.push(Region("Southeast Asia", 0, 0));
        regions.push(Region("Central America and The Caribbean", 0, 0));
        regions.push(Region("South America", 0, 0));


        
        //Default ONGs for the MVP
        ong.push();
        ong[0].id = 0;
        ong[0].logo = "https://i.ibb.co/crvvYcP/Untitled-design-7.png";
        ong[0].name = "Bright Futures for Children";
        ong[0].category = 0;
        ong[0].region = 0;
        ong[0].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[0].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[0].questionnaire = Questionnaire(1, 2, 5, 4, 3);

        ong.push();
        ong[1].id = 1;
        ong[1].logo = "https://i.ibb.co/X2rNCwZ/Untitled-design-6.png";
        ong[1].name = "Youth Empowerment Foundation";
        ong[1].category = 0;
        ong[1].region = 1;
        ong[1].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[1].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[1].questionnaire = Questionnaire(3, 1, 5, 4, 2);

        ong.push();
        ong[2].id = 2;
        ong[2].logo = "https://i.ibb.co/Yysc3hz/Untitled-design-5.png";
        ong[2].name = "Access Health Now";
        ong[2].category = 1;
        ong[2].region = 2;
        ong[2].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[2].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[2].questionnaire = Questionnaire(5, 1, 3, 4, 2);

        ong.push();
        ong[3].id = 3;
        ong[3].logo = "https://i.ibb.co/DDMmdBf/Untitled-design-2.png";
        ong[3].name = "Disaster Response Alliance";
        ong[3].category = 2;
        ong[3].region = 0;
        ong[3].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[3].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[3].questionnaire = Questionnaire(5, 5, 1, 1, 4);

        ong.push();
        ong[4].id = 4;
        ong[4].logo = "https://i.ibb.co/2NBH7fR/Untitled-design-3.png";
        ong[4].name = "Animal Rights United";
        ong[4].category = 2;
        ong[4].region = 3;
        ong[4].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[4].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[4].questionnaire = Questionnaire(2, 5, 1, 4, 3);

        ong.push();
        ong[5].id = 5;
        ong[5].logo = "https://i.ibb.co/MRz90Z1/Untitled-design-1.png";
        ong[5].name = "Food for All";
        ong[5].category = 4;
        ong[5].region = 4;
        ong[5].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[5].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[5].questionnaire = Questionnaire(4, 2, 3, 1, 5);

        ong.push();
        ong[6].id = 6;
        ong[6].logo = "https://i.ibb.co/DMxgpnh/Untitled-design.png";
        ong[6].name = "Water for Life Initiative";
        ong[6].category = 5;
        ong[6].region = 5;
        ong[6].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[6].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[6].questionnaire = Questionnaire(3, 4, 1, 5, 2);

        ong.push();
        ong[7].id = 7;
        ong[7].logo = "https://i.ibb.co/LnKmZYB/Untitled-design-4.png";
        ong[7].name = "Environmental Advocacy Network";
        ong[7].category = 6;
        ong[7].region = 1;
        ong[7].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[7].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[7].questionnaire = Questionnaire(2, 3, 5, 4, 1);

        ong.push();
        ong[8].id = 8;
        ong[8].logo = "https://i.ibb.co/crvvYcP/Untitled-design-7.png";
        ong[8].name = "Community Action Network";
        ong[8].category = 3;
        ong[8].region = 2;
        ong[8].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[8].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[8].questionnaire = Questionnaire(2, 4, 5, 1, 3);

        ong.push();
        ong[9].id = 9;
        ong[9].logo = "https://i.ibb.co/X2rNCwZ/Untitled-design-6.png";
        ong[9].name = "Global Education Fund";
        ong[9].category = 4;
        ong[9].region = 1;
        ong[9].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[9].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[9].questionnaire = Questionnaire(5, 3, 2, 4, 1);

        ong.push();
        ong[10].id = 10;
        ong[10].logo = "https://i.ibb.co/Yysc3hz/Untitled-design-5.png";
        ong[10].name = "Eco-Friendly Solutions";
        ong[10].category = 5;
        ong[10].region = 0;
        ong[10].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[10].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[10].questionnaire = Questionnaire(1, 5, 2, 4, 3);

        ong.push();
        ong[11].id = 11;
        ong[11].logo = "https://i.ibb.co/DDMmdBf/Untitled-design-2.png";
        ong[11].name = "Children's Rights Advocacy Group";
        ong[11].category = 0;
        ong[11].region = 2;
        ong[11].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[11].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[11].questionnaire = Questionnaire(4, 3, 1, 5, 2);

        ong.push();
        ong[12].id = 12;
        ong[12].logo = "https://i.ibb.co/2NBH7fR/Untitled-design-3.png";
        ong[12].name = "Clean Oceans Alliance";
        ong[12].category = 6;
        ong[12].region = 3;
        ong[12].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[12].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[12].questionnaire = Questionnaire(4, 2, 1, 5, 3);

        ong.push();
        ong[13].id = 13;
        ong[13].logo = "https://i.ibb.co/MRz90Z1/Untitled-design-1.png";
        ong[13].name = "Global Education Fund";
        ong[13].category = 7;
        ong[13].region = 4;
        ong[13].owner = 0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC;
        ong[13].donationsWallet = payable(0xE2546d516DaA7bbBBa423Da11BE4294b711b1CCC);
        ong[13].questionnaire = Questionnaire(3, 1, 5, 4, 2);

    }

    function getRegions() public view returns (Region[] memory) {
        return regions;
    }

    function getCategories() public view returns (Category[] memory) {
        return categories;
    }

    // Owner only
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    //End of owner only


    function withdraw(uint256 _amount, uint256 _ongId) external {
        require(_amount > 0, "Amount cannot be 0");
        require(_ongId < ong.length, "ONG not found");
        require(ong[_ongId].owner == msg.sender, "Caller is not ONG owner");
        Ong storage _ong = ong[_ongId];  
        require(_amount <= _ong.amount.sub(_ong.withdrawn), "Amount cannot be more than available");
        
              

        _ong.withdrawn = _ong.withdrawn.add(_amount);
        _ong.withdrawals.push(Withdrawal(_amount, block.timestamp));
        payable(_ong.donationsWallet).transfer(_amount);
        emit WithdrawalEvent(block.timestamp, _ongId, _amount);
    }
    //End of ONG functions

    function getUserDonationsCount(address _user) public view returns (uint256) {
        return userDonations[_user].length;
    }
    function getUserDonationsPackagesCount(address _user) public view returns (uint256) {
        return userDonationPackages[_user].length;
    }
    function getUserDonationPackages(address _user, uint256 _index) public view returns (DonationPackage memory) {
        require(_index < userDonationPackages[_user].length, "Index out of range");
        return userDonationPackages[_user][_index];
    }




    //Public functions

    function getONGsByFilter(uint32 _category, uint32 _region) public view returns (Ong[] memory, uint256) {
        //Calcular tamaño del resultado
        uint256 _qty = 0;
        for(uint256 i = 0; i < ong.length; i++) {
            if(_category == ong[i].category && _region == ong[i].region) {
                _qty++;
            }
        }

        Ong[] memory _ongs = new Ong[](_qty);
        _qty = 0;
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

        userDonationPackages[_donor][userDonationPackages[_donor].length - 1].donations.push(userDonations[_donor][userDonations[_donor].length - 1]);

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
        uint256[] memory scoresOngsToDonate = new uint256[](cantOngs);

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
            finalScore = uint256(25).sub(finalScore);
            
            scoresOngsToDonate[i] = finalScore;
            totalScore = totalScore.add(finalScore);

            //Next iteration threshold para evitar donar a muy pequeñas coincidencias
        }

        userDonationPackages[msg.sender].push(); //New donation package
        userDonationPackages[msg.sender][userDonationPackages[msg.sender].length - 1].id = userDonationPackages[msg.sender].length - 1;



        for(uint256 i = 0; i < cantOngs; i++) {
            uint256 amountToDonate = _amount.mul(scoresOngsToDonate[i]).div(totalScore);
            deposit(msg.sender, ongs[i].id, amountToDonate);
        }

        userQuestionnaires[msg.sender] = _questionnaire;

        //Pay platform fee
        payable(owner).transfer(_fee);
        
    }

    

    

    



}